create_clock -period 10 [get_ports clk]  ;# 10ns clock period (100 MHz)

# Input Delay (assuming inputs arrive late in the cycle)
set_input_delay 2.5 -clock clk [all_inputs]

# Output Delay (assuming outputs needed early in next clock)
set_output_delay 2.5 -clock clk [all_outputs]

# Driving cell (optional, modeling that inputs come from a flip-flop)
set_drive 1 [all_inputs]

# Load on outputs (optional, modeling that outputs drive a flop)
set_load 1 [all_outputs]

# (Optional) Limit max transition time and max fanout to control QOR
set_max_transition 0.5 [current_design]
set_max_fanout 5 [current_design]
