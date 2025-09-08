`default_nettype none
`timescale 1ns / 1ps

/* 
 * This testbench instantiates the ring counter module
 * and wires up its inputs/outputs.
 * Includes a free-running clock.
 * No stimulus/test cases are included here.
 */
module tb ();

  // Dump the signals to a VCD file. You can view it with gtkwave or surfer.
  initial begin
    $dumpfile("tb.vcd");
    $dumpvars(0, tb);
    #1;
  end

  // Clock and reset
  reg clk;
  reg rst_n;
  reg ena;

  // IOs
  reg  [7:0] ui_in;
  reg  [7:0] uio_in;
  wire [7:0] uo_out;
  wire [7:0] uio_out;
  wire [7:0] uio_oe;

`ifdef GL_TEST
  wire VPWR = 1'b1;
  wire VGND = 1'b0;
`endif

  // Instantiate DUT: tt_um_ring_counter
  tt_um_ring_counter user_project (

      // Include power ports for Gate-Level test:
`ifdef GL_TEST
      .VPWR(VPWR),
      .VGND(VGND),
`endif

      .ui_in  (ui_in),    // Dedicated inputs
      .uo_out (uo_out),   // Dedicated outputs
      .uio_in (uio_in),   // IOs: Input path
      .uio_out(uio_out),  // IOs: Output path
      .uio_oe (uio_oe),   // IOs: Enable path
      .ena    (ena),      // enable
      .clk    (clk),      // clock
      .rst_n  (rst_n)     // reset (active low)
  );

  // Clock generation: 10ns period (100 MHz)
  initial clk = 0;
  always #5 clk = ~clk;

endmodule
