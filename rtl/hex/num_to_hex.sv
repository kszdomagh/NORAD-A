module num_to_hex #( 
    parameter int NUMBER_BIT = 10 // up to 1023 decimal
)(
    input  logic [NUMBER_BIT-1:0] number,
    output logic [3:0] bcd_thousands,
    output logic [3:0] bcd_hundreds,
    output logic [3:0] bcd_tens,
    output logic [3:0] bcd_ones
);
    logic [NUMBER_BIT-1:0] bin_reg;
    logic [3:0] thousands, hundreds, tens, ones;
    int i;

    always_comb begin
        // reset all
        thousands = 0;
        hundreds  = 0;
        tens      = 0;
        ones      = 0;
        bin_reg   = number;

        // Double dabble algorithm
        for (i = NUMBER_BIT-1; i >= 0; i--) begin
            // Add 3 if >= 5 before shifting
            if (thousands >= 5) thousands += 3;
            if (hundreds  >= 5) hundreds  += 3;
            if (tens      >= 5) tens      += 3;
            if (ones      >= 5) ones      += 3;

            // Shift left by 1
            {thousands, hundreds, tens, ones, bin_reg} =
                {thousands, hundreds, tens, ones, bin_reg} << 1;
        end

        bcd_thousands = thousands;
        bcd_hundreds  = hundreds;
        bcd_tens      = tens;
        bcd_ones      = ones;
    end
endmodule

