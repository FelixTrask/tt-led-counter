# SPDX-FileCopyrightText: © 2024 Tiny Tapeout
# SPDX-License-Identifier: Apache-2.0

import cocotb
from cocotb.clock import Clock
from cocotb.triggers import ClockCycles, FallingEdge


@cocotb.test()
async def test_project(dut):
    dut._log.info("Starting LED Counter Test!")

    # Set the clock period to 10MHz
    clock = Clock(dut.clk, 100, units="ns")
    cocotb.start_soon(clock.start())

    # Reset
    dut._log.info("Reset")
    dut.ena.value = 1
    dut.ui_in.value = 0
    dut.uio_in.value = 0
    dut.rst_n.value = 0
    await ClockCycles(dut.clk, 10)

    await FallingEdge(dut.clk)
    dut.rst_n.value = 1

    dut._log.info("Test project behavior")

    await FallingEdge(dut.clk)
    assert dut.uo_out.value == 0, f"Expected 0 after reset, got {dut.uo_out.value}"

    await ClockCycles(dut.clk, 65536) # Bit 0 changes every 65536 cycles (2^16)
    await FallingEdge(dut.clk)
    assert dut.uo_out.value == 1, f"Expected 1, got {dut.uo_out.value}"

    await ClockCycles(dut.clk, 65536)
    await FallingEdge(dut.clk)
    assert dut.uo_out.value == 2, f"Expected 2, got {dut.uo_out.value}"

    dut._log.info("LED Counter test passed successfully!")