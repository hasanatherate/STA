module ripple_carry_adder (
    input clk,
    input [3:0] a,
    input [3:0] b,
    input cin,
    output [3:0] sum,
    output reg cout
);
    reg [3:0] carry;

    always @(posedge clk) begin
        {carry[0], sum[0]} = a[0] + b[0] + cin;
        {carry[1], sum[1]} = a[1] + b[1] + carry[0];
        {carry[2], sum[2]} = a[2] + b[2] + carry[1];
        {cout,     sum[3]} = a[3] + b[3] + carry[2];
    end
endmodule
