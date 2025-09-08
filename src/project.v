/*
 * Copyright (c) 2024
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

module tt_um_ring_counter (
    input  wire [7:0] ui_in,    // Dedicated inputs (can be used for control, e.g., enable)
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // always 1 when the design is powered
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);

  // 8-bit ring counter register
  reg [7:0] ring;

  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      // Initialize ring counter with bit[0] = 1
      ring <= 8'b0000_0001;
    end else begin
      // Rotate left: MSB wraps around to LSB
      ring <= {ring[6:0], ring[7]};
    end
  end

  // Drive outputs
  assign uo_out  = ring;  // Show the ring counter value on dedicated outputs
  assign uio_out = 0;     // Not used
  assign uio_oe  = 0;     // All IOs as input

  // Prevent unused signal warnings
  wire _unused = &{ena, ui_in, uio_in, 1'b0};

endmodule
