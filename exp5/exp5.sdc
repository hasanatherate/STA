create_clock -name clk -period 10 [get_ports clk]

# Input and output delays
set_input_delay 2 -clock clk [get_ports d_in]
set_output_delay 2 -clock clk [get_ports d_out]

# Enable clock skew analysis
set_clock_uncertainty 0.2 [get_clocks clk] ;# can model skew and jitter

#Optional: Force Clock Skew Using set_clock_latency

# Assume clk is routed to 3 FFs on different paths
set_clock_latency -source 0.0 [get_clocks clk] ;# clock source delay

# Target FFs: simulate skew
set_clock_latency -late 0.3 -rise [get_clocks clk] -fanout [get_cells FF1]  ;# late arrival to q1
set_clock_latency -late 0.1 -rise [get_clocks clk] -fanout [get_cells FF2]  ;# earlier arrival to q2
set_clock_latency -late 0.2 -rise [get_clocks clk] -fanout [get_cells FF3]  ;# d_out

report_timing 
report_clock 
