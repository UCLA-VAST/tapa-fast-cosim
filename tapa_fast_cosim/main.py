import argparse
import logging
import json
import os
import re

from collections import defaultdict
from pkg_resources import get_distribution
from typing import *

from .common import AXI
from .templates import *
from .vivado import get_vivado_tcl
from .config_preprocess import preprocess_config

[logging.root.removeHandler(handler) for handler in logging.root.handlers]
logging.basicConfig(
    level=logging.INFO,
    format=
    '[%(levelname)s:%(name)s:%(lineno)d] %(message)s',
    datefmt='%m%d %H:%M:%S',
)

_logger = logging.getLogger().getChild(__name__)


def parse_register_addr(ctrl_unit_path: str) -> Dict[str, List[str]]:
  """
  parse the comments in s_axi_control.v to get the register addresses for each argument
  """
  ctrl_unit = open(ctrl_unit_path, 'r').readlines()
  comments = [line for line in ctrl_unit if line.strip().startswith('//')]

  arg_to_reg_addrs = defaultdict(list)
  for line in comments:
    if ' 0x' in line and 'Data signal' in line:
      match = re.search(r'(0x\w+) : Data signal of (\w+)', line)
      signal = match.group(2)
      addr = match.group(1)
      arg_to_reg_addrs[signal].append(addr.replace('0x', '\'h'))

  return dict(arg_to_reg_addrs)


def parse_m_axi_interfaces(top_rtl_path: str) -> List[AXI]:
  """
  parse the top RTL to extract all m_axi interfaces, the data width and addr width
  """
  top_rtl = open(top_rtl_path, 'r').read()

  match_addr = re.findall(r'output\s+\[(.*):\s*0\s*\]\s+m_axi_(\w+)_ARADDR\s*[;,]', top_rtl)
  match_data = re.findall(r'output\s+\[(.*):\s*0\s*\]\s+m_axi_(\w+)_WDATA\s*[;,]', top_rtl)

  # the width may contain parameters
  params = re.findall(r'parameter\s+(\S+)\s*=\s+(\S+)\s*;', top_rtl)
  param_to_value = {name: val for name, val in params}

  axi_list = []
  name_to_addr_width = {m_axi: addr_width for addr_width, m_axi in match_addr}
  for data_width, m_axi in match_data:
    addr_width = name_to_addr_width[m_axi]

    # substitute the parameters
    for name, val in param_to_value.items():
      data_width = data_width.replace(name, val)
      addr_width = addr_width.replace(name, val)

    axi_list.append(AXI(m_axi, eval(data_width)+1, eval(addr_width)+1))
  return axi_list


def get_cosim_tb(top_name: str, s_axi_control_path: str, axi_list: List[AXI], scalar_to_val: Dict[str, str]) -> str:
  """
  generate a lightweight testbench to test the HLS RTL
  """
  arg_to_reg_addrs = parse_register_addr(s_axi_control_path)

  tb = ''
  tb += get_begin() + '\n'

  for axi in axi_list:
    tb += get_axi_ram_inst(axi) + '\n'

  tb += get_s_axi_control() + '\n'

  tb += get_dut(top_name, axi_list) + '\n'

  tb += get_test_signals(arg_to_reg_addrs, scalar_to_val, axi_list)

  tb += get_end() + '\n'

  return tb


def set_default_nettype(verilog_path):
  """
  Sometimes the HLS-generated RTL will directly assign constants to IO ports
  But Vivado does not allow this behaviour. We need to set the `default_nettype
  to wire to bypass this issue.
  """
  _logger.info('append `default_nettype wire to every RTL file')
  for file in os.listdir(verilog_path):
    if file.endswith('.v') or file.endswith('.sv'):
      abs_path = os.path.join(verilog_path, file)
      with open(abs_path, 'r+') as f:
          content = f.read()
          f.seek(0, 0)
          f.write('`default_nettype wire\n' + content)


if __name__ == '__main__':
  parser = argparse.ArgumentParser()
  parser.add_argument('--config_path', type=str, required=True)
  parser.add_argument('--tb_output_dir', type=str, required=True)
  parser.add_argument('--launch_simulation', action='store_true')
  parser.add_argument('--print_debug_info', action='store_true')
  parser.add_argument('--save_waveform', action='store_true')
  parser.add_argument('--start_gui', action='store_true')
  args = parser.parse_args()

  __version__ = get_distribution('tapa_fast_cosim').version
  _logger.info('TAPA fast cosim version: %s', __version__)

  config = preprocess_config(args.config_path, args.tb_output_dir)

  top_name = config['top_name']
  verilog_path = config['verilog_path']
  top_path = f'{verilog_path}/{top_name}.v'
  ctrl_path = f'{verilog_path}/{top_name}_control_s_axi.v'

  # add default nettype to all rtl
  set_default_nettype(verilog_path)

  axi_list = parse_m_axi_interfaces(top_path)
  tb = get_cosim_tb(top_name, ctrl_path, axi_list, config['scalar_to_val'])

  # generate test bench RTL files
  os.system(f'mkdir -p {args.tb_output_dir}')
  os.system(f'rm -f {args.tb_output_dir}/*.bin')
  open(f'{args.tb_output_dir}/tb.v', 'w').write(tb)
  open(f'{args.tb_output_dir}/fifo_srl_tb.v', 'w').write(get_srl_fifo_template())

  for axi in axi_list:
    source_data_path = config['axi_to_data_file'][axi.name]
    c_array_size = config['axi_to_c_array_size'][axi.name]
    ram_module = get_axi_ram_module(axi, source_data_path, c_array_size)
    open(f'{args.tb_output_dir}/axi_ram_{axi.name}.v', 'w').write(ram_module)

  # generate vivado script
  os.system(f'mkdir -p {args.tb_output_dir}/run')
  if args.save_waveform:
    _logger.warning(f'Waveform will be saved at {args.tb_output_dir}/run/vivado/tapa-fast-cosim/tapa-fast-cosim.sim/sim_1/behav/xsim/wave.wdb')
  else:
    _logger.warning(f'Waveform is not saved. Use --save_waveform to save the simulation waveform.')

  vivado_script = get_vivado_tcl(config, args.tb_output_dir, args.save_waveform)

  open(f'{args.tb_output_dir}/run/run_cosim.tcl', 'w').write('\n'.join(vivado_script))

  # lanuch simulation
  disable_debug = '' if args.print_debug_info else ' | grep -v DEBUG'
  mode = 'gui' if args.start_gui else 'batch'
  command = f'cd {args.tb_output_dir}/run/; vivado -mode {mode} -source run_cosim.tcl {disable_debug}'
  if args.launch_simulation:
    _logger.info(f'Vivado command: {command}')
    _logger.info(f'Starting Vivado...')
    os.system(command)
