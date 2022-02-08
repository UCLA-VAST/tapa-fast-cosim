# tapa-fast-cosim

Sample config file:

```json
{
  "top_name": "VecAdd",
  "rtl_path": "[some_path]/hdl",
  "scalar_to_val": {
    "n": 1000
  },
  "axi_to_c_array_size": {
    "a": 1000,
    "b": 1000,
    "c": 1000
  },
  "axi_to_data_file": {
    "a": "[some_path]/m_axi_a_data.bin",
    "b": "[some_path]/m_axi_b_data.bin",
    "c": "[some_path]/m_axi_c_data.bin"
  }
}
```
- "scalar_to_val": the value of each scalar argument

- "axi_to_c_array_size": size of the array in the C/C++ host

- "axi_to_data_file": the binary representation of the contents of each array argument

  - If an array is for output only, then the contents do not matter. The binary files represent the state of all array arguments before the kernel invocation.
  
  - After the simulation, the contents of each external memory will be dumped into [input-data-name]_out.bin. The *_out.bin files represent the state of all array arguments after the kernel invocation.