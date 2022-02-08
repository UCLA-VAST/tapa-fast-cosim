import glob
import json
import logging
import os
import re

from typing import *
from .common import MAX_AXI_BRAM_ADDR_WIDTH


def _update_relative_path(config, config_path):
  """ convert the relative path in the config file """
  config_dir = '/'.join(config_path.split('/')[:-1])

  curr_path = config['xo_path']
  if not curr_path.startswith('/') and not curr_path.startswith('~'):
    config['xo_path'] = f'{config_dir}/{curr_path}'

  for axi_name, curr_path in config['axi_to_data_file'].items():
    if not curr_path.startswith('/') and not curr_path.startswith('~'):
      config['axi_to_data_file'][axi_name] = f'{config_dir}/{curr_path}'


def _data_size_check(axi_to_c_array_size):
  """
  The AXI memory model used is hard coded to have an address width of 16 bits
  Using more memory is not encouraged but possible.
  """
  for axi, c_array_size in axi_to_c_array_size.items():
    if c_array_size > 2 ** MAX_AXI_BRAM_ADDR_WIDTH:
      logging.critical(f'Data size of {axi} is over 1 million. Consider using smaller testsets.')
      logging.critical(f'If you insist, increase the value of tapa_fast_cosim/common/MAX_AXI_BRAM_ADDR_WIDTH. Doing so may affect waveform dumping.')
      exit


def _parse_xo_update_config(config: Dict) -> None:
  xo_path = config['xo_path']

  os.system('rm -rf /tmp/tapa_fast_cosim/')
  os.system('mkdir -p /tmp/tapa_fast_cosim/')
  os.system(f'cp {xo_path} /tmp/tapa_fast_cosim/target.xo')
  os.system(f'unzip -q /tmp/tapa_fast_cosim/target.xo -d /tmp/tapa_fast_cosim/')

  config['rtl_path'] = glob.glob('/tmp/tapa_fast_cosim/ip_repo/*/src')[0]

  kernel_file_path = glob.glob('/tmp/tapa_fast_cosim/*/kernel.xml')[0]
  kernel_file = open(kernel_file_path, 'r').read()

  config['top_name'] = re.search(r'kernel name="(\w+)"', kernel_file).group(1)

  arg_name_id_pair_list = re.findall(r'arg name="(\w+)" addressQualifier="\d" id="(\d+)"', kernel_file)
  id_to_name: Dict[int, str] = {int(id): name for name, id in arg_name_id_pair_list}

  # update scalar arguments
  change_id_to_name = lambda id_to_val: {id_to_name[int(scalar_arg_id)]: val for scalar_arg_id, val in id_to_val.items()}
  for entry in ('scalar_to_val', 'axi_to_data_file', 'axi_to_c_array_size'):
    config[entry] = change_id_to_name(config[entry])


def preprocess_config(config_path: str) -> Dict:
  config = json.loads(open(config_path, 'r').read())
  _update_relative_path(config, config_path)
  _data_size_check(config['axi_to_c_array_size'])
  _parse_xo_update_config(config)

  return config