//////////////////////////////////////////////////////////////////////////////
/*
 Module name:   cdc_module
 Author:        kszdom
 Description:  module used for clock domain crossing
 */
//////////////////////////////////////////////////////////////////////////////

module cdc_module #(
    parameter int SIGNALWIDTH = 1
    )(

    // control signals
    input logic clkin,
    input logic clkout,

    input logic [SIGNALWIDTH-1:0] data_in,
    output logic [SIGNALWIDTH-1:0] data_out
);


    logic [SIGNALWIDTH-1:0] data_through1;
    logic [SIGNALWIDTH-1:0] data_through2;



    always@(posedge clkin) begin
        data_through1 <= data_in;
    end

    always@(posedge clkout) begin
        data_through2 <= data_through1;
    end

    always@(posedge clkout) begin
        data_out <= data_through2;
    end


endmodule

