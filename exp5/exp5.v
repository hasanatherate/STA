module clock_skew_pipeline (
    input wire clk,
    input wire rst_n,
    input wire d_in,
    output reg d_out
);
    reg q1, q2;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            q1 <= 0;
            q2 <= 0;
            d_out <= 0;
        end else begin
            q1 <= d_in;
            q2 <= q1;
            d_out <= q2;
        end
    end
endmodule
