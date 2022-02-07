import argparse
import logging
import json
import os
import re

from collections import defaultdict
from typing import *
from .common import AXI
from .templates import *


def _check_s_axi_control_format(s_axi_control_comments: List[str]):
  """
  ensure that the assumptions about the s_axi_control still hold
  """
  keyword_groups = [
    ['0x00', 'Control signals'],
    ['0x04', 'Global Interrupt Enable Register'],
    ['0x08', 'IP Interrupt Enable Register'],
    ['0x0c', 'IP Interrupt Status Register'],
  ]
  for line in s_axi_control_comments:
    for kw_group in keyword_groups:
      assert any(k in line for k in kw_group) == all(k in line for k in kw_group), line

  fixed_addresses = [
    ['- ap_start', 'bit 0'],
    ['- ap_done', 'bit 1'],
    ['- ap_idle', 'bit 2'],
    ['- ap_ready', 'bit 3'],
    ['- auto_restart', 'bit 7'],
  ]
  ap_signal_beg = ([i for i, elem in enumerate(s_axi_control_comments) if '0x00' in elem])[0]
  ap_signal_end = ([i for i, elem in enumerate(s_axi_control_comments) if '0x04' in elem])[0]
  for line in s_axi_control_comments[ap_signal_beg: ap_signal_end]:
    assert all(addr in line for reg, addr in fixed_addresses if reg in line )


def parse_register_addr(ctrl_unit_path: str) -> Dict[str, List[str]]:
  """
  parse the comments in s_axi_control.v to get the register addresses for each argument
  """
  ctrl_unit = open(ctrl_unit_path, 'r').readlines()
  comments = [line for line in ctrl_unit if line.strip().startswith('//')]
  _check_s_axi_control_format(comments)

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

  match_addr = re.findall(r'output\s+\[(\d+):0\]\s+m_axi_(\w+)_ARADDR\s*;', top_rtl)
  match_data = re.findall(r'output\s+\[(\d+):0\]\s+m_axi_(\w+)_WDATA\s*;', top_rtl)

  axi_list = []
  name_to_addr_width = {m_axi: addr_width for addr_width, m_axi in match_addr}
  for data_width, m_axi in match_data:
    addr_width = name_to_addr_width[m_axi]
    axi_list.append(AXI(m_axi, int(data_width)+1, int(addr_width)+1))

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


if __name__ == '__main__':
  parser = argparse.ArgumentParser()
  parser.add_argument('--rtl_path', type=str, required=True)
  parser.add_argument('--config_path', type=str, required=True)
  parser.add_argument('--tb_output_dir', type=str, required=True)
  args = parser.parse_args()

  config = json.loads(open(args.config_path, 'r').read())

  top_name = config['top_name']
  top_path = f'{args.rtl_path}/{top_name}.v'
  ctrl_path = f'{args.rtl_path}/{top_name}_control_s_axi.v'

  axi_list = parse_m_axi_interfaces(top_path)
  tb = get_cosim_tb(top_name, ctrl_path, axi_list, config['scalar_to_val'])

  os.system(f'mkdir -p {args.tb_output_dir}')
  open(f'{args.tb_output_dir}/tb.v', 'w').write(tb)

  for axi in axi_list:
    source_data_path = config['axi_to_data_file'].get(axi.name, '')
    output_data_size = config['axi_to_c_array_size'][axi.name]
    ram_module = get_axi_ram_module(axi, source_data_path, output_data_size)
    open(f'{args.tb_output_dir}/axi_ram_{axi.name}.v', 'w').write(ram_module)
