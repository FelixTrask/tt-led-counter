<!---

This file is used to generate your project datasheet. Please fill in the information below and delete any unused
sections.

You can also include images in this folder and reference them in the markdown. Each image must be less than
512 kb in size, and the combined size of all images must be less than 1 MB.
-->

## How it works

This project implements a simple 24-bit synchronous binary counter driven by the main input clock (clk).

On every rising edge of clk, if the active-low reset signal (rst_n) is high and the module enable signal (ena) is high, the internal 24-bit register increments by 1.

If rst_n goes low (0), the entire 24-bit counter resets to 0.

The 8 most significant bits of the counter (count[23:16]) are directly mapped to the dedicated output pins (uo_out[7:0]).

Because the clock operates at a high frequency (e.g., 10 MHz), selecting the upper 8 bits acts as a clock divider, slowing down the output transitions so they can be visually observed as binary counting on connected LEDs.

## How to test

Apply a clock signal to the clk input.
Set ena to high (1).
Briefly pull rst_n low (0) to clear the counter, then return rst_n to high (1).
Observe the 8 dedicated output pins (uo_out[0] through uo_out[7]):uo_out[0] (bit 16 of the counter) will toggle every $2^{16}$ clock cycles ($65,536$ cycles).
The outputs as a whole will display an incrementing 8-bit binary pattern across the LEDs.

## External hardware

8x LEDs connected to outputs uo_out[0] through uo_out[7] to visualise the binary count.
