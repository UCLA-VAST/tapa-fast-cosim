from typing import *
from .common import AXI


def get_axi_ram_inst(axi_obj: AXI):
  # FIXME: test if using addr_width = 64 will cause problem in simulation
  return f'''
  parameter AXI_RAM_{axi_obj.name.upper()}_DATA_WIDTH = {axi_obj.data_width};
  parameter AXI_RAM_{axi_obj.name.upper()}_ADDR_WIDTH = {axi_obj.addr_width};
  parameter AXI_RAM_{axi_obj.name.upper()}_STRB_WIDTH = AXI_RAM_{axi_obj.name.upper()}_DATA_WIDTH/8;
  parameter AXI_RAM_{axi_obj.name.upper()}_ID_WIDTH = 8;
  parameter AXI_RAM_{axi_obj.name.upper()}_PIPELINE_OUTPUT = 0;

  wire [AXI_RAM_{axi_obj.name.upper()}_ID_WIDTH-1:0]     axi_{axi_obj.name}_awid;
  wire [AXI_RAM_{axi_obj.name.upper()}_ADDR_WIDTH-1:0]   axi_{axi_obj.name}_awaddr;
  wire [7:0]                                          axi_{axi_obj.name}_awlen;
  wire [2:0]                                          axi_{axi_obj.name}_awsize;
  wire [1:0]                                          axi_{axi_obj.name}_awburst;
  wire                                                axi_{axi_obj.name}_awlock;
  wire [3:0]                                          axi_{axi_obj.name}_awcache;
  wire [2:0]                                          axi_{axi_obj.name}_awprot;
  wire                                                axi_{axi_obj.name}_awvalid;
  wire                                                axi_{axi_obj.name}_awready;
  wire [AXI_RAM_{axi_obj.name.upper()}_DATA_WIDTH-1:0]   axi_{axi_obj.name}_wdata;
  wire [AXI_RAM_{axi_obj.name.upper()}_STRB_WIDTH-1:0]   axi_{axi_obj.name}_wstrb;
  wire                                                axi_{axi_obj.name}_wlast;
  wire                                                axi_{axi_obj.name}_wvalid;
  wire                                                axi_{axi_obj.name}_wready;
  wire [AXI_RAM_{axi_obj.name.upper()}_ID_WIDTH-1:0]     axi_{axi_obj.name}_bid;
  wire [1:0]                                          axi_{axi_obj.name}_bresp;
  wire                                                axi_{axi_obj.name}_bvalid;
  wire                                                axi_{axi_obj.name}_bready;
  wire [AXI_RAM_{axi_obj.name.upper()}_ID_WIDTH-1:0]     axi_{axi_obj.name}_arid;
  wire [AXI_RAM_{axi_obj.name.upper()}_ADDR_WIDTH-1:0]   axi_{axi_obj.name}_araddr;
  wire [7:0]                                          axi_{axi_obj.name}_arlen;
  wire [2:0]                                          axi_{axi_obj.name}_arsize;
  wire [1:0]                                          axi_{axi_obj.name}_arburst;
  wire                                                axi_{axi_obj.name}_arlock;
  wire [3:0]                                          axi_{axi_obj.name}_arcache;
  wire [2:0]                                          axi_{axi_obj.name}_arprot;
  wire                                                axi_{axi_obj.name}_arvalid;
  wire                                                axi_{axi_obj.name}_arready;
  wire [AXI_RAM_{axi_obj.name.upper()}_ID_WIDTH-1:0]     axi_{axi_obj.name}_rid;
  wire [AXI_RAM_{axi_obj.name.upper()}_DATA_WIDTH-1:0]   axi_{axi_obj.name}_rdata;
  wire [1:0]                                          axi_{axi_obj.name}_rresp;
  wire                                                axi_{axi_obj.name}_rlast;
  wire                                                axi_{axi_obj.name}_rvalid;
  wire                                                axi_{axi_obj.name}_rready;

  axi_ram_{axi_obj.name} #
  (
    .DATA_WIDTH       (AXI_RAM_{axi_obj.name.upper()}_DATA_WIDTH),
    .ADDR_WIDTH       (AXI_RAM_{axi_obj.name.upper()}_ADDR_WIDTH),
    .STRB_WIDTH       (AXI_RAM_{axi_obj.name.upper()}_DATA_WIDTH/8),
    .ID_WIDTH         (AXI_RAM_{axi_obj.name.upper()}_ID_WIDTH),
    .PIPELINE_OUTPUT  (AXI_RAM_{axi_obj.name.upper()}_PIPELINE_OUTPUT)
  ) axi_ram_c
  (
      .clk           (ap_clk),
      .rst           (~ap_rst_n),

      .s_axi_awid    (axi_{axi_obj.name.upper()}_awid    ),
      .s_axi_awaddr  (axi_{axi_obj.name.upper()}_awaddr  ),
      .s_axi_awlen   (axi_{axi_obj.name.upper()}_awlen   ),
      .s_axi_awsize  (axi_{axi_obj.name.upper()}_awsize  ),
      .s_axi_awburst (axi_{axi_obj.name.upper()}_awburst ),
      .s_axi_awlock  (axi_{axi_obj.name.upper()}_awlock  ),
      .s_axi_awcache (axi_{axi_obj.name.upper()}_awcache ),
      .s_axi_awprot  (axi_{axi_obj.name.upper()}_awprot  ),
      .s_axi_awvalid (axi_{axi_obj.name.upper()}_awvalid ),
      .s_axi_awready (axi_{axi_obj.name.upper()}_awready ),
      .s_axi_wdata   (axi_{axi_obj.name.upper()}_wdata   ),
      .s_axi_wstrb   (axi_{axi_obj.name.upper()}_wstrb   ),
      .s_axi_wlast   (axi_{axi_obj.name.upper()}_wlast   ),
      .s_axi_wvalid  (axi_{axi_obj.name.upper()}_wvalid  ),
      .s_axi_wready  (axi_{axi_obj.name.upper()}_wready  ),
      .s_axi_bid     (axi_{axi_obj.name.upper()}_bid     ),
      .s_axi_bresp   (axi_{axi_obj.name.upper()}_bresp   ),
      .s_axi_bvalid  (axi_{axi_obj.name.upper()}_bvalid  ),
      .s_axi_bready  (axi_{axi_obj.name.upper()}_bready  ),
      .s_axi_arid    (axi_{axi_obj.name.upper()}_arid    ),
      .s_axi_araddr  (axi_{axi_obj.name.upper()}_araddr  ),
      .s_axi_arlen   (axi_{axi_obj.name.upper()}_arlen   ),
      .s_axi_arsize  (axi_{axi_obj.name.upper()}_arsize  ),
      .s_axi_arburst (axi_{axi_obj.name.upper()}_arburst ),
      .s_axi_arlock  (axi_{axi_obj.name.upper()}_arlock  ),
      .s_axi_arcache (axi_{axi_obj.name.upper()}_arcache ),
      .s_axi_arprot  (axi_{axi_obj.name.upper()}_arprot  ),
      .s_axi_arvalid (axi_{axi_obj.name.upper()}_arvalid ),
      .s_axi_arready (axi_{axi_obj.name.upper()}_arready ),
      .s_axi_rid     (axi_{axi_obj.name.upper()}_rid     ),
      .s_axi_rdata   (axi_{axi_obj.name.upper()}_rdata   ),
      .s_axi_rresp   (axi_{axi_obj.name.upper()}_rresp   ),
      .s_axi_rlast   (axi_{axi_obj.name.upper()}_rlast   ),
      .s_axi_rvalid  (axi_{axi_obj.name.upper()}_rvalid  ),
      .s_axi_rready  (axi_{axi_obj.name.upper()}_rready  )
  );

'''

