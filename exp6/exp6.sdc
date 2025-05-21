# Create a 50 MHz clock (20ns period)
create_clock -name clk -period 20 [get_ports clk]

# Input delay assuming external driver delay is 2ns
set_input_delay 2 -clock clk [get_ports rst_n]

# Output delay assuming next stage setup time is 2ns
set_output_delay 2 -clock clk [get_ports q[*]]

# Add 0.2ns clock uncertainty for jitter and margin
set_clock_uncertainty 0.2 [get_clocks clk]

Increase Clock Frequency to 200 MHz (5 ns)
# Tighter clock: 200 MHz
create_clock -name clk -period 5 [get_ports clk]

# Keep same I/O delays and uncertainty
set_input_delay 2 -clock clk [get_ports rst_n]
set_output_delay 2 -clock clk [get_ports q[*]]
set_clock_uncertainty 0.2 [get_clocks clk]

# Simulate late clock arrival (0.5ns skew)
set_clock_latency -late 0.5 -rise [get_clocks clk]
