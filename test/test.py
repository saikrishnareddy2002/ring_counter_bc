# SPDX-FileCopyrightText: © 2024 Tiny Tapeout
# SPDX-License-Identifier: Apache-2.0

import cocotb
from cocotb.clock import Clock
from cocotb.triggers import ClockCycles


@cocotb.test()
async def test_ring_counter(dut):
    dut._log.info("Start ring counter test")

    # Set the clock period to 10 us (100 KHz)
    clock = Clock(dut.clk, 10, units="us")
    cocotb.start_soon(clock.start())

    # Reset
    dut._log.info("Reset")
    dut.ena.value = 1
    dut.ui_in.value = 0
    dut.uio_in.value = 0
    dut.rst_n.value = 0
    await ClockCycles(dut.clk, 5)
    dut.rst_n.value = 1

    # Expected sequence of values
    expected_seq = [
        0b0000_0001,
        0b0000_0010,
        0b0000_0100,
        0b0000_1000,
        0b0001_0000,
        0b0010_0000,
        0b0100_0000,
        0b1000_0000,
        0b0000_0001,  # wrap-around
    ]

    # Wait a cycle after releasing reset
    await ClockCycles(dut.clk, 1)

    # Check the sequence
    for expected in expected_seq:
        assert dut.uo_out.value == expected, \
            f"Ring counter mismatch: got {dut.uo_out.value}, expected {expected:08b}"
        dut._log.info(f"uo_out = {dut.uo_out.value} (expected {expected:08b})")
        await ClockCycles(dut.clk, 1)
