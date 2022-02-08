`timescale 1 ns / 1 ps 

(* CORE_GENERATION_INFO = "VecAdd_VecAdd,hls_ip_2020_2,{HLS_INPUT_TYPE=cxx,HLS_INPUT_FLOAT=0,HLS_INPUT_FIXED=0,HLS_INPUT_PART=xcu250-figd2104-2L-e,HLS_INPUT_CLOCK=3.330000,HLS_INPUT_ARCH=others,HLS_SYN_CLOCK=1.000000,HLS_SYN_LAT=0,HLS_SYN_TPT=none,HLS_SYN_MEM=0,HLS_SYN_DSP=0,HLS_SYN_FF=316,HLS_SYN_LUT=552,HLS_VERSION=2020_2}" *)


module VecAdd
(
  s_axi_control_AWVALID,
  s_axi_control_AWREADY,
  s_axi_control_AWADDR,
  s_axi_control_WVALID,
  s_axi_control_WREADY,
  s_axi_control_WDATA,
  s_axi_control_WSTRB,
  s_axi_control_ARVALID,
  s_axi_control_ARREADY,
  s_axi_control_ARADDR,
  s_axi_control_RVALID,
  s_axi_control_RREADY,
  s_axi_control_RDATA,
  s_axi_control_RRESP,
  s_axi_control_BVALID,
  s_axi_control_BREADY,
  s_axi_control_BRESP,
  ap_clk,
  ap_rst_n,
  interrupt,
  m_axi_a_ARADDR,
  m_axi_a_ARBURST,
  m_axi_a_ARCACHE,
  m_axi_a_ARID,
  m_axi_a_ARLEN,
  m_axi_a_ARLOCK,
  m_axi_a_ARPROT,
  m_axi_a_ARQOS,
  m_axi_a_ARREADY,
  m_axi_a_ARSIZE,
  m_axi_a_ARVALID,
  m_axi_a_AWADDR,
  m_axi_a_AWBURST,
  m_axi_a_AWCACHE,
  m_axi_a_AWID,
  m_axi_a_AWLEN,
  m_axi_a_AWLOCK,
  m_axi_a_AWPROT,
  m_axi_a_AWQOS,
  m_axi_a_AWREADY,
  m_axi_a_AWSIZE,
  m_axi_a_AWVALID,
  m_axi_a_BID,
  m_axi_a_BREADY,
  m_axi_a_BRESP,
  m_axi_a_BVALID,
  m_axi_a_RDATA,
  m_axi_a_RID,
  m_axi_a_RLAST,
  m_axi_a_RREADY,
  m_axi_a_RRESP,
  m_axi_a_RVALID,
  m_axi_a_WDATA,
  m_axi_a_WLAST,
  m_axi_a_WREADY,
  m_axi_a_WSTRB,
  m_axi_a_WVALID,
  m_axi_b_ARADDR,
  m_axi_b_ARBURST,
  m_axi_b_ARCACHE,
  m_axi_b_ARID,
  m_axi_b_ARLEN,
  m_axi_b_ARLOCK,
  m_axi_b_ARPROT,
  m_axi_b_ARQOS,
  m_axi_b_ARREADY,
  m_axi_b_ARSIZE,
  m_axi_b_ARVALID,
  m_axi_b_AWADDR,
  m_axi_b_AWBURST,
  m_axi_b_AWCACHE,
  m_axi_b_AWID,
  m_axi_b_AWLEN,
  m_axi_b_AWLOCK,
  m_axi_b_AWPROT,
  m_axi_b_AWQOS,
  m_axi_b_AWREADY,
  m_axi_b_AWSIZE,
  m_axi_b_AWVALID,
  m_axi_b_BID,
  m_axi_b_BREADY,
  m_axi_b_BRESP,
  m_axi_b_BVALID,
  m_axi_b_RDATA,
  m_axi_b_RID,
  m_axi_b_RLAST,
  m_axi_b_RREADY,
  m_axi_b_RRESP,
  m_axi_b_RVALID,
  m_axi_b_WDATA,
  m_axi_b_WLAST,
  m_axi_b_WREADY,
  m_axi_b_WSTRB,
  m_axi_b_WVALID,
  m_axi_c_ARADDR,
  m_axi_c_ARBURST,
  m_axi_c_ARCACHE,
  m_axi_c_ARID,
  m_axi_c_ARLEN,
  m_axi_c_ARLOCK,
  m_axi_c_ARPROT,
  m_axi_c_ARQOS,
  m_axi_c_ARREADY,
  m_axi_c_ARSIZE,
  m_axi_c_ARVALID,
  m_axi_c_AWADDR,
  m_axi_c_AWBURST,
  m_axi_c_AWCACHE,
  m_axi_c_AWID,
  m_axi_c_AWLEN,
  m_axi_c_AWLOCK,
  m_axi_c_AWPROT,
  m_axi_c_AWQOS,
  m_axi_c_AWREADY,
  m_axi_c_AWSIZE,
  m_axi_c_AWVALID,
  m_axi_c_BID,
  m_axi_c_BREADY,
  m_axi_c_BRESP,
  m_axi_c_BVALID,
  m_axi_c_RDATA,
  m_axi_c_RID,
  m_axi_c_RLAST,
  m_axi_c_RREADY,
  m_axi_c_RRESP,
  m_axi_c_RVALID,
  m_axi_c_WDATA,
  m_axi_c_WLAST,
  m_axi_c_WREADY,
  m_axi_c_WSTRB,
  m_axi_c_WVALID
);

  parameter C_S_AXI_CONTROL_DATA_WIDTH = 32;
  parameter C_S_AXI_CONTROL_ADDR_WIDTH = 6;
  parameter C_S_AXI_DATA_WIDTH = 32;
  parameter C_S_AXI_CONTROL_WSTRB_WIDTH = 32 / 8;
  parameter C_S_AXI_WSTRB_WIDTH = 32 / 8;
  input s_axi_control_AWVALID;
  output s_axi_control_AWREADY;
  input [C_S_AXI_CONTROL_ADDR_WIDTH-1:0] s_axi_control_AWADDR;
  input s_axi_control_WVALID;
  output s_axi_control_WREADY;
  input [C_S_AXI_CONTROL_DATA_WIDTH-1:0] s_axi_control_WDATA;
  input [C_S_AXI_CONTROL_WSTRB_WIDTH-1:0] s_axi_control_WSTRB;
  input s_axi_control_ARVALID;
  output s_axi_control_ARREADY;
  input [C_S_AXI_CONTROL_ADDR_WIDTH-1:0] s_axi_control_ARADDR;
  output s_axi_control_RVALID;
  input s_axi_control_RREADY;
  output [C_S_AXI_CONTROL_DATA_WIDTH-1:0] s_axi_control_RDATA;
  output [1:0] s_axi_control_RRESP;
  output s_axi_control_BVALID;
  input s_axi_control_BREADY;
  output [1:0] s_axi_control_BRESP;
  input ap_clk;
  input ap_rst_n;
  output interrupt;
  output [63:0] m_axi_a_ARADDR;
  output [1:0] m_axi_a_ARBURST;
  output [3:0] m_axi_a_ARCACHE;
  output [0:0] m_axi_a_ARID;
  output [7:0] m_axi_a_ARLEN;
  output m_axi_a_ARLOCK;
  output [2:0] m_axi_a_ARPROT;
  output [3:0] m_axi_a_ARQOS;
  input m_axi_a_ARREADY;
  output [2:0] m_axi_a_ARSIZE;
  output m_axi_a_ARVALID;
  output [63:0] m_axi_a_AWADDR;
  output [1:0] m_axi_a_AWBURST;
  output [3:0] m_axi_a_AWCACHE;
  output [0:0] m_axi_a_AWID;
  output [7:0] m_axi_a_AWLEN;
  output m_axi_a_AWLOCK;
  output [2:0] m_axi_a_AWPROT;
  output [3:0] m_axi_a_AWQOS;
  input m_axi_a_AWREADY;
  output [2:0] m_axi_a_AWSIZE;
  output m_axi_a_AWVALID;
  input [0:0] m_axi_a_BID;
  output m_axi_a_BREADY;
  input [1:0] m_axi_a_BRESP;
  input m_axi_a_BVALID;
  input [31:0] m_axi_a_RDATA;
  input [0:0] m_axi_a_RID;
  input m_axi_a_RLAST;
  output m_axi_a_RREADY;
  input [1:0] m_axi_a_RRESP;
  input m_axi_a_RVALID;
  output [31:0] m_axi_a_WDATA;
  output m_axi_a_WLAST;
  input m_axi_a_WREADY;
  output [3:0] m_axi_a_WSTRB;
  output m_axi_a_WVALID;
  output [63:0] m_axi_b_ARADDR;
  output [1:0] m_axi_b_ARBURST;
  output [3:0] m_axi_b_ARCACHE;
  output [0:0] m_axi_b_ARID;
  output [7:0] m_axi_b_ARLEN;
  output m_axi_b_ARLOCK;
  output [2:0] m_axi_b_ARPROT;
  output [3:0] m_axi_b_ARQOS;
  input m_axi_b_ARREADY;
  output [2:0] m_axi_b_ARSIZE;
  output m_axi_b_ARVALID;
  output [63:0] m_axi_b_AWADDR;
  output [1:0] m_axi_b_AWBURST;
  output [3:0] m_axi_b_AWCACHE;
  output [0:0] m_axi_b_AWID;
  output [7:0] m_axi_b_AWLEN;
  output m_axi_b_AWLOCK;
  output [2:0] m_axi_b_AWPROT;
  output [3:0] m_axi_b_AWQOS;
  input m_axi_b_AWREADY;
  output [2:0] m_axi_b_AWSIZE;
  output m_axi_b_AWVALID;
  input [0:0] m_axi_b_BID;
  output m_axi_b_BREADY;
  input [1:0] m_axi_b_BRESP;
  input m_axi_b_BVALID;
  input [31:0] m_axi_b_RDATA;
  input [0:0] m_axi_b_RID;
  input m_axi_b_RLAST;
  output m_axi_b_RREADY;
  input [1:0] m_axi_b_RRESP;
  input m_axi_b_RVALID;
  output [31:0] m_axi_b_WDATA;
  output m_axi_b_WLAST;
  input m_axi_b_WREADY;
  output [3:0] m_axi_b_WSTRB;
  output m_axi_b_WVALID;
  output [63:0] m_axi_c_ARADDR;
  output [1:0] m_axi_c_ARBURST;
  output [3:0] m_axi_c_ARCACHE;
  output [0:0] m_axi_c_ARID;
  output [7:0] m_axi_c_ARLEN;
  output m_axi_c_ARLOCK;
  output [2:0] m_axi_c_ARPROT;
  output [3:0] m_axi_c_ARQOS;
  input m_axi_c_ARREADY;
  output [2:0] m_axi_c_ARSIZE;
  output m_axi_c_ARVALID;
  output [63:0] m_axi_c_AWADDR;
  output [1:0] m_axi_c_AWBURST;
  output [3:0] m_axi_c_AWCACHE;
  output [0:0] m_axi_c_AWID;
  output [7:0] m_axi_c_AWLEN;
  output m_axi_c_AWLOCK;
  output [2:0] m_axi_c_AWPROT;
  output [3:0] m_axi_c_AWQOS;
  input m_axi_c_AWREADY;
  output [2:0] m_axi_c_AWSIZE;
  output m_axi_c_AWVALID;
  input [0:0] m_axi_c_BID;
  output m_axi_c_BREADY;
  input [1:0] m_axi_c_BRESP;
  input m_axi_c_BVALID;
  input [31:0] m_axi_c_RDATA;
  input [0:0] m_axi_c_RID;
  input m_axi_c_RLAST;
  output m_axi_c_RREADY;
  input [1:0] m_axi_c_RRESP;
  input m_axi_c_RVALID;
  output [31:0] m_axi_c_WDATA;
  output m_axi_c_WLAST;
  input m_axi_c_WREADY;
  output [3:0] m_axi_c_WSTRB;
  output m_axi_c_WVALID;
  wire ap_start;
  wire [63:0] a;
  wire [63:0] b;
  wire [63:0] c;
  wire [63:0] n;
  wire ap_rst_n_inv;
  wire ap_done;
  wire ap_idle;
  wire ap_ready;
  wire ap_rst_n__q0;
  wire a_q__rst__q0;
  wire b_q__rst__q0;
  wire c_q__rst__q0;
  wire [32:0] a_q__dout;
  wire a_q__empty_n;
  wire a_q__read;
  wire [32:0] a_q__din;
  wire a_q__full_n;
  wire a_q__write;
  wire [32:0] b_q__dout;
  wire b_q__empty_n;
  wire b_q__read;
  wire [32:0] b_q__din;
  wire b_q__full_n;
  wire b_q__write;
  wire [32:0] c_q__dout;
  wire c_q__empty_n;
  wire c_q__read;
  wire [32:0] c_q__din;
  wire c_q__full_n;
  wire c_q__write;
  wire [63:0] Add_0___n__q0;
  wire Add_0__ap_rst_n__q0;
  wire Add_0__ap_start_global__q0;
  wire Add_0__is_done__q0;
  wire Add_0__ap_done_global__q0;
  wire Add_0__ap_start;
  reg [1:0] Add_0__state;
  wire Add_0__ap_done;
  wire Add_0__ap_idle;
  wire Add_0__ap_ready;
  wire [63:0] Mmap2Stream_0___a__q0;
  wire [63:0] Mmap2Stream_0___n__q0;
  wire Mmap2Stream_0__ap_rst_n__q0;
  wire Mmap2Stream_0__ap_start_global__q0;
  wire Mmap2Stream_0__is_done__q0;
  wire Mmap2Stream_0__ap_done_global__q0;
  wire Mmap2Stream_0__ap_start;
  reg [1:0] Mmap2Stream_0__state;
  wire Mmap2Stream_0__ap_done;
  wire Mmap2Stream_0__ap_idle;
  wire Mmap2Stream_0__ap_ready;
  wire [63:0] Mmap2Stream_1___b__q0;
  wire [63:0] Mmap2Stream_1___n__q0;
  wire Mmap2Stream_1__ap_rst_n__q0;
  wire Mmap2Stream_1__ap_start_global__q0;
  wire Mmap2Stream_1__is_done__q0;
  wire Mmap2Stream_1__ap_done_global__q0;
  wire Mmap2Stream_1__ap_start;
  reg [1:0] Mmap2Stream_1__state;
  wire Mmap2Stream_1__ap_done;
  wire Mmap2Stream_1__ap_idle;
  wire Mmap2Stream_1__ap_ready;
  wire [63:0] Stream2Mmap_0___c__q0;
  wire [63:0] Stream2Mmap_0___n__q0;
  wire Stream2Mmap_0__ap_rst_n__q0;
  wire Stream2Mmap_0__ap_start_global__q0;
  wire Stream2Mmap_0__is_done__q0;
  wire Stream2Mmap_0__ap_done_global__q0;
  wire Stream2Mmap_0__ap_start;
  reg [1:0] Stream2Mmap_0__state;
  wire Stream2Mmap_0__ap_done;
  wire Stream2Mmap_0__ap_idle;
  wire Stream2Mmap_0__ap_ready;
  reg [1:0] tapa_state;
  reg [0:0] countdown;
  wire ap_start__q0;
  wire ap_done__q0;

  VecAdd_control_s_axi
  #(
    .C_S_AXI_ADDR_WIDTH(C_S_AXI_CONTROL_ADDR_WIDTH),
    .C_S_AXI_DATA_WIDTH(C_S_AXI_CONTROL_DATA_WIDTH)
  )
  control_s_axi_U
  (
    .AWVALID(s_axi_control_AWVALID),
    .AWREADY(s_axi_control_AWREADY),
    .AWADDR(s_axi_control_AWADDR),
    .WVALID(s_axi_control_WVALID),
    .WREADY(s_axi_control_WREADY),
    .WDATA(s_axi_control_WDATA),
    .WSTRB(s_axi_control_WSTRB),
    .ARVALID(s_axi_control_ARVALID),
    .ARREADY(s_axi_control_ARREADY),
    .ARADDR(s_axi_control_ARADDR),
    .RVALID(s_axi_control_RVALID),
    .RREADY(s_axi_control_RREADY),
    .RDATA(s_axi_control_RDATA),
    .RRESP(s_axi_control_RRESP),
    .BVALID(s_axi_control_BVALID),
    .BREADY(s_axi_control_BREADY),
    .BRESP(s_axi_control_BRESP),
    .ACLK(ap_clk),
    .ARESET(ap_rst_n_inv),
    .ACLK_EN(1'b1),
    .a(a),
    .b(b),
    .c(c),
    .n(n),
    .ap_start(ap_start),
    .interrupt(interrupt),
    .ap_ready(ap_ready),
    .ap_done(ap_done),
    .ap_idle(ap_idle)
  );


  fifo
  #(
    .DATA_WIDTH(33),
    .ADDR_WIDTH(1),
    .DEPTH(2)
  )
  a_q
  (
    .clk(ap_clk),
    .reset(a_q__rst__q0),
    .if_dout(a_q__dout),
    .if_empty_n(a_q__empty_n),
    .if_read(a_q__read),
    .if_read_ce(1'b1),
    .if_din(a_q__din),
    .if_full_n(a_q__full_n),
    .if_write(a_q__write),
    .if_write_ce(1'b1)
  );


  fifo
  #(
    .DATA_WIDTH(33),
    .ADDR_WIDTH(1),
    .DEPTH(2)
  )
  b_q
  (
    .clk(ap_clk),
    .reset(b_q__rst__q0),
    .if_dout(b_q__dout),
    .if_empty_n(b_q__empty_n),
    .if_read(b_q__read),
    .if_read_ce(1'b1),
    .if_din(b_q__din),
    .if_full_n(b_q__full_n),
    .if_write(b_q__write),
    .if_write_ce(1'b1)
  );


  fifo
  #(
    .DATA_WIDTH(33),
    .ADDR_WIDTH(1),
    .DEPTH(2)
  )
  c_q
  (
    .clk(ap_clk),
    .reset(c_q__rst__q0),
    .if_dout(c_q__dout),
    .if_empty_n(c_q__empty_n),
    .if_read(c_q__read),
    .if_read_ce(1'b1),
    .if_din(c_q__din),
    .if_full_n(c_q__full_n),
    .if_write(c_q__write),
    .if_write_ce(1'b1)
  );


  Add
  Add_0
  (
    .ap_clk(ap_clk),
    .ap_rst_n(Add_0__ap_rst_n__q0),
    .ap_start(Add_0__ap_start),
    .ap_done(Add_0__ap_done),
    .ap_idle(Add_0__ap_idle),
    .ap_ready(Add_0__ap_ready),
    .a_V_dout(a_q__dout),
    .a_peek_V_dout(a_q__dout),
    .a_V_empty_n(a_q__empty_n),
    .a_peek_V_empty_n(a_q__empty_n),
    .a_V_read(a_q__read),
    .a_peek_V_read(),
    .b_V_dout(b_q__dout),
    .b_peek_V_dout(b_q__dout),
    .b_V_empty_n(b_q__empty_n),
    .b_peek_V_empty_n(b_q__empty_n),
    .b_V_read(b_q__read),
    .b_peek_V_read(),
    .c_V_din(c_q__din),
    .c_V_full_n(c_q__full_n),
    .c_V_write(c_q__write),
    .n(Add_0___n__q0)
  );


  Mmap2Stream
  Mmap2Stream_0
  (
    .ap_clk(ap_clk),
    .ap_rst_n(Mmap2Stream_0__ap_rst_n__q0),
    .ap_start(Mmap2Stream_0__ap_start),
    .ap_done(Mmap2Stream_0__ap_done),
    .ap_idle(Mmap2Stream_0__ap_idle),
    .ap_ready(Mmap2Stream_0__ap_ready),
    .m_axi_mmap_ARADDR(m_axi_a_ARADDR),
    .m_axi_mmap_ARBURST(m_axi_a_ARBURST),
    .m_axi_mmap_ARCACHE(m_axi_a_ARCACHE),
    .m_axi_mmap_ARID(m_axi_a_ARID),
    .m_axi_mmap_ARLEN(m_axi_a_ARLEN),
    .m_axi_mmap_ARLOCK(m_axi_a_ARLOCK),
    .m_axi_mmap_ARPROT(m_axi_a_ARPROT),
    .m_axi_mmap_ARQOS(m_axi_a_ARQOS),
    .m_axi_mmap_ARREADY(m_axi_a_ARREADY),
    .m_axi_mmap_ARSIZE(m_axi_a_ARSIZE),
    .m_axi_mmap_ARVALID(m_axi_a_ARVALID),
    .m_axi_mmap_AWADDR(m_axi_a_AWADDR),
    .m_axi_mmap_AWBURST(m_axi_a_AWBURST),
    .m_axi_mmap_AWCACHE(m_axi_a_AWCACHE),
    .m_axi_mmap_AWID(m_axi_a_AWID),
    .m_axi_mmap_AWLEN(m_axi_a_AWLEN),
    .m_axi_mmap_AWLOCK(m_axi_a_AWLOCK),
    .m_axi_mmap_AWPROT(m_axi_a_AWPROT),
    .m_axi_mmap_AWQOS(m_axi_a_AWQOS),
    .m_axi_mmap_AWREADY(m_axi_a_AWREADY),
    .m_axi_mmap_AWSIZE(m_axi_a_AWSIZE),
    .m_axi_mmap_AWVALID(m_axi_a_AWVALID),
    .m_axi_mmap_BID(m_axi_a_BID),
    .m_axi_mmap_BREADY(m_axi_a_BREADY),
    .m_axi_mmap_BRESP(m_axi_a_BRESP),
    .m_axi_mmap_BVALID(m_axi_a_BVALID),
    .m_axi_mmap_RDATA(m_axi_a_RDATA),
    .m_axi_mmap_RID(m_axi_a_RID),
    .m_axi_mmap_RLAST(m_axi_a_RLAST),
    .m_axi_mmap_RREADY(m_axi_a_RREADY),
    .m_axi_mmap_RRESP(m_axi_a_RRESP),
    .m_axi_mmap_RVALID(m_axi_a_RVALID),
    .m_axi_mmap_WDATA(m_axi_a_WDATA),
    .m_axi_mmap_WLAST(m_axi_a_WLAST),
    .m_axi_mmap_WREADY(m_axi_a_WREADY),
    .m_axi_mmap_WSTRB(m_axi_a_WSTRB),
    .m_axi_mmap_WVALID(m_axi_a_WVALID),
    .mmap_offset(Mmap2Stream_0___a__q0),
    .stream_V_din(a_q__din),
    .stream_V_full_n(a_q__full_n),
    .stream_V_write(a_q__write),
    .n(Mmap2Stream_0___n__q0)
  );


  Mmap2Stream
  Mmap2Stream_1
  (
    .ap_clk(ap_clk),
    .ap_rst_n(Mmap2Stream_1__ap_rst_n__q0),
    .ap_start(Mmap2Stream_1__ap_start),
    .ap_done(Mmap2Stream_1__ap_done),
    .ap_idle(Mmap2Stream_1__ap_idle),
    .ap_ready(Mmap2Stream_1__ap_ready),
    .m_axi_mmap_ARADDR(m_axi_b_ARADDR),
    .m_axi_mmap_ARBURST(m_axi_b_ARBURST),
    .m_axi_mmap_ARCACHE(m_axi_b_ARCACHE),
    .m_axi_mmap_ARID(m_axi_b_ARID),
    .m_axi_mmap_ARLEN(m_axi_b_ARLEN),
    .m_axi_mmap_ARLOCK(m_axi_b_ARLOCK),
    .m_axi_mmap_ARPROT(m_axi_b_ARPROT),
    .m_axi_mmap_ARQOS(m_axi_b_ARQOS),
    .m_axi_mmap_ARREADY(m_axi_b_ARREADY),
    .m_axi_mmap_ARSIZE(m_axi_b_ARSIZE),
    .m_axi_mmap_ARVALID(m_axi_b_ARVALID),
    .m_axi_mmap_AWADDR(m_axi_b_AWADDR),
    .m_axi_mmap_AWBURST(m_axi_b_AWBURST),
    .m_axi_mmap_AWCACHE(m_axi_b_AWCACHE),
    .m_axi_mmap_AWID(m_axi_b_AWID),
    .m_axi_mmap_AWLEN(m_axi_b_AWLEN),
    .m_axi_mmap_AWLOCK(m_axi_b_AWLOCK),
    .m_axi_mmap_AWPROT(m_axi_b_AWPROT),
    .m_axi_mmap_AWQOS(m_axi_b_AWQOS),
    .m_axi_mmap_AWREADY(m_axi_b_AWREADY),
    .m_axi_mmap_AWSIZE(m_axi_b_AWSIZE),
    .m_axi_mmap_AWVALID(m_axi_b_AWVALID),
    .m_axi_mmap_BID(m_axi_b_BID),
    .m_axi_mmap_BREADY(m_axi_b_BREADY),
    .m_axi_mmap_BRESP(m_axi_b_BRESP),
    .m_axi_mmap_BVALID(m_axi_b_BVALID),
    .m_axi_mmap_RDATA(m_axi_b_RDATA),
    .m_axi_mmap_RID(m_axi_b_RID),
    .m_axi_mmap_RLAST(m_axi_b_RLAST),
    .m_axi_mmap_RREADY(m_axi_b_RREADY),
    .m_axi_mmap_RRESP(m_axi_b_RRESP),
    .m_axi_mmap_RVALID(m_axi_b_RVALID),
    .m_axi_mmap_WDATA(m_axi_b_WDATA),
    .m_axi_mmap_WLAST(m_axi_b_WLAST),
    .m_axi_mmap_WREADY(m_axi_b_WREADY),
    .m_axi_mmap_WSTRB(m_axi_b_WSTRB),
    .m_axi_mmap_WVALID(m_axi_b_WVALID),
    .mmap_offset(Mmap2Stream_1___b__q0),
    .stream_V_din(b_q__din),
    .stream_V_full_n(b_q__full_n),
    .stream_V_write(b_q__write),
    .n(Mmap2Stream_1___n__q0)
  );


  Stream2Mmap
  Stream2Mmap_0
  (
    .ap_clk(ap_clk),
    .ap_rst_n(Stream2Mmap_0__ap_rst_n__q0),
    .ap_start(Stream2Mmap_0__ap_start),
    .ap_done(Stream2Mmap_0__ap_done),
    .ap_idle(Stream2Mmap_0__ap_idle),
    .ap_ready(Stream2Mmap_0__ap_ready),
    .m_axi_mmap_ARADDR(m_axi_c_ARADDR),
    .m_axi_mmap_ARBURST(m_axi_c_ARBURST),
    .m_axi_mmap_ARCACHE(m_axi_c_ARCACHE),
    .m_axi_mmap_ARID(m_axi_c_ARID),
    .m_axi_mmap_ARLEN(m_axi_c_ARLEN),
    .m_axi_mmap_ARLOCK(m_axi_c_ARLOCK),
    .m_axi_mmap_ARPROT(m_axi_c_ARPROT),
    .m_axi_mmap_ARQOS(m_axi_c_ARQOS),
    .m_axi_mmap_ARREADY(m_axi_c_ARREADY),
    .m_axi_mmap_ARSIZE(m_axi_c_ARSIZE),
    .m_axi_mmap_ARVALID(m_axi_c_ARVALID),
    .m_axi_mmap_AWADDR(m_axi_c_AWADDR),
    .m_axi_mmap_AWBURST(m_axi_c_AWBURST),
    .m_axi_mmap_AWCACHE(m_axi_c_AWCACHE),
    .m_axi_mmap_AWID(m_axi_c_AWID),
    .m_axi_mmap_AWLEN(m_axi_c_AWLEN),
    .m_axi_mmap_AWLOCK(m_axi_c_AWLOCK),
    .m_axi_mmap_AWPROT(m_axi_c_AWPROT),
    .m_axi_mmap_AWQOS(m_axi_c_AWQOS),
    .m_axi_mmap_AWREADY(m_axi_c_AWREADY),
    .m_axi_mmap_AWSIZE(m_axi_c_AWSIZE),
    .m_axi_mmap_AWVALID(m_axi_c_AWVALID),
    .m_axi_mmap_BID(m_axi_c_BID),
    .m_axi_mmap_BREADY(m_axi_c_BREADY),
    .m_axi_mmap_BRESP(m_axi_c_BRESP),
    .m_axi_mmap_BVALID(m_axi_c_BVALID),
    .m_axi_mmap_RDATA(m_axi_c_RDATA),
    .m_axi_mmap_RID(m_axi_c_RID),
    .m_axi_mmap_RLAST(m_axi_c_RLAST),
    .m_axi_mmap_RREADY(m_axi_c_RREADY),
    .m_axi_mmap_RRESP(m_axi_c_RRESP),
    .m_axi_mmap_RVALID(m_axi_c_RVALID),
    .m_axi_mmap_WDATA(m_axi_c_WDATA),
    .m_axi_mmap_WLAST(m_axi_c_WLAST),
    .m_axi_mmap_WREADY(m_axi_c_WREADY),
    .m_axi_mmap_WSTRB(m_axi_c_WSTRB),
    .m_axi_mmap_WVALID(m_axi_c_WVALID),
    .mmap_offset(Stream2Mmap_0___c__q0),
    .stream_V_dout(c_q__dout),
    .stream_peek_V_dout(c_q__dout),
    .stream_V_empty_n(c_q__empty_n),
    .stream_peek_V_empty_n(c_q__empty_n),
    .stream_V_read(c_q__read),
    .stream_peek_V_read(),
    .n(Stream2Mmap_0___n__q0)
  );


  always @(posedge ap_clk) begin
  end

  assign ap_rst_n__q0 = ap_rst_n;
  assign ap_rst_n_inv = (~ap_rst_n__q0);

  always @(posedge ap_clk) begin
  end

  assign a_q__rst__q0 = (~ap_rst_n);

  always @(posedge ap_clk) begin
    if(a_q__read == 1'b1) begin
      $display("DEBUG: R: \033[97m          a_q\033[0m -> \033[90mAdd_0        \033[0m %h", a_q__dout);
    end 
  end


  always @(posedge ap_clk) begin
    if(a_q__write == 1'b1) begin
      $display("DEBUG: W: \033[90mMmap2Stream_0\033[0m -> \033[97ma_q          \033[0m %h", a_q__din);
    end 
  end


  always @(posedge ap_clk) begin
  end

  assign b_q__rst__q0 = (~ap_rst_n);

  always @(posedge ap_clk) begin
    if(b_q__read == 1'b1) begin
      $display("DEBUG: R: \033[97m          b_q\033[0m -> \033[90mAdd_0        \033[0m %h", b_q__dout);
    end 
  end


  always @(posedge ap_clk) begin
    if(b_q__write == 1'b1) begin
      $display("DEBUG: W: \033[90mMmap2Stream_1\033[0m -> \033[97mb_q          \033[0m %h", b_q__din);
    end 
  end


  always @(posedge ap_clk) begin
  end

  assign c_q__rst__q0 = (~ap_rst_n);

  always @(posedge ap_clk) begin
    if(c_q__read == 1'b1) begin
      $display("DEBUG: R: \033[97m          c_q\033[0m -> \033[90mStream2Mmap_0\033[0m %h", c_q__dout);
    end 
  end


  always @(posedge ap_clk) begin
    if(c_q__write == 1'b1) begin
      $display("DEBUG: W: \033[90m        Add_0\033[0m -> \033[97mc_q          \033[0m %h", c_q__din);
    end 
  end


  always @(posedge ap_clk) begin
  end

  assign Add_0___n__q0 = n;

  always @(posedge ap_clk) begin
  end

  assign Add_0__ap_rst_n__q0 = ap_rst_n;

  always @(posedge ap_clk) begin
  end

  assign Add_0__ap_start_global__q0 = ap_start__q0;

  always @(posedge ap_clk) begin
  end

  assign Add_0__is_done__q0 = (Add_0__state == 2'b10);

  always @(posedge ap_clk) begin
  end

  assign Add_0__ap_done_global__q0 = ap_done__q0;

  always @(posedge ap_clk) begin
    if(~Add_0__ap_rst_n__q0) begin
      Add_0__state <= 2'b00;
    end else begin
      if(Add_0__state == 2'b00) begin
        if(Add_0__ap_start_global__q0) begin
          Add_0__state <= 2'b01;
        end 
      end 
      if(Add_0__state == 2'b01) begin
        if(Add_0__ap_ready) begin
          if(Add_0__ap_done) begin
            Add_0__state <= 2'b10;
          end else begin
            Add_0__state <= 2'b11;
          end
        end 
      end 
      if(Add_0__state == 2'b11) begin
        if(Add_0__ap_done) begin
          Add_0__state <= 2'b10;
        end 
      end 
      if(Add_0__state == 2'b10) begin
        if(Add_0__ap_done_global__q0) begin
          Add_0__state <= 2'b00;
        end 
      end 
    end
  end

  assign Add_0__ap_start = (Add_0__state == 2'b01);

  always @(posedge ap_clk) begin
  end

  assign Mmap2Stream_0___a__q0 = a;

  always @(posedge ap_clk) begin
  end

  assign Mmap2Stream_0___n__q0 = n;

  always @(posedge ap_clk) begin
  end

  assign Mmap2Stream_0__ap_rst_n__q0 = ap_rst_n;

  always @(posedge ap_clk) begin
  end

  assign Mmap2Stream_0__ap_start_global__q0 = ap_start__q0;

  always @(posedge ap_clk) begin
  end

  assign Mmap2Stream_0__is_done__q0 = (Mmap2Stream_0__state == 2'b10);

  always @(posedge ap_clk) begin
  end

  assign Mmap2Stream_0__ap_done_global__q0 = ap_done__q0;

  always @(posedge ap_clk) begin
    if(~Mmap2Stream_0__ap_rst_n__q0) begin
      Mmap2Stream_0__state <= 2'b00;
    end else begin
      if(Mmap2Stream_0__state == 2'b00) begin
        if(Mmap2Stream_0__ap_start_global__q0) begin
          Mmap2Stream_0__state <= 2'b01;
        end 
      end 
      if(Mmap2Stream_0__state == 2'b01) begin
        if(Mmap2Stream_0__ap_ready) begin
          if(Mmap2Stream_0__ap_done) begin
            Mmap2Stream_0__state <= 2'b10;
          end else begin
            Mmap2Stream_0__state <= 2'b11;
          end
        end 
      end 
      if(Mmap2Stream_0__state == 2'b11) begin
        if(Mmap2Stream_0__ap_done) begin
          Mmap2Stream_0__state <= 2'b10;
        end 
      end 
      if(Mmap2Stream_0__state == 2'b10) begin
        if(Mmap2Stream_0__ap_done_global__q0) begin
          Mmap2Stream_0__state <= 2'b00;
        end 
      end 
    end
  end

  assign Mmap2Stream_0__ap_start = (Mmap2Stream_0__state == 2'b01);

  always @(posedge ap_clk) begin
  end

  assign Mmap2Stream_1___b__q0 = b;

  always @(posedge ap_clk) begin
  end

  assign Mmap2Stream_1___n__q0 = n;

  always @(posedge ap_clk) begin
  end

  assign Mmap2Stream_1__ap_rst_n__q0 = ap_rst_n;

  always @(posedge ap_clk) begin
  end

  assign Mmap2Stream_1__ap_start_global__q0 = ap_start__q0;

  always @(posedge ap_clk) begin
  end

  assign Mmap2Stream_1__is_done__q0 = (Mmap2Stream_1__state == 2'b10);

  always @(posedge ap_clk) begin
  end

  assign Mmap2Stream_1__ap_done_global__q0 = ap_done__q0;

  always @(posedge ap_clk) begin
    if(~Mmap2Stream_1__ap_rst_n__q0) begin
      Mmap2Stream_1__state <= 2'b00;
    end else begin
      if(Mmap2Stream_1__state == 2'b00) begin
        if(Mmap2Stream_1__ap_start_global__q0) begin
          Mmap2Stream_1__state <= 2'b01;
        end 
      end 
      if(Mmap2Stream_1__state == 2'b01) begin
        if(Mmap2Stream_1__ap_ready) begin
          if(Mmap2Stream_1__ap_done) begin
            Mmap2Stream_1__state <= 2'b10;
          end else begin
            Mmap2Stream_1__state <= 2'b11;
          end
        end 
      end 
      if(Mmap2Stream_1__state == 2'b11) begin
        if(Mmap2Stream_1__ap_done) begin
          Mmap2Stream_1__state <= 2'b10;
        end 
      end 
      if(Mmap2Stream_1__state == 2'b10) begin
        if(Mmap2Stream_1__ap_done_global__q0) begin
          Mmap2Stream_1__state <= 2'b00;
        end 
      end 
    end
  end

  assign Mmap2Stream_1__ap_start = (Mmap2Stream_1__state == 2'b01);

  always @(posedge ap_clk) begin
  end

  assign Stream2Mmap_0___c__q0 = c;

  always @(posedge ap_clk) begin
  end

  assign Stream2Mmap_0___n__q0 = n;

  always @(posedge ap_clk) begin
  end

  assign Stream2Mmap_0__ap_rst_n__q0 = ap_rst_n;

  always @(posedge ap_clk) begin
  end

  assign Stream2Mmap_0__ap_start_global__q0 = ap_start__q0;

  always @(posedge ap_clk) begin
  end

  assign Stream2Mmap_0__is_done__q0 = (Stream2Mmap_0__state == 2'b10);

  always @(posedge ap_clk) begin
  end

  assign Stream2Mmap_0__ap_done_global__q0 = ap_done__q0;

  always @(posedge ap_clk) begin
    if(~Stream2Mmap_0__ap_rst_n__q0) begin
      Stream2Mmap_0__state <= 2'b00;
    end else begin
      if(Stream2Mmap_0__state == 2'b00) begin
        if(Stream2Mmap_0__ap_start_global__q0) begin
          Stream2Mmap_0__state <= 2'b01;
        end 
      end 
      if(Stream2Mmap_0__state == 2'b01) begin
        if(Stream2Mmap_0__ap_ready) begin
          if(Stream2Mmap_0__ap_done) begin
            Stream2Mmap_0__state <= 2'b10;
          end else begin
            Stream2Mmap_0__state <= 2'b11;
          end
        end 
      end 
      if(Stream2Mmap_0__state == 2'b11) begin
        if(Stream2Mmap_0__ap_done) begin
          Stream2Mmap_0__state <= 2'b10;
        end 
      end 
      if(Stream2Mmap_0__state == 2'b10) begin
        if(Stream2Mmap_0__ap_done_global__q0) begin
          Stream2Mmap_0__state <= 2'b00;
        end 
      end 
    end
  end

  assign Stream2Mmap_0__ap_start = (Stream2Mmap_0__state == 2'b01);

  always @(posedge ap_clk) begin
    if(ap_rst_n_inv) begin
      tapa_state <= 2'b00;
    end else begin
      case(tapa_state)
        2'b00: begin
          if(ap_start__q0) begin
            tapa_state <= 2'b01;
          end 
        end
        2'b01: begin
          if(Add_0__is_done__q0 && Mmap2Stream_0__is_done__q0 && Mmap2Stream_1__is_done__q0 && Stream2Mmap_0__is_done__q0) begin
            tapa_state <= 2'b10;
          end 
        end
        2'b10: begin
          tapa_state <= 2'b00;
          countdown <= 1'd0;
        end
        2'b11: begin
          if(countdown == 1'd0) begin
            tapa_state <= 2'b00;
          end else begin
            countdown <= (countdown - 1'd1);
          end
        end
      endcase
    end
  end

  assign ap_idle = (tapa_state == 2'b00);
  assign ap_done = ap_done__q0;
  assign ap_ready = ap_done__q0;

  always @(posedge ap_clk) begin
  end

  assign ap_start__q0 = ap_start;

  always @(posedge ap_clk) begin
  end

  assign ap_done__q0 = (tapa_state == 2'b10);

endmodule

