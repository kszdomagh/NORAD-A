module num_to_hex #(
    parameter int NUMBER_BIT = 10 // up to 1023 decimal
)(
    input logic [NUMBER_BIT-1:0] number,
    output logic [3:0] bcd_thousands,
    output logic [3:0] bcd_hundreds,
    output logic [3:0] bcd_tens,
    output logic [3:0] bcd_ones
);

    logic [NUMBER_BIT-1:0] bin_reg;
    logic [15:0] bcd_reg; // 16-bit BCD register [thousands, hundreds, tens, ones]
    int i;

    always_comb begin
        // Initialize
        bin_reg = number;
        bcd_reg = 16'b0;

        // Double dabble algorithm - CORRECT implementation
        for (i = 0; i < NUMBER_BIT; i++) begin
            // First shift left
            {bcd_reg, bin_reg} = {bcd_reg, bin_reg} << 1;

            // Then check each BCD digit and add 3 if >= 8
            // This must be done AFTER the shift
            if (bcd_reg[3:0] > 4)
                bcd_reg[3:0] = bcd_reg[3:0] + 3;
            if (bcd_reg[7:4] > 4)
                bcd_reg[7:4] = bcd_reg[7:4] + 3;
            if (bcd_reg[11:8] > 4)
                bcd_reg[11:8] = bcd_reg[11:8] + 3;
        end

        // Assign outputs
        bcd_thousands = bcd_reg[15:12];
        bcd_hundreds = bcd_reg[11:8];
        bcd_tens = bcd_reg[7:4];
        bcd_ones = bcd_reg[3:0];
    end

endmodule