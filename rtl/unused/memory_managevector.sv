module memory_managevector #(
    parameter int ADDRESSWIDTH = 10
)(
    input  logic inc,
    input  logic zero,
    input  logic clk,
    input  logic rst,
    output logic [ADDRESSWIDTH-1:0] count_adr
);

    logic [ADDRESSWIDTH-1:0] count_adr_nxt;

    always_comb begin
        if (zero) begin
            count_adr_nxt = 0;
        end else if (inc) begin
            count_adr_nxt = count_adr + 1;
        end else begin
            count_adr_nxt = count_adr;
        end
    end

    always_ff @(posedge clk) begin
        if (rst) begin
            count_adr <= 0;
        end else begin
            count_adr <= count_adr_nxt;
        end
    end

endmodule
