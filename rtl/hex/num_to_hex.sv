module num_to_hex #(
    parameter BIN_WIDTH = 14   // enough for numbers up to 9999 (2^14 = 16384)
)(
    input  logic [BIN_WIDTH-1:0] bin_in,
    output logic [3:0] bcd_thousands,
    output logic [3:0] bcd_hundreds,
    output logic [3:0] bcd_tens,
    output logic [3:0] bcd_ones
);
    integer i;
    logic [BIN_WIDTH-1:0] bin_temp;
    logic [3:0] thousands, hundreds, tens, ones;

    always_comb begin
        // reset
        thousands = 0;
        hundreds  = 0;
        tens      = 0;
        ones      = 0;
        bin_temp  = bin_in;

        // Double dabble algorithm
        for (i = BIN_WIDTH-1; i >= 0; i--) begin
            // add 3 if >= 5
            if (thousands >= 5) thousands += 3;
            if (hundreds  >= 5) hundreds  += 3;
            if (tens      >= 5) tens      += 3;
            if (ones      >= 5) ones      += 3;

            // shift left
            thousands = {thousands[2:0], hundreds[3]};
            hundreds  = {hundreds[2:0], tens[3]};
            tens      = {tens[2:0], ones[3]};
            ones      = {ones[2:0], bin_temp[i]};
        end

        // assign outputs
        bcd_thousands = thousands;
        bcd_hundreds  = hundreds;
        bcd_tens      = tens;
        bcd_ones      = ones;
    end
endmodule