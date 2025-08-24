module num_to_hex #( 
    parameter int NUMBER_BIT = 10 
)(
    input  logic [NUMBER_BIT-1:0] number,
    output logic [3:0] bcd_thousands,
    output logic [3:0] bcd_hundreds,
    output logic [3:0] bcd_tens,
    output logic [3:0] bcd_ones
);

    logic [NUMBER_BIT+16-1:0] shift_reg; 
    int i;

    always_comb begin
        shift_reg = '0;
        shift_reg[NUMBER_BIT-1:0] = number;

        // algorytm double dabble
        for (i = 0; i < NUMBER_BIT; i++) begin
            if (shift_reg[NUMBER_BIT+3:NUMBER_BIT]   >= 5) shift_reg[NUMBER_BIT+3:NUMBER_BIT]   += 3; // ones
            if (shift_reg[NUMBER_BIT+7:NUMBER_BIT+4] >= 5) shift_reg[NUMBER_BIT+7:NUMBER_BIT+4] += 3; // tens
            if (shift_reg[NUMBER_BIT+11:NUMBER_BIT+8]>= 5) shift_reg[NUMBER_BIT+11:NUMBER_BIT+8]+= 3; // hundreds
            if (shift_reg[NUMBER_BIT+15:NUMBER_BIT+12]>= 5) shift_reg[NUMBER_BIT+15:NUMBER_BIT+12]+= 3; // thousands

            shift_reg = shift_reg << 1;
        end

        bcd_ones      = shift_reg[NUMBER_BIT+3:NUMBER_BIT];
        bcd_tens      = shift_reg[NUMBER_BIT+7:NUMBER_BIT+4];
        bcd_hundreds  = shift_reg[NUMBER_BIT+11:NUMBER_BIT+8];
        bcd_thousands = shift_reg[NUMBER_BIT+15:NUMBER_BIT+12];
    end

endmodule
