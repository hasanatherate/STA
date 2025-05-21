module delay_path (
    input wire clk,
    input wire rst_n,
    output reg q
);
    reg a, b, c, d;


    always @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            {a, b, c, d, q} <= 5'b00000;
        else
            {a, b, c, d, q} <= {1'b1, a, b, c, d}; // long path
    end
endmodule
