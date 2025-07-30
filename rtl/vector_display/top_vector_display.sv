module top_vector_display #(
    
    parameter int OUT_WIDTH = 8,
    parameter int CLK_DIV_VALUE = 1,
    parameter int ADDRESSWIDTH = 8,
    parameter int DATAWIDTH = 18
    
    )(

    //control signals
    input logic clk,
    input logic rst,
    input logic enable,

    //data signals
    output logic [ADDRESSWIDTH-1:0] addr,
    input logic [DATAWIDTH-1:0] data_in,

    output logic [OUT_WIDTH-1:0] x_ch,
    output logic [OUT_WIDTH-1:0] y_ch

);


    timeunit 1ns;
    timeprecision 1ps;

    import vector_pkg::*;

    wire clk_div_val;
    logic inc;

    clk_div #(
        .DIVIDER(CLK_DIV_VALUE)
    ) x_clk_div (
        .clk_in(clk),
        .rst(rst),
        .clk_out(clk_div_val)
    );






    logic go;
    logic [DAC_WIDTH-1:0] stax;
    logic [DAC_WIDTH-1:0] stay;
    logic [DAC_WIDTH-1:0] endx;
    logic [DAC_WIDTH-1:0] endy;

    vector_manage #(
        .ADR_WIDTH(ADDRESSWIDTH),
        .FRAME_MAX(VECTOR_MAX),
        .FRAME_MIN(VECTOR_MIN),
        .OUT_WIDTH(OUT_WIDTH)

    ) u_vector_manage (
        .clk(clk),
        .rst(rst),

        .x(data_in [9:2]),
        .y(data_in [17:10]),
        .line(data_in [1]),
        .pos(data_in [0]),

        .busy(draw_busy),

        .go(go),
        .stax(stax),
        .endx(endx),
        .stay(stay),
        .endy(endy),

        .adr(addr)
    );





    linedraw u_linedraw (

        .clk(clk),
        .go(go),
        .busy(draw_busy),

        .stax(stax),
        .stay(stay),

        .endx(endx),
        .endy(endy),

        .xout(x_ch),
        .yout(y_ch)

    );

endmodule
