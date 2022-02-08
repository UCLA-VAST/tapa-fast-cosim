# tapa-fast-cosim

Sample config file:

```json
{
  "xo_path": "./vadd.xo",
  "scalar_to_val": {
    "3": 1000
  },
  "axi_to_c_array_size": {
    "0": 1000,
    "1": 1000,
    "2": 1000
  },
  "axi_to_data_file": {
    "0": "./binary_data/m_axi_0_data.bin",
    "1": "./binary_data/m_axi_1_data.bin",
    "2": "./binary_data/m_axi_2_data.bin"
  }
}
```
- All argument names are replaced by its index, i.e. position in the function signature

- "scalar_to_val": the value of each scalar argument.

- "axi_to_c_array_size": size of the array in the C/C++ host

- "axi_to_data_file": the binary representation of the contents of each array argument

  - If an array is for output only, then the contents do not matter. The binary files represent the state of all array arguments before the kernel invocation.
  
  - After the simulation, the contents of each external memory will be dumped into [input-data-name]_out.bin. The *_out.bin files represent the state of all array arguments after the kernel invocation.