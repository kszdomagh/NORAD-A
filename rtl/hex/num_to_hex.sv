module num_to_hex #(
    parameter int NUMBER_BIT = 10
)(
    input  logic [NUMBER_BIT-1:0] number,
    output logic [3:0] bcd_thousands,
    output logic [3:0] bcd_hundreds,
    output logic [3:0] bcd_tens,
    output logic [3:0] bcd_ones
);
    integer i;
    localparam int SHIFT_REG_WIDTH = NUMBER_BIT + 4*4; // BCD digits + binary input
    logic [SHIFT_REG_WIDTH-1:0] shift_reg;

    always_comb begin
        shift_reg = { { (4*3){1'b0} }, number }; // 3 BCD digits + binary

        //  double dabble shift
        for (i = 0; i < NUMBER_BIT; i++) begin
            if (shift_reg[3:0]   >= 5) shift_reg[3:0]   += 3; // ones
            if (shift_reg[7:4]   >= 5) shift_reg[7:4]   += 3; // tens
            if (shift_reg[11:8]  >= 5) shift_reg[11:8]  += 3; // hundreds
            if (shift_reg[15:12] >= 5) shift_reg[15:12] += 3; // thousands

            shift_reg = shift_reg << 1;
        end

        bcd_ones      = shift_reg[3:0];
        bcd_tens      = shift_reg[7:4];
        bcd_hundreds  = shift_reg[11:8];
        bcd_thousands = shift_reg[15:12];
    end
endmodule

