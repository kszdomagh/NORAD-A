



module top_rtl(

        input logic clk,
        input logic rst,
        
        output wire [7:0] xch,
        output wire [7:0] ych
    );
    timeunit 1ns;
    timeprecision 1ps;

    import vector_pkg::*;

    top_vector_display #(
        .OUT_WIDTH(DAC_WIDTH)
    ) u_vector_display (
        .enable(1),
        .clk(clk),
        .rst(rst),
        
        .x_ch(xch),
        .y_ch(ych)
    );







endmodule