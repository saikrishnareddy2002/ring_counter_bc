## How it works

This project is an **8-bit ring counter**.  
It is essentially a shift register with feedback: a single logic `1` bit circulates through the register, while all other bits remain `0`.  

- On reset (`rst_n = 0`), the counter initializes to `0000_0001`.  
- On each rising edge of the clock, the `1` shifts left by one position.  
- After reaching the MSB (`1000_0000`), the next clock wraps the `1` back to the LSB (`0000_0001`).  

This produces a repeating 8-state sequence useful for LED chasers, timing circuits, and state machines.

## How to test

1. Provide a clock signal to `clk`.  
   - Example: 100 kHz clock used in the testbench.  
2. Hold `rst_n = 0` for a few cycles to reset the counter, then release it (`rst_n = 1`).  
3. Observe the outputs `uo[7:0]`.  
   - Only one output bit will be high at a time.  
   - The high bit moves left one position per clock.  
4. After 8 clocks, the sequence repeats.

You can connect `uo[0]..uo[7]` to LEDs to see the "walking 1" effect.

## Truth table (sequence of outputs)

| Clock Cycle | `uo[7:0]` Output |
|-------------|------------------|
| Reset       | 0000_0001        |
| 1           | 0000_0010        |
| 2           | 0000_0100        |
| 3           | 0000_1000        |
| 4           | 0001_0000        |
| 5           | 0010_0000        |
| 6           | 0100_0000        |
| 7           | 1000_0000        |
| 8           | 0000_0001 (wrap around) |

## External hardware

- None required.  
- Optional: connect `uo[0]..uo[7]` to 8 LEDs for visual demonstration.
