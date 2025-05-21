module delay_path_buffered (
    input wire clk,
    input wire rst_n,
    output reg q
);
    reg a, b, c, d;
    wire a_buf, b_buf, c_buf, d_buf;

    BUF_X1 buf1 (.A(a), .Y(a_buf));
    BUF_X1 buf2 (.A(b), .Y(b_buf));
    BUF_X1 buf3 (.A(c), .Y(c_buf));
    BUF_X1 buf4 (.A(d), .Y(d_buf));

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            {a, b, c, d, q} <= 5'b00000;
        else
            {a, b, c, d, q} <= {1'b1, a_buf, b_buf, c_buf, d_buf};
    end
endmodule