def get_s_axi_control():
  return f'''
  parameter C_S_AXI_CONTROL_DATA_WIDTH = 32;
  parameter C_S_AXI_CONTROL_ADDR_WIDTH = 6;
  parameter C_S_AXI_DATA_WIDTH = 32;
  parameter C_S_AXI_CONTROL_WSTRB_WIDTH = 32 / 8;
  parameter C_S_AXI_WSTRB_WIDTH = 32 / 8;

  wire                                    s_axi_control_awvalid;
  wire                                    s_axi_control_awready;
  wire [C_S_AXI_CONTROL_ADDR_WIDTH-1:0]   s_axi_control_awaddr;
  wire                                    s_axi_control_wvalid;
  wire                                    s_axi_control_wready;
  wire [C_S_AXI_CONTROL_DATA_WIDTH-1:0]   s_axi_control_wdata;
  wire [C_S_AXI_CONTROL_WSTRB_WIDTH-1:0]  s_axi_control_wstrb;
  reg                                     s_axi_control_arvalid;
  wire                                    s_axi_control_arready;
  wire [C_S_AXI_CONTROL_ADDR_WIDTH-1:0]   s_axi_control_araddr;
  wire                                    s_axi_control_rvalid;
  wire                                    s_axi_control_rready;
  wire [C_S_AXI_CONTROL_DATA_WIDTH-1:0]   s_axi_control_rdata;
  wire [1:0]                              s_axi_control_rresp;
  wire                                    s_axi_control_bvalid;
  wire                                    s_axi_control_bready;
  wire [1:0]                              s_axi_control_bresp;

  // use a large FIFO to buffer the command to s_axi_control
  // in this way we don't need to worry about flow control
  reg [63:0] s_axi_aw_din;
  reg        s_axi_aw_write;

  fifo_srl #(
    .DATA_WIDTH(64),
    .ADDR_WIDTH(6),
    .DEPTH(64)
  ) s_axi_aw(
    .clk(ap_clk),
    .reset(~ap_rst_n),

    // write
    .if_full_n   (),
    .if_write    (s_axi_aw_write),
    .if_din      (s_axi_aw_din  ),

    // read
    .if_empty_n  (s_axi_control_awvalid),
    .if_read     (s_axi_control_awready),
    .if_dout     (s_axi_control_awaddr),

    .if_write_ce (1'b1),
    .if_read_ce  (1'b1)

  );

  reg [511:0] s_axi_w_din;
  reg         s_axi_w_write;

  fifo_srl #(
    .DATA_WIDTH(32),
    .ADDR_WIDTH(6),
    .DEPTH(64)
  ) s_axi_w(
    .clk(ap_clk),
    .reset(~ap_rst_n),

    // write
    .if_full_n   (),
    .if_write    (s_axi_w_write),
    .if_din      (s_axi_w_din  ),

    // read
    .if_empty_n  (s_axi_control_wvalid),
    .if_read     (s_axi_control_wready),
    .if_dout     (s_axi_control_wdata),

    .if_write_ce (1'b1),
    .if_read_ce  (1'b1)

  );  
'''

