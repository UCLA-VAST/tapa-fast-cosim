SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

python3 -m tapa_fast_cosim.main \
  --config_path ${SCRIPT_DIR}/config.json \
  --tb_output_dir ${SCRIPT_DIR}/run \
  --launch_simulation