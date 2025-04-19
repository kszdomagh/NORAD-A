module xdac (

    input logic [7:0] dac_in,
    output logic [7:0] dac_out

);
    timeunit 1ns;
    timeprecision 1ps;

    always_comb begin
        dac_out[0]  = dac_in[0];
        dac_out[1]  = dac_in[1];
        dac_out[2]  = dac_in[2];
        dac_out[3]  = dac_in[3];
        dac_out[4] = dac_in[4];
        dac_out[5]  = dac_in[5];
        dac_out[6]  = dac_in[6];
        dac_out[7]  = dac_in[7];
    end

endmodule
