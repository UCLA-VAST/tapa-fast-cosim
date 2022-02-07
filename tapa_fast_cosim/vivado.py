
def get_vivado_tcl(tapa_hdl_path: str, tb_rtl_path: str, save_waveform: bool):
  script = []

  script.append(f'create_project -force tapa-fast-cosim ./vivado -part xc7vx485tffg1157-1')

  # read in the original RTLs by HLS
  script.append(f'set ORIG_RTL_PATH "{tapa_hdl_path}"') 
  script.append(r'set orig_rtl_files [glob ${ORIG_RTL_PATH}/*.v]') 
  script.append(r'add_files -norecurse -scan_for_includes ${orig_rtl_files}')

  # instantiate IPs used in the RTL. Use "-nocomplain" in case no IP is used
  script.append(r'set orig_ip_files [glob -nocomplain ${ORIG_RTL_PATH}/*.tcl]') 
  script.append(r'foreach ip_tcl ${orig_ip_files} { source ${ip_tcl} }')

  # read in tb files
  script.append(f'set tb_files [glob {tb_rtl_path}/*.v]')
  script.append(r'set_property SOURCE_SET sources_1 [get_filesets sim_1]')
  script.append(r'add_files -fileset sim_1 -norecurse -scan_for_includes ${tb_files}')

  script.append(f'set_property top test [get_filesets sim_1]')
  script.append(f'set_property top_lib xil_defaultlib [get_filesets sim_1]')

  # log all signals
  if save_waveform:
    script.append(r'set_property -name {xsim.simulate.log_all_signals} -value {true} -objects [get_filesets sim_1]')
    script.append(r'set_property -name {xsim.simulate.wdb} -value {wave.wdb} -objects [get_filesets sim_1]')

  script.append(r'launch_simulation')
  script.append(r'run all')
  script.append(r'exit')

  return script