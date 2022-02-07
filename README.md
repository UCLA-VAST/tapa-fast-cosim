# tapa-fast-cosim

Sample config file:

```json
{
  "top_name": "VecAdd",
  "scalar_to_val": {
    "n": "1024"
  },
  "axi_to_c_array_size": {
    "a": 1000,
    "b": 1000,
    "c": 1000
  },
  "axi_to_data_file": {
    "a": "[some-path]/m_axi_a_data.bin",
    "b": "[some-path]/m_axi_b_data.bin"
  }
}
```