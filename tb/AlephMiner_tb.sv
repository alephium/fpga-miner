// This is a generated file. Use and modify at your own risk.
////////////////////////////////////////////////////////////////////////////////
// default_nettype of none prevents implicit wire declaration.
`default_nettype none
`timescale 1 ps / 1 ps
import axi_vip_pkg::*;
import slv_m00_axi_vip_pkg::*;
import control_AlephMiner_vip_pkg::*;
module AlephMiner_tb ();
parameter integer LP_MAX_LENGTH = 8192;
parameter integer LP_MAX_TRANSFER_LENGTH = 16384 / 4;
parameter integer C_S_AXI_CONTROL_ADDR_WIDTH = 12;
parameter integer C_S_AXI_CONTROL_DATA_WIDTH = 32;
parameter integer C_M00_AXI_ADDR_WIDTH = 64;
parameter integer C_M00_AXI_DATA_WIDTH = 32;

// Control Register
parameter KRNL_CTRL_REG_ADDR     = 32'h00000000;
parameter CTRL_START_MASK        = 32'h00000001;
parameter CTRL_DONE_MASK         = 32'h00000002;
parameter CTRL_IDLE_MASK         = 32'h00000004;
parameter CTRL_READY_MASK        = 32'h00000008;
parameter CTRL_CONTINUE_MASK     = 32'h00000010; // Only ap_ctrl_chain
parameter CTRL_AUTO_RESTART_MASK = 32'h00000080; // Not used

// Global Interrupt Enable Register
parameter KRNL_GIE_REG_ADDR      = 32'h00000004;
parameter GIE_GIE_MASK           = 32'h00000001;
// IP Interrupt Enable Register
parameter KRNL_IER_REG_ADDR      = 32'h00000008;
parameter IER_DONE_MASK          = 32'h00000001;
parameter IER_READY_MASK         = 32'h00000002;
// IP Interrupt Status Register
parameter KRNL_ISR_REG_ADDR      = 32'h0000000c;
parameter ISR_DONE_MASK          = 32'h00000001;
parameter ISR_READY_MASK         = 32'h00000002;

parameter integer  LP_INST_NUM             = 4;  

parameter integer  LP_TARGET_BYTES         = 32;
parameter integer  LP_NONCE_BYTES          = 24;
parameter integer  LP_HEADERBLOB_BYTES     = 304;

parameter integer  LP_ALL_NONCE_BYTES      = (LP_NONCE_BYTES*LP_INST_NUM);

parameter integer LP_CLK_PERIOD_PS = 4000; // 250 MHz

//System Signals
logic ap_clk = 0;

initial begin: AP_CLK
  forever begin
    ap_clk = #(LP_CLK_PERIOD_PS/2) ~ap_clk;
  end
end
//AXI4 master interface m00_axi
wire [1-1:0] m00_axi_awvalid;
wire [1-1:0] m00_axi_awready;
wire [C_M00_AXI_ADDR_WIDTH-1:0] m00_axi_awaddr;
wire [8-1:0] m00_axi_awlen;
wire [1-1:0] m00_axi_wvalid;
wire [1-1:0] m00_axi_wready;
wire [C_M00_AXI_DATA_WIDTH-1:0] m00_axi_wdata;
wire [C_M00_AXI_DATA_WIDTH/8-1:0] m00_axi_wstrb;
wire [1-1:0] m00_axi_wlast;
wire [1-1:0] m00_axi_bvalid;
wire [1-1:0] m00_axi_bready;
wire [1-1:0] m00_axi_arvalid;
wire [1-1:0] m00_axi_arready;
wire [C_M00_AXI_ADDR_WIDTH-1:0] m00_axi_araddr;
wire [8-1:0] m00_axi_arlen;
wire [1-1:0] m00_axi_rvalid;
wire [1-1:0] m00_axi_rready;
wire [C_M00_AXI_DATA_WIDTH-1:0] m00_axi_rdata;
wire [1-1:0] m00_axi_rlast;
//AXI4LITE control signals
wire [1-1:0] s_axi_control_awvalid;
wire [1-1:0] s_axi_control_awready;
wire [C_S_AXI_CONTROL_ADDR_WIDTH-1:0] s_axi_control_awaddr;
wire [1-1:0] s_axi_control_wvalid;
wire [1-1:0] s_axi_control_wready;
wire [C_S_AXI_CONTROL_DATA_WIDTH-1:0] s_axi_control_wdata;
wire [C_S_AXI_CONTROL_DATA_WIDTH/8-1:0] s_axi_control_wstrb;
wire [1-1:0] s_axi_control_arvalid;
wire [1-1:0] s_axi_control_arready;
wire [C_S_AXI_CONTROL_ADDR_WIDTH-1:0] s_axi_control_araddr;
wire [1-1:0] s_axi_control_rvalid;
wire [1-1:0] s_axi_control_rready;
wire [C_S_AXI_CONTROL_DATA_WIDTH-1:0] s_axi_control_rdata;
wire [2-1:0] s_axi_control_rresp;
wire [1-1:0] s_axi_control_bvalid;
wire [1-1:0] s_axi_control_bready;
wire [2-1:0] s_axi_control_bresp;
wire interrupt;

  logic [23:0][31:0] nonce;  
  logic [7:0][31:0] target;
  logic [7:0] data_byte;
  logic [31:0] data;

// DUT instantiation
AlephMiner #(
  .C_S_AXI_CONTROL_ADDR_WIDTH ( C_S_AXI_CONTROL_ADDR_WIDTH ),
  .C_S_AXI_CONTROL_DATA_WIDTH ( C_S_AXI_CONTROL_DATA_WIDTH ),
  .C_M00_AXI_ADDR_WIDTH       ( C_M00_AXI_ADDR_WIDTH       ),
  .C_M00_AXI_DATA_WIDTH       ( C_M00_AXI_DATA_WIDTH       )
)
inst_dut (
  .ap_clk                ( ap_clk                ),
  .m00_axi_awvalid       ( m00_axi_awvalid       ),
  .m00_axi_awready       ( m00_axi_awready       ),
  .m00_axi_awaddr        ( m00_axi_awaddr        ),
  .m00_axi_awlen         ( m00_axi_awlen         ),
  .m00_axi_wvalid        ( m00_axi_wvalid        ),
  .m00_axi_wready        ( m00_axi_wready        ),
  .m00_axi_wdata         ( m00_axi_wdata         ),
  .m00_axi_wstrb         ( m00_axi_wstrb         ),
  .m00_axi_wlast         ( m00_axi_wlast         ),
  .m00_axi_bvalid        ( m00_axi_bvalid        ),
  .m00_axi_bready        ( m00_axi_bready        ),
  .m00_axi_arvalid       ( m00_axi_arvalid       ),
  .m00_axi_arready       ( m00_axi_arready       ),
  .m00_axi_araddr        ( m00_axi_araddr        ),
  .m00_axi_arlen         ( m00_axi_arlen         ),
  .m00_axi_rvalid        ( m00_axi_rvalid        ),
  .m00_axi_rready        ( m00_axi_rready        ),
  .m00_axi_rdata         ( m00_axi_rdata         ),
  .m00_axi_rlast         ( m00_axi_rlast         ),
  .s_axi_control_awvalid ( s_axi_control_awvalid ),
  .s_axi_control_awready ( s_axi_control_awready ),
  .s_axi_control_awaddr  ( s_axi_control_awaddr  ),
  .s_axi_control_wvalid  ( s_axi_control_wvalid  ),
  .s_axi_control_wready  ( s_axi_control_wready  ),
  .s_axi_control_wdata   ( s_axi_control_wdata   ),
  .s_axi_control_wstrb   ( s_axi_control_wstrb   ),
  .s_axi_control_arvalid ( s_axi_control_arvalid ),
  .s_axi_control_arready ( s_axi_control_arready ),
  .s_axi_control_araddr  ( s_axi_control_araddr  ),
  .s_axi_control_rvalid  ( s_axi_control_rvalid  ),
  .s_axi_control_rready  ( s_axi_control_rready  ),
  .s_axi_control_rdata   ( s_axi_control_rdata   ),
  .s_axi_control_rresp   ( s_axi_control_rresp   ),
  .s_axi_control_bvalid  ( s_axi_control_bvalid  ),
  .s_axi_control_bready  ( s_axi_control_bready  ),
  .s_axi_control_bresp   ( s_axi_control_bresp   ),
  .interrupt             ( interrupt             )
);

// Master Control instantiation
control_AlephMiner_vip inst_control_AlephMiner_vip (
  .aclk          ( ap_clk                ),
  .m_axi_awvalid ( s_axi_control_awvalid ),
  .m_axi_awready ( s_axi_control_awready ),
  .m_axi_awaddr  ( s_axi_control_awaddr  ),
  .m_axi_wvalid  ( s_axi_control_wvalid  ),
  .m_axi_wready  ( s_axi_control_wready  ),
  .m_axi_wdata   ( s_axi_control_wdata   ),
  .m_axi_wstrb   ( s_axi_control_wstrb   ),
  .m_axi_arvalid ( s_axi_control_arvalid ),
  .m_axi_arready ( s_axi_control_arready ),
  .m_axi_araddr  ( s_axi_control_araddr  ),
  .m_axi_rvalid  ( s_axi_control_rvalid  ),
  .m_axi_rready  ( s_axi_control_rready  ),
  .m_axi_rdata   ( s_axi_control_rdata   ),
  .m_axi_rresp   ( s_axi_control_rresp   ),
  .m_axi_bvalid  ( s_axi_control_bvalid  ),
  .m_axi_bready  ( s_axi_control_bready  ),
  .m_axi_bresp   ( s_axi_control_bresp   )
);

