/*
 * Copyright (c) 2024 Felix Trask
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

module tt_um_felixtrask (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // always 1 when the design is powered, so you can ignore it
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);

  reg [23:0] count; // Save clock ticks, number from 0 to 2^23

  always @(posedge clk or negedge rst_n) begin // Begin if the clock is high or the reset pin is low
    if (!rst_n) begin // If the reset pin is low:
      count <= 24'b0; // Reset the count to 0 (24'b0 = 24 bytes, set to a 0)
    end else if (ena) begin // If ena is high (should always be):
      count <= count + 1'b1; // Increment the count by 1 (1'b1 = 1 byte, set to a 1)
    end
  end

  // Assign dedicated output to the top 8 bits of our count register
  assign uo_out = count[23:16];

  // Assign unused outputs
  assign uio_out = 8'b0;
  assign uio_oe  = 8'b0;

  // List all unused inputs to prevent warnings
  wire _unused = &{ena, clk, rst_n, 1'b0};

endmodule
