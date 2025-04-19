module clk_div
    #(
        parameter integer DIVIDER = 2
    )
    (
        input  wire clk_in,
        input  wire rst,
        output logic clk_out
    );

    localparam integer HALF_DIV = DIVIDER / 2;

    logic [clog2(DIVIDER)-1:0] count;

    always_ff @(posedge clk_in or posedge rst) begin
        if (rst) begin
            count   <= '0;
            clk_out <= 1'b0;
        end
        else if (count == (HALF_DIV - 1)) begin
            count   <= '0;
            clk_out <= ~clk_out;
        end
        else begin
            count <= count + 1;
        end
    end

    function integer clog2(input integer value);
        clog2 = 0;
        while (value > 1) begin
            clog2 = clog2 + 1;
            value = value >> 1;
        end
    endfunction

endmodule