control_AlephMiner_vip_mst_t  ctrl;

// Slave MM VIP instantiation
slv_m00_axi_vip inst_slv_m00_axi_vip (
  .aclk          ( ap_clk          ),
  .s_axi_awvalid ( m00_axi_awvalid ),
  .s_axi_awready ( m00_axi_awready ),
  .s_axi_awaddr  ( m00_axi_awaddr  ),
  .s_axi_awlen   ( m00_axi_awlen   ),
  .s_axi_wvalid  ( m00_axi_wvalid  ),
  .s_axi_wready  ( m00_axi_wready  ),
  .s_axi_wdata   ( m00_axi_wdata   ),
  .s_axi_wstrb   ( m00_axi_wstrb   ),
  .s_axi_wlast   ( m00_axi_wlast   ),
  .s_axi_bvalid  ( m00_axi_bvalid  ),
  .s_axi_bready  ( m00_axi_bready  ),
  .s_axi_arvalid ( m00_axi_arvalid ),
  .s_axi_arready ( m00_axi_arready ),
  .s_axi_araddr  ( m00_axi_araddr  ),
  .s_axi_arlen   ( m00_axi_arlen   ),
  .s_axi_rvalid  ( m00_axi_rvalid  ),
  .s_axi_rready  ( m00_axi_rready  ),
  .s_axi_rdata   ( m00_axi_rdata   ),
  .s_axi_rlast   ( m00_axi_rlast   )
);


slv_m00_axi_vip_slv_mem_t   m00_axi;
slv_m00_axi_vip_slv_t   m00_axi_slv;

parameter NUM_AXIS_MST = 0;
parameter NUM_AXIS_SLV = 0;

bit               error_found = 0;

///////////////////////////////////////////////////////////////////////////
// Pointer for interface : m00_axi
bit [63:0] TargetIn_ptr = 64'h0;

///////////////////////////////////////////////////////////////////////////
// Pointer for interface : m00_axi
bit [63:0] HeaderBlobIn_ptr = 64'h0;

///////////////////////////////////////////////////////////////////////////
// Pointer for interface : m00_axi
bit [63:0] NonceIn_ptr = 64'h0;

///////////////////////////////////////////////////////////////////////////
// Pointer for interface : m00_axi
bit [63:0] Results_ptr = 64'h0;
/////////////////////////////////////////////////////////////////////////////////////////////////
// Backdoor fill the m00_axi memory.
function void m00_axi_fill_memory(
  input bit [63:0] ptr,
  input integer    length
);
  for (longint unsigned slot = 0; slot < length; slot++) begin
    m00_axi.mem_model.backdoor_memory_write_4byte(ptr + (slot * 4), slot);
  end
endfunction

/////////////////////////////////////////////////////////////////////////////////////////////////
// Generate a random 32bit number
function bit [31:0] get_random_4bytes();
  bit [31:0] rptr;
  ptr_random_failed: assert(std::randomize(rptr));
  return(rptr);
endfunction