def get_dut(top_name, axi_list: List[AXI]):
  dut = f'''
  {top_name} dut (
    .s_axi_control_AWVALID (s_axi_control_awvalid),
    .s_axi_control_AWREADY (s_axi_control_awready),
    .s_axi_control_AWADDR  (s_axi_control_awaddr ),

    .s_axi_control_WVALID  (s_axi_control_wvalid ),
    .s_axi_control_WREADY  (s_axi_control_wready ),
    .s_axi_control_WDATA   (s_axi_control_wdata  ),
    .s_axi_control_WSTRB   ({{64{{1'b1}} }}      ),

    // keep polling the control registers
    .s_axi_control_ARVALID (s_axi_control_arvalid),
    .s_axi_control_ARREADY (s_axi_control_arready),
    .s_axi_control_ARADDR  ('h00 ),

    .s_axi_control_RVALID  (s_axi_control_rvalid ),
    .s_axi_control_RREADY  (1 ),
    .s_axi_control_RDATA   (s_axi_control_rdata  ),
    .s_axi_control_RRESP   (                     ),

    .s_axi_control_BVALID  (s_axi_control_bvalid ),
    .s_axi_control_BREADY  (1'b1                 ),
    .s_axi_control_BRESP   (s_axi_control_bresp  ),
'''

  for axi in axi_list:
    dut += f'''
    .m_axi_{axi.name}_ARADDR  (axi_{axi.name}_araddr ),
    .m_axi_{axi.name}_ARBURST (axi_{axi.name}_arburst),
    .m_axi_{axi.name}_ARCACHE (axi_{axi.name}_arcache),
    .m_axi_{axi.name}_ARID    (axi_{axi.name}_arid   ),
    .m_axi_{axi.name}_ARLEN   (axi_{axi.name}_arlen  ),
    .m_axi_{axi.name}_ARLOCK  (axi_{axi.name}_arlock ),
    .m_axi_{axi.name}_ARPROT  (axi_{axi.name}_arprot ),
    .m_axi_{axi.name}_ARQOS   (axi_{axi.name}_arqos  ),
    .m_axi_{axi.name}_ARREADY (axi_{axi.name}_arready),
    .m_axi_{axi.name}_ARSIZE  (axi_{axi.name}_arsize ),
    .m_axi_{axi.name}_ARVALID (axi_{axi.name}_arvalid),
    .m_axi_{axi.name}_AWADDR  (axi_{axi.name}_awaddr ),
    .m_axi_{axi.name}_AWBURST (axi_{axi.name}_awburst),
    .m_axi_{axi.name}_AWCACHE (axi_{axi.name}_awcache),
    .m_axi_{axi.name}_AWID    (axi_{axi.name}_awid   ),
    .m_axi_{axi.name}_AWLEN   (axi_{axi.name}_awlen  ),
    .m_axi_{axi.name}_AWLOCK  (axi_{axi.name}_awlock ),
    .m_axi_{axi.name}_AWPROT  (axi_{axi.name}_awprot ),
    .m_axi_{axi.name}_AWQOS   (axi_{axi.name}_awqos  ),
    .m_axi_{axi.name}_AWREADY (axi_{axi.name}_awready),
    .m_axi_{axi.name}_AWSIZE  (axi_{axi.name}_awsize ),
    .m_axi_{axi.name}_AWVALID (axi_{axi.name}_awvalid),
    .m_axi_{axi.name}_BID     (axi_{axi.name}_bid    ),
    .m_axi_{axi.name}_BREADY  (axi_{axi.name}_bready ),
    .m_axi_{axi.name}_BRESP   (axi_{axi.name}_bresp  ),
    .m_axi_{axi.name}_BVALID  (axi_{axi.name}_bvalid ),
    .m_axi_{axi.name}_RDATA   (axi_{axi.name}_rdata  ),
    .m_axi_{axi.name}_RID     (axi_{axi.name}_rid    ),
    .m_axi_{axi.name}_RLAST   (axi_{axi.name}_rlast  ),
    .m_axi_{axi.name}_RREADY  (axi_{axi.name}_rready ),
    .m_axi_{axi.name}_RRESP   (axi_{axi.name}_rresp  ),
    .m_axi_{axi.name}_RVALID  (axi_{axi.name}_rvalid ),
    .m_axi_{axi.name}_WDATA   (axi_{axi.name}_wdata  ),
    .m_axi_{axi.name}_WLAST   (axi_{axi.name}_wlast  ),
    .m_axi_{axi.name}_WREADY  (axi_{axi.name}_wready ),
    .m_axi_{axi.name}_WSTRB   (axi_{axi.name}_wstrb  ),
    .m_axi_{axi.name}_WVALID  (axi_{axi.name}_wvalid ),
'''

  dut += f'''
    .ap_clk          (ap_clk       ),
    .ap_rst_n        (ap_rst_n     ),
    .interrupt       (             )
  );
  '''

  return dut


