Critical Path Identification in a Ripple Carry Adder (RCA)
We will:
1. Identify the critical path in a Ripple Carry Adder (RCA) using an EDA tool.
2. Measure the longest delay path (critical path delay).
3. Optimize the design and compare the impact on critical path delay.
ripple_carry_adder.v
module full_adder (
input wire a, b, cin,
output wire sum, cout
);
assign sum = a ^ b ^ cin;
assign cout = (a & b) | (b & cin) | (a & cin);
endmodule
module ripple_carry_adder #(parameter N = 8) (
input wire [N-1:0] a, b,
input wire cin,
output wire [N-1:0] sum,
output wire cout
);
wire [N:0] carry;
assign carry[0] = cin;
genvar i;
generate
for (i = 0; i < N; i = i + 1) begin: adder_stage
full_adder FA (
.a(a[i]),
.b(b[i]),
.cin(carry[i]),
.sum(sum[i]),
.cout(carry[i+1])
);
end
endgenerate
assign cout = carry[N];
endmodule
Testbench (ripple_carry_adder_tb.v)
`timescale 1ns / 1ps
module ripple_carry_adder_tb;
parameter N = 8; // 8-bit adder
// Inputs
reg [N-1:0] a, b;
reg cin;
// Outputs
wire [N-1:0] sum;
wire cout;
// Instantiate the RCA module
ripple_carry_adder #(N) uut (
.a(a),
.b(b),
.cin(cin),
.sum(sum),
.cout(cout)
);
// Clock generation
reg clk;
always #5 clk = ~clk; // 10ns period (100MHz)
// Test sequence
initial begin
// Open VCD file for waveform analysis
$dumpfile("ripple_carry_adder_tb.vcd");
$dumpvars(0, ripple_carry_adder_tb);
// Initialize inputs
clk = 0;
a = 8'b00000000; b = 8'b00000000; cin = 0;
#10;
// Apply test vectors
a = 8'b00001111; b = 8'b00000001; cin = 0; // Test case 1: 15 + 1
#10;
a = 8'b10101010; b = 8'b01010101; cin = 0; // Test case 2: Alternating bits
#10;
a = 8'b11111111; b = 8'b00000001; cin = 0; // Test case 3: Overflow case
#10;
a = 8'b11110000; b = 8'b00001111; cin = 1; // Test case 4: Carry-in test
#10;
a = 8'b10000000; b = 8'b10000000; cin = 0; // Test case 5: Negative numbers (two's
complement)
#10;
// End simulation
$display("Testbench completed.");
$finish;
end
endmodule
ripple_carry_adder.sdc
# Define clock with 5ns period (200MHz)
create_clock -name clk -period 5 [get_ports clk]
# Define input delays (setup and hold)
set_input_delay -max 2.0 -clock clk [get_ports a]
set_input_delay -max 2.0 -clock clk [get_ports b]
set_input_delay -min 0.5 -clock clk [get_ports a]
set_input_delay -min 0.5 -clock clk [get_ports b]
# Define output delays
set_output_delay -max 2.0 -clock clk [get_ports sum]
set_output_delay -min 0.5 -clock clk [get_ports sum]
# Identify the critical path
report_timing -from [get_ports a] -to [get_ports cout]
Run STA to Identify Critical Path
read_verilog ripple_carry_adder.v
read_sdc ripple_carry_adder.sdc
report_timing
report_constraint -all_violators
Note Down:
STA Report Output (Before Optimization)
STA Report Output (After Optimization)