/////////////////////////////////////////////////////////////////////////////////////////////////
// Generate a random 64bit 4k aligned address pointer.
function bit [63:0] get_random_ptr();
  bit [63:0] rptr;
  ptr_random_failed: assert(std::randomize(rptr));
  rptr[31:0] &= ~(32'h00000fff);
  return(rptr);
endfunction

/////////////////////////////////////////////////////////////////////////////////////////////////
// Control interface non-blocking write
// The task will return when the transaction has been accepted by the driver. It will be some
// amount of time before it will appear on the interface.
task automatic write_register (input bit [31:0] addr_in, input bit [31:0] data);
  axi_transaction   wr_xfer;
  wr_xfer = ctrl.wr_driver.create_transaction("wr_xfer");
  assert(wr_xfer.randomize() with {addr == addr_in;});
  wr_xfer.set_data_beat(0, data);
  ctrl.wr_driver.send(wr_xfer);
endtask

/////////////////////////////////////////////////////////////////////////////////////////////////
// Control interface blocking write
// The task will return when the BRESP has been returned from the kernel.
task automatic blocking_write_register (input bit [31:0] addr_in, input bit [31:0] data);
  axi_transaction   wr_xfer;
  axi_transaction   wr_rsp;
  wr_xfer = ctrl.wr_driver.create_transaction("wr_xfer");
  wr_xfer.set_driver_return_item_policy(XIL_AXI_PAYLOAD_RETURN);
  assert(wr_xfer.randomize() with {addr == addr_in;});
  wr_xfer.set_data_beat(0, data);
  ctrl.wr_driver.send(wr_xfer);
  ctrl.wr_driver.wait_rsp(wr_rsp);
endtask

/////////////////////////////////////////////////////////////////////////////////////////////////
// Control interface blocking read
// The task will return when the BRESP has been returned from the kernel.
task automatic read_register (input bit [31:0] addr, output bit [31:0] rddata);
  axi_transaction   rd_xfer;
  axi_transaction   rd_rsp;
  bit [31:0] rd_value;
  rd_xfer = ctrl.rd_driver.create_transaction("rd_xfer");
  rd_xfer.set_addr(addr);
  rd_xfer.set_driver_return_item_policy(XIL_AXI_PAYLOAD_RETURN);
  ctrl.rd_driver.send(rd_xfer);
  ctrl.rd_driver.wait_rsp(rd_rsp);
  rd_value = rd_rsp.get_data_beat(0);
  rddata = rd_value;
endtask



/////////////////////////////////////////////////////////////////////////////////////////////////
// Poll the Control interface status register.
// This will poll until the DONE flag in the status register is asserted.
task automatic poll_done_register ();
  bit [31:0] rd_value;
  do begin
    read_register(KRNL_CTRL_REG_ADDR, rd_value);
  end while ((rd_value & CTRL_DONE_MASK) == 0);
endtask

// This will poll until the IDLE flag in the status register is asserted.
task automatic poll_idle_register ();
  bit [31:0] rd_value;
  do begin
    read_register(KRNL_CTRL_REG_ADDR, rd_value);
  end while ((rd_value & CTRL_IDLE_MASK) == 0);
endtask

/////////////////////////////////////////////////////////////////////////////////////////////////
// Write to the control registers to enable the triggering of interrupts for the kernel
task automatic enable_interrupts();
  $display("Starting: Enabling Interrupts....");
  write_register(KRNL_GIE_REG_ADDR, GIE_GIE_MASK);
  write_register(KRNL_IER_REG_ADDR, IER_DONE_MASK);
  $display("Finished: Interrupts enabled.");
endtask

/////////////////////////////////////////////////////////////////////////////////////////////////
// Disabled the interrupts.
task automatic disable_interrupts();
  $display("Starting: Disable Interrupts....");
  write_register(KRNL_GIE_REG_ADDR, 32'h0);
  write_register(KRNL_IER_REG_ADDR, 32'h0);
  $display("Finished: Interrupts disabled.");
endtask

/////////////////////////////////////////////////////////////////////////////////////////////////
//When the interrupt is asserted, read the correct registers and clear the asserted interrupt.
task automatic service_interrupts();
  bit [31:0] rd_value;
  $display("Starting Servicing interrupts....");
  read_register(KRNL_CTRL_REG_ADDR, rd_value);
  $display("Control Register: 0x%0x", rd_value);

  blocking_write_register(KRNL_CTRL_REG_ADDR, rd_value);

  if ((rd_value & CTRL_DONE_MASK) == 0) begin
    $error("%t : DONE bit not asserted. Register value: (0x%0x)", $time, rd_value);
  end
  read_register(KRNL_ISR_REG_ADDR, rd_value);
  $display("Interrupt Status Register: 0x%0x", rd_value);
  blocking_write_register(KRNL_ISR_REG_ADDR, rd_value);
  $display("Finished Servicing interrupts");
endtask

/////////////////////////////////////////////////////////////////////////////////////////////////
// Start the control VIP, SLAVE memory models and AXI4-Stream.
task automatic start_vips();

  $display("///////////////////////////////////////////////////////////////////////////");
  $display("Control Master: ctrl");
  ctrl = new("ctrl", AlephMiner_tb.inst_control_AlephMiner_vip.inst.IF);
  ctrl.start_master();

  $display("///////////////////////////////////////////////////////////////////////////");
  $display("Starting Memory slave: m00_axi");
  m00_axi = new("m00_axi", AlephMiner_tb.inst_slv_m00_axi_vip.inst.IF);
  m00_axi.start_slave();

endtask

/////////////////////////////////////////////////////////////////////////////////////////////////
// For each of the connected slave interfaces, set the Slave to not de-assert WREADY at any time.
// This will show the fastest outbound bandwidth from the WRITE channel.
task automatic slv_no_backpressure_wready();
  axi_ready_gen     rgen;
  $display("%t - Applying slv_no_backpressure_wready", $time);

  rgen = new("m00_axi_no_backpressure_wready");
  rgen.set_ready_policy(XIL_AXI_READY_GEN_NO_BACKPRESSURE);
  m00_axi.wr_driver.set_wready_gen(rgen);

endtask


/////////////////////////////////////////////////////////////////////////////////////////////////
// For each of the connected slave interfaces, apply a WREADY policy to introduce backpressure.
// Based on the simulation seed the order/shape of the WREADY per-channel will be different.
task automatic slv_random_backpressure_wready();
  axi_ready_gen     rgen;
  $display("%t - Applying slv_random_backpressure_wready", $time);

  rgen = new("m00_axi_random_backpressure_wready");
  rgen.set_ready_policy(XIL_AXI_READY_GEN_RANDOM);
  rgen.set_low_time_range(0,12);
  rgen.set_high_time_range(1,12);
  rgen.set_event_count_range(3,5);
  m00_axi.wr_driver.set_wready_gen(rgen);

endtask


/////////////////////////////////////////////////////////////////////////////////////////////////
// For each of the connected slave interfaces, force the memory model to not insert any inter-beat
// gaps on the READ channel.
task automatic slv_no_delay_rvalid();
  $display("%t - Applying slv_no_delay_rvalid", $time);

  m00_axi.mem_model.set_inter_beat_gap_delay_policy(XIL_AXI_MEMORY_DELAY_FIXED);
  m00_axi.mem_model.set_inter_beat_gap(0);

endtask

/////////////////////////////////////////////////////////////////////////////////////////////////
// For each of the connected slave interfaces, Allow the memory model to insert any inter-beat
// gaps on the READ channel.
task automatic slv_random_delay_rvalid();
  $display("%t - Applying slv_random_delay_rvalid", $time);

  m00_axi.mem_model.set_inter_beat_gap_delay_policy(XIL_AXI_MEMORY_DELAY_RANDOM);
  m00_axi.mem_model.set_inter_beat_gap_range(0,10);

endtask

/////////////////////////////////////////////////////////////////////////////////////////////////
// Check to ensure, following reset the value of the register is 0.
// Check that only the width of the register bits can be written.
task automatic check_register_value(input bit [31:0] addr_in, input integer unsigned register_width, output bit error_found);
  bit [31:0] rddata;
  bit [31:0] mask_data;
  error_found = 0;
  if (register_width < 32) begin
    mask_data = (1 << register_width) - 1;
  end else begin
    mask_data = 32'hffffffff;
  end
  read_register(addr_in, rddata);
  if (rddata != 32'h0) begin
    $error("Initial value mismatch: A:0x%0x : Expected 0x%x -> Got 0x%x", addr_in, 0, rddata);
    error_found = 1;
  end
  blocking_write_register(addr_in, 32'hffffffff);
  read_register(addr_in, rddata);
  if (rddata != mask_data) begin
    $error("Initial value mismatch: A:0x%0x : Expected 0x%x -> Got 0x%x", addr_in, mask_data, rddata);
    error_found = 1;
  end
endtask


/////////////////////////////////////////////////////////////////////////////////////////////////
// For each of the scalar registers, check:
// * reset value
// * correct number bits set on a write
task automatic check_scalar_registers(output bit error_found);
  bit tmp_error_found = 0;
  error_found = 0;
  $display("%t : Checking post reset values of scalar registers", $time);

  ///////////////////////////////////////////////////////////////////////////
  //Check ID 0: FromGroup (0x010)
  check_register_value(32'h010, 8, tmp_error_found);
  error_found |= tmp_error_found;

  ///////////////////////////////////////////////////////////////////////////
  //Check ID 1: ToGroup (0x018)
  check_register_value(32'h018, 8, tmp_error_found);
  error_found |= tmp_error_found;

  ///////////////////////////////////////////////////////////////////////////
  //Check ID 2: Groups (0x020)
  check_register_value(32'h020, 8, tmp_error_found);
  error_found |= tmp_error_found;

  ///////////////////////////////////////////////////////////////////////////
  //Check ID 3: GroupsShifter (0x028)
  check_register_value(32'h028, 8, tmp_error_found);
  error_found |= tmp_error_found;

  ///////////////////////////////////////////////////////////////////////////
  //Check ID 4: ChainNum (0x030)
  check_register_value(32'h030, 8, tmp_error_found);
  error_found |= tmp_error_found;

  ///////////////////////////////////////////////////////////////////////////
  //Check ID 5: ChunkLength (0x038)
  check_register_value(32'h038, 16, tmp_error_found);
  error_found |= tmp_error_found;

  ///////////////////////////////////////////////////////////////////////////
  //Check ID 6: MiningSteps (0x040)
  check_register_value(32'h040, 32, tmp_error_found);
  error_found |= tmp_error_found;

endtask

task automatic set_scalar_registers();
  $display("%t : Setting Scalar Registers registers", $time);

  ///////////////////////////////////////////////////////////////////////////
  //Write ID 0: FromGroup (0x010) -> 32'hffffffff (scalar)
  write_register(32'h010, 32'hffffffff);

  ///////////////////////////////////////////////////////////////////////////
  //Write ID 1: ToGroup (0x018) -> 32'hffffffff (scalar)
  write_register(32'h018, 32'hffffffff);

  ///////////////////////////////////////////////////////////////////////////
  //Write ID 2: Groups (0x020) -> 32'hffffffff (scalar)
  write_register(32'h020, 32'hffffffff);

  ///////////////////////////////////////////////////////////////////////////
  //Write ID 3: GroupsShifter (0x028) -> 32'hffffffff (scalar)
  write_register(32'h028, 32'hffffffff);

  ///////////////////////////////////////////////////////////////////////////
  //Write ID 4: ChainNum (0x030) -> 32'hffffffff (scalar)
  write_register(32'h030, 32'hffffffff);

  ///////////////////////////////////////////////////////////////////////////
  //Write ID 5: ChunkLength (0x038) -> 32'hffffffff (scalar)
  write_register(32'h038, 32'hffffffff);

  ///////////////////////////////////////////////////////////////////////////
  //Write ID 6: MiningSteps (0x040) -> 32'hffffffff (scalar)
  write_register(32'h040, 32'hffffffff);

endtask

task automatic write_scalar_registers();
  $display("%t : Setting Scalar Registers registers", $time);

  ///////////////////////////////////////////////////////////////////////////
  //Write ID 0: FromGroup (0x010) -> 32'hffffffff (scalar)
  write_register(32'h010, 32'h00000002);

  ///////////////////////////////////////////////////////////////////////////
  //Write ID 1: ToGroup (0x018) -> 32'hffffffff (scalar)
  write_register(32'h018, 32'h00000003);

  ///////////////////////////////////////////////////////////////////////////
  //Write ID 2: Groups (0x020) -> 32'hffffffff (scalar)
  write_register(32'h020, 32'h00000004);

  ///////////////////////////////////////////////////////////////////////////
  //Write ID 3: GroupsShifter (0x028) -> 32'hffffffff (scalar)
  write_register(32'h028, 32'h00000002);

  ///////////////////////////////////////////////////////////////////////////
  //Write ID 4: ChainNum (0x030) -> 32'hffffffff (scalar)
  write_register(32'h030, 32'h00000010);

  ///////////////////////////////////////////////////////////////////////////
  //Write ID 5: ChunkLength (0x038) -> 32'hffffffff (scalar)
  write_register(32'h038, 32'h00000146);

  ///////////////////////////////////////////////////////////////////////////
  //Write ID 6: MiningSteps (0x040) -> 32'hffffffff (scalar)
  write_register(32'h040, 32'h00002710);

endtask

task automatic check_pointer_registers(output bit error_found);
  bit tmp_error_found = 0;
  ///////////////////////////////////////////////////////////////////////////
  //Check the reset states of the pointer registers.
  $display("%t : Checking post reset values of pointer registers", $time);

  ///////////////////////////////////////////////////////////////////////////
  //Write ID 7: TargetIn (0x048)
  check_register_value(32'h048, 32, tmp_error_found);
  error_found |= tmp_error_found;

  ///////////////////////////////////////////////////////////////////////////
  //Write ID 7: TargetIn (0x04c)
  check_register_value(32'h04c, 32, tmp_error_found);
  error_found |= tmp_error_found;

  ///////////////////////////////////////////////////////////////////////////
  //Write ID 8: HeaderBlobIn (0x054)
  check_register_value(32'h054, 32, tmp_error_found);
  error_found |= tmp_error_found;

  ///////////////////////////////////////////////////////////////////////////
  //Write ID 8: HeaderBlobIn (0x058)
  check_register_value(32'h058, 32, tmp_error_found);
  error_found |= tmp_error_found;

  ///////////////////////////////////////////////////////////////////////////
  //Write ID 9: NonceIn (0x060)
  check_register_value(32'h060, 32, tmp_error_found);
  error_found |= tmp_error_found;

  ///////////////////////////////////////////////////////////////////////////
  //Write ID 9: NonceIn (0x064)
  check_register_value(32'h064, 32, tmp_error_found);
  error_found |= tmp_error_found;

  ///////////////////////////////////////////////////////////////////////////
  //Write ID 10: Results (0x06c)
  check_register_value(32'h06c, 32, tmp_error_found);
  error_found |= tmp_error_found;

  ///////////////////////////////////////////////////////////////////////////
  //Write ID 10: Results (0x070)
  check_register_value(32'h070, 32, tmp_error_found);
  error_found |= tmp_error_found;

endtask

task automatic set_memory_pointers();
  ///////////////////////////////////////////////////////////////////////////
  //Randomly generate memory pointers.
  TargetIn_ptr = get_random_ptr();
  HeaderBlobIn_ptr = get_random_ptr();
  NonceIn_ptr = get_random_ptr();
  Results_ptr = get_random_ptr();

  ///////////////////////////////////////////////////////////////////////////
  //Write ID 7: TargetIn (0x048) -> Randomized 4k aligned address (Global memory, lower 32 bits)
  write_register(32'h048, TargetIn_ptr[31:0]);

  ///////////////////////////////////////////////////////////////////////////
  //Write ID 7: TargetIn (0x04c) -> Randomized 4k aligned address (Global memory, upper 32 bits)
  write_register(32'h04c, TargetIn_ptr[63:32]);

  ///////////////////////////////////////////////////////////////////////////
  //Write ID 8: HeaderBlobIn (0x054) -> Randomized 4k aligned address (Global memory, lower 32 bits)
  write_register(32'h054, HeaderBlobIn_ptr[31:0]);

  ///////////////////////////////////////////////////////////////////////////
  //Write ID 8: HeaderBlobIn (0x058) -> Randomized 4k aligned address (Global memory, upper 32 bits)
  write_register(32'h058, HeaderBlobIn_ptr[63:32]);

  ///////////////////////////////////////////////////////////////////////////
  //Write ID 9: NonceIn (0x060) -> Randomized 4k aligned address (Global memory, lower 32 bits)
  write_register(32'h060, NonceIn_ptr[31:0]);

  ///////////////////////////////////////////////////////////////////////////
  //Write ID 9: NonceIn (0x064) -> Randomized 4k aligned address (Global memory, upper 32 bits)
  write_register(32'h064, NonceIn_ptr[63:32]);

  ///////////////////////////////////////////////////////////////////////////
  //Write ID 10: Results (0x06c) -> Randomized 4k aligned address (Global memory, lower 32 bits)
  write_register(32'h06c, Results_ptr[31:0]);

  ///////////////////////////////////////////////////////////////////////////
  //Write ID 10: Results (0x070) -> Randomized 4k aligned address (Global memory, upper 32 bits)
  write_register(32'h070, Results_ptr[63:32]);

endtask

task automatic backdoor_fill_memories(integer unsigned iter);

  target[0] = 32'hffffffff;
  target[1] = 32'hffffffff;
  target[2] = 32'hffffffff;
  target[3] = 32'hffffffff;
  target[4] = 32'hffffffff;
  target[5] = 32'hffffffff;
  target[6] = 32'hffffffff;
  target[7] = 32'h000fffff;
  if(iter==1)
    target[7] = 32'h0fffffff;

  nonce[0] = 32'h14151617;
  nonce[1] = 32'h10111213;
  nonce[2] = 32'h0C0D0E0F;
  nonce[3] = 32'h08090A0B;
  nonce[4] = 32'h04050607;
  nonce[5] = 32'h00010203;

  nonce[6] = 32'h14152617;
  nonce[7] = 32'h10111213;
  nonce[8] = 32'h0C0D0E0F;
  nonce[9] = 32'h08090A0B;
  nonce[10] = 32'h04050607;
  nonce[11] = 32'h00010203;

  nonce[12] = 32'h14153617;
  nonce[13] = 32'h10111213;
  nonce[14] = 32'h0C0D0E0F;
  nonce[15] = 32'h08090A0B;
  nonce[16] = 32'h04050607;
  nonce[17] = 32'h00010203;

  nonce[18] = 32'h14154617;
  nonce[19] = 32'h10111213;
  nonce[20] = 32'h0C0D0E0F;
  nonce[21] = 32'h08090A0B;
  nonce[22] = 32'h04050607;
  nonce[23] = 32'h00010203;

  /////////////////////////////////////////////////////////////////////////////////////////////////
  // Backdoor fill the memory with the content.
  for (longint unsigned slot = 0; slot < LP_TARGET_BYTES/4; slot++) begin
    m00_axi.mem_model.backdoor_memory_write_4byte(TargetIn_ptr + (slot * 4), target[slot]);
  end
  for (longint unsigned slot = 0; slot < LP_ALL_NONCE_BYTES/4; slot++) begin
    m00_axi.mem_model.backdoor_memory_write_4byte(NonceIn_ptr + (slot * 4), nonce[slot]);
  end
  
  data_byte = 8'h18;
  for (longint unsigned slot = 0; slot < LP_HEADERBLOB_BYTES/4; slot++) begin
    data[7:0] =    data_byte;
    data[15:8] =  (data_byte < 250) ? data_byte + 1 : 0;
    if(slot==LP_HEADERBLOB_BYTES/4-1) begin
        data[31:16] = 0;
    end
    else begin
        data[23:16] = (data_byte < 249) ? data_byte + 2 : data_byte%249;
        data[31:24] = (data_byte < 248) ? data_byte + 3 : data_byte%248;
    end
    m00_axi.mem_model.backdoor_memory_write_4byte(HeaderBlobIn_ptr + (slot * 4), data);
    if(data_byte < 247)
      data_byte = data_byte + 4;
    else
      data_byte = data_byte%247;
   end

endtask

function automatic bit check_kernel_result();
  bit [31:0]        ret_rd_value = 32'h0;
  bit error_found = 0;
  integer error_counter;
  error_counter = 0;

  /////////////////////////////////////////////////////////////////////////////////////////////////
  // Checking memory connected to m00_axi
  for (longint unsigned slot = 0; slot < 8; slot++) begin
    ret_rd_value = m00_axi.mem_model.backdoor_memory_read_4byte(TargetIn_ptr + (slot * 4));
    if (slot < LP_MAX_TRANSFER_LENGTH) begin
      if (ret_rd_value != target[slot]) begin
        $error("Memory Mismatch: m00_axi : @0x%x : Expected 0x%x -> Got 0x%x ", TargetIn_ptr + (slot * 4), slot + 1, ret_rd_value);
        error_found |= 1;
        error_counter++;
      end
    end else begin
      if (ret_rd_value != slot) begin
        $error("Memory Mismatch: m00_axi : @0x%x : Expected 0x%x -> Got 0x%x ", TargetIn_ptr + (slot * 4), slot, ret_rd_value);
        error_found |= 1;
        error_counter++;
      end
    end
    if (error_counter > 5) begin
      $display("Too many errors found. Exiting check of m00_axi.");
      slot = LP_MAX_LENGTH;
    end
  end
  for (longint unsigned slot = 0; slot < (6+1+8); slot++) begin
    ret_rd_value = m00_axi.mem_model.backdoor_memory_read_4byte(Results_ptr + (slot * 4));
    if(slot < 6)
      $display("Nonce %d 0x%x", slot, ret_rd_value);
    else if(slot < 7)
      $display("Hashcounter 0x%x", ret_rd_value);
    else
      $display("Hash out %d 0x%x", slot, ret_rd_value);
  end
  
  error_counter = 0;

  return(error_found);
endfunction

bit choose_pressure_type = 0;
bit axis_choose_pressure_type = 0;
bit [0-1:0] axis_tlast_received;

/////////////////////////////////////////////////////////////////////////////////////////////////
// Set up the kernel for operation and set the kernel START bit.
// The task will poll the DONE bit and check the results when complete.
task automatic multiple_iteration(input integer unsigned num_iterations, output bit error_found);
  error_found = 0;

  $display("Starting: multiple_iteration");
  for (integer unsigned iter = 0; iter < num_iterations; iter++) begin

    
    $display("Starting iteration: %d / %d", iter+1, num_iterations);
    RAND_WREADY_PRESSURE_FAILED: assert(std::randomize(choose_pressure_type));
    case(choose_pressure_type)
      0: slv_no_backpressure_wready();
      1: slv_random_backpressure_wready();
    endcase
    RAND_RVALID_PRESSURE_FAILED: assert(std::randomize(choose_pressure_type));
    case(choose_pressure_type)
      0: slv_no_delay_rvalid();
      1: slv_random_delay_rvalid();
    endcase

    write_scalar_registers();
    set_memory_pointers();
    backdoor_fill_memories(iter);
    // Check that Kernel is IDLE before starting.
    poll_idle_register();
    ///////////////////////////////////////////////////////////////////////////
    //Start transfers
    blocking_write_register(KRNL_CTRL_REG_ADDR, CTRL_START_MASK);

    ctrl.wait_drivers_idle();
    ///////////////////////////////////////////////////////////////////////////
    //Wait for interrupt being asserted or poll done register
    @(posedge interrupt);

    ///////////////////////////////////////////////////////////////////////////
    // Service the interrupt
    service_interrupts();
    wait(interrupt == 0);

    ///////////////////////////////////////////////////////////////////////////
    error_found |= check_kernel_result()   ;

    $display("Finished iteration: %d / %d", iter+1, num_iterations);
  end
 endtask

/////////////////////////////////////////////////////////////////////////////////////////////////
//Instantiate AXI4 LITE VIP
initial begin : STIMULUS
  #200000;
  start_vips();
  check_scalar_registers(error_found);
  if (error_found == 1) begin
    $display( "Test Failed!");
    $finish();
  end

  check_pointer_registers(error_found);
  if (error_found == 1) begin
    $display( "Test Failed!");
    $finish();
  end

  enable_interrupts();

  multiple_iteration(2, error_found);
  
  #200000;
  
  if (error_found == 1) begin
    $display( "Test Failed!");
    $finish();
  end
  

  if (error_found == 1) begin
    $display( "Test Failed!");
    $finish();
  end else begin
    $display( "Test completed successfully");
  end
  $finish;
end

endmodule
`default_nettype wire

