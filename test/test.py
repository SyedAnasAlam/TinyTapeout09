# SPDX-FileCopyrightText: © 2024 Tiny Tapeout
# SPDX-License-Identifier: Apache-2.0

import cocotb
from cocotb.clock import Clock
from cocotb.triggers import ClockCycles

import math


@cocotb.test()
async def test_project(dut):
    dut._log.info("Start")

    # Set the clock period to 10 us (100 KHz)
    T = 10
    f_in = 1/T
    clock = Clock(dut.clk, 10, units="us")
    cocotb.start_soon(clock.start())

    # Reset
    dut._log.info("Reset")
    dut.ena.value = 1
    dut.ui_in.value = 0
    dut.uio_in.value = 0
    dut.rst_n.value = 0
    await ClockCycles(dut.clk, 10)
    dut.rst_n.value = 1

    dut._log.info("PWM Generator Behaviour")

    # Test 1
    # Divide clock by 5
    # Duty cycle 40%
    pwm_top_base = 4
    pwm_top_shamt = 0
    pwm_top = pwm_top_base << pwm_top_shamt

    pwm_threshold_base = 1
    pwm_threshold_shamt = 0
    pwm_threshold = pwm_threshold_base << pwm_threshold_shamt
    
    f_out = f_in/(pwm_top + 1)
    duty_cycle = (pwm_threshold+1)/(pwm_top+1)

    cycles_on = (f_in/f_out)*duty_cycle
    cycles_off = (f_in/f_out)*(1-duty_cycle)

    dut.ui_in.value = (pwm_threshold_base << 5) | pwm_threshold_shamt
    dut.uio_in.value = (pwm_top_base << 5) | pwm_top_shamt

    await ClockCycles(dut.clk, 1)

    test_cycles = 10

    for i in range(test_cycles):

        for i in range(math.ceil(cycles_on)):
            await ClockCycles(dut.clk, 1)
            assert (dut.uo_out.value & 1) == 1
    
        for i in range(math.ceil(cycles_off)):
            await ClockCycles(dut.clk, 1)
            assert (dut.uo_out.value & 1) == 0

    # Test 2
    # Divide clock by 5
    # Duty cycle 80%
    pwm_top_base = 4
    pwm_top_shamt = 0
    pwm_top = pwm_top_base << pwm_top_shamt

    pwm_threshold_base = 3
    pwm_threshold_shamt = 0
    pwm_threshold = pwm_threshold_base << pwm_threshold_shamt
    
    f_out = f_in/(pwm_top + 1)
    duty_cycle = (pwm_threshold+1)/(pwm_top+1)

    cycles_on = (f_in/f_out)*duty_cycle
    cycles_off = (f_in/f_out)*(1-duty_cycle)

    dut.ui_in.value = (pwm_threshold_base << 5) | pwm_threshold_shamt
    dut.uio_in.value = (pwm_top_base << 5) | pwm_top_shamt

    test_cycles = 10

    for i in range(test_cycles):

        for i in range(math.ceil(cycles_on)):
            await ClockCycles(dut.clk, 1)
            assert (dut.uo_out.value & 1)  == 1
    
        for i in range(math.ceil(cycles_off)):
            await ClockCycles(dut.clk, 1)
            assert (dut.uo_out.value & 1)  == 0

    # Test 3
    # Divide clock by 25
    # Duty cycle 5%
    pwm_top_base = 3
    pwm_top_shamt = 3
    pwm_top = pwm_top_base << pwm_top_shamt

    pwm_threshold_base = 5
    pwm_threshold_shamt = 0
    pwm_threshold = pwm_threshold_base << pwm_threshold_shamt
    
    f_out = f_in/(pwm_top + 1)
    duty_cycle = (pwm_threshold+1)/(pwm_top+1)

    cycles_on = (f_in/f_out)*duty_cycle
    cycles_off = (f_in/f_out)*(1-duty_cycle)

    dut.ui_in.value = (pwm_threshold_base << 5) | pwm_threshold_shamt
    dut.uio_in.value = (pwm_top_base << 5) | pwm_top_shamt

    test_cycles = 10

    for i in range(test_cycles):

        for i in range(math.ceil(cycles_on)):
            await ClockCycles(dut.clk, 1)
            assert (dut.uo_out.value & 1)  == 1
    
        for i in range(math.ceil(cycles_off)):
            await ClockCycles(dut.clk, 1)
            assert (dut.uo_out.value & 1)  == 0

    # Test 4
    # Divide clock by 25
    # Duty cycle 70%
    pwm_top_base = 3
    pwm_top_shamt = 3
    pwm_top = pwm_top_base << pwm_top_shamt

    pwm_threshold_base = 1
    pwm_threshold_shamt = 4
    pwm_threshold = pwm_threshold_base << pwm_threshold_shamt
    
    f_out = f_in/(pwm_top + 1)
    duty_cycle = (pwm_threshold+1)/(pwm_top+1)

    cycles_on = (f_in/f_out)*duty_cycle
    cycles_off = (f_in/f_out)*(1-duty_cycle)

    dut.ui_in.value = (pwm_threshold_base << 5) | pwm_threshold_shamt
    dut.uio_in.value = (pwm_top_base << 5) | pwm_top_shamt

    test_cycles = 10

    for i in range(test_cycles):

        for i in range(math.ceil(cycles_on)):
            await ClockCycles(dut.clk, 1)
            assert (dut.uo_out.value & 1)  == 1
    
        for i in range(math.ceil(cycles_off)):
            await ClockCycles(dut.clk, 1)
            assert (dut.uo_out.value & 1)  == 0
    
    