def get_test_signals(arg_to_reg_addrs: Dict[str, str], scalar_arg_to_val: Dict[str, str]):
  test = f'''
  parameter HALF_CLOCK_PERIOD = 2;
  parameter CLOCK_PERIOD = HALF_CLOCK_PERIOD * 2;

  // clock
  always begin
      ap_clk = 1'b1; 
      #HALF_CLOCK_PERIOD; 
      ap_clk = 1'b0;
      #HALF_CLOCK_PERIOD; 
  end

  initial begin
    s_axi_aw_write = 0; s_axi_aw_din = 0; s_axi_w_write = 0; s_axi_w_din = 0; 
    s_axi_control_arvalid = 1'b0;
    ap_rst_n = 1'b0;
    
    #(CLOCK_PERIOD*1000);  
    ap_rst_n = 1'b1;
    #(CLOCK_PERIOD*100);

'''

  for arg, addrs in arg_to_reg_addrs.items():
    val = scalar_arg_to_val.get(arg, 0)
    test += f'    s_axi_aw_write = 1; s_axi_aw_din = {addrs[0]}; s_axi_w_write = 1; s_axi_w_din = {val} & 32{{1\'b1}}; #CLOCK_PERIOD;\n'
    if len(addrs) == 2:
      test += f'    s_axi_aw_write = 1; s_axi_aw_din = {addrs[1]}; s_axi_w_write = 1; s_axi_w_din = ({val} >> 32) & 32{{1\'b1}}; #CLOCK_PERIOD;\n'

  test += f'''
    // start the kernel
    s_axi_aw_write = 1; s_axi_aw_din = 'h00; s_axi_w_write = 1; s_axi_w_din = 1; #CLOCK_PERIOD;

    // stop writing control signal
    s_axi_aw_write = 0; s_axi_w_write = 0; #CLOCK_PERIOD;

    // start polling ap_done
    #(CLOCK_PERIOD*1000);  
    s_axi_control_arvalid = 1'b1 & s_axi_control_arready;

  end

  // polling on ap_done
  always @ (posedge ap_clk) begin
    if (~ap_rst_n) begin
    end
    else begin
      if (s_axi_control_rvalid) begin
        if (s_axi_control_rdata[1]) begin
          $finish;
        end
      end
    end
  end  
'''

  return test


def get_begin():
  return f'''
`timescale 1 ns / 1 ps 

module test();

  reg ap_clk;
  reg ap_rst_n;

'''


def get_end():
  return f'''

endmodule
'''