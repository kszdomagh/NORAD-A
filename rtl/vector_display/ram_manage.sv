

module ram_manage #(
    parameter int ADDRESSWIDTH = 10
)(
    input  logic inc,
    input  logic clk,
    output logic [ADDRESSWIDTH-1:0] count_adr
);

    logic inc_prev;
    logic inc_falling;

    always_ff @(posedge clk) begin
        inc_prev <= inc;
    end

    assign inc_falling = (inc_prev == 1) && (inc == 0);

    always_ff @(posedge clk) begin
        if (inc_falling)
            count_adr <= count_adr + 1;
    end

endmodule
