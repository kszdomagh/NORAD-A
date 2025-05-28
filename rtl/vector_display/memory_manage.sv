

module memory_manage #(
    parameter int ADDRESSWIDTH = 10
)(
    input  logic inc,
    input logic zero,
    input  logic clk,
    output logic [ADDRESSWIDTH-1:0] count_adr
);

    logic [ADDRESSWIDTH-1:0] count_adr_nxt;

    always_comb begin

        if(zero)begin
            count_adr_nxt = 0;
        end else if (inc) begin
            count_adr_nxt = count_adr +1;
        end else begin
            count_adr_nxt = count_adr;
        end
    end


    always_ff @(posedge clk) begin
        count_adr <= count_adr_nxt;
    end

endmodule
