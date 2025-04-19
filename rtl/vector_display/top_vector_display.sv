module top_vector_display #(parameter int OUT_WIDTH)(

    input logic clk,
    input logic rst,
    input logic enable,

    output logic [OUT_WIDTH-1:0] x_ch,
    output logic [OUT_WIDTH-1:0] y_ch



);


    timeunit 1ns;
    timeprecision 1ps;

    import vector_pkg::*;

    wire clk_div_val;

    clk_div #(
        .DIVIDER(10)
    ) x_clk_div (
        .clk_in(clk),
        .rst(rst),
        .clk_out(clk_div_val)
    );


    draw_frame #(
        .OUT_WIDTH(DAC_WIDTH),
        .FRAME_MIN(VECTOR_MIN),
        .FRAME_MAX(VECTOR_MAX) 
    ) u_draw_frame (
        .clk(clk_div_val),
        .enable(1),
        .rst(rst),
        .x_out(x_ch),
        .y_out(y_ch)

    );

endmodule
