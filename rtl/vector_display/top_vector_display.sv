//////////////////////////////////////////////////////////////////////////////
/*
 Module name:   top_vector_display
 Author:        kszdom
 Description:  top module for all vector stuff
 */
//////////////////////////////////////////////////////////////////////////////
module top_vector_display #(
    
    parameter int OUT_WIDTH = 8,
    parameter int ADDRESSWIDTH = 8,
    parameter int DATAWIDTH = 18,
    parameter CEASE_CYCLES = 4
    
    )(

    //control signals
    input logic clk,
    input logic rst,

    output logic halt,
    input logic go_master,

    //data signals
    output logic [ADDRESSWIDTH-1:0] addr,
    input logic [DATAWIDTH-1:0] data_in,

    output logic [OUT_WIDTH-1:0] x_ch,
    output logic [OUT_WIDTH-1:0] y_ch

);
    timeunit 1ns;
    timeprecision 1ps;

    import vector_pkg::*;

    logic [OUT_WIDTH:0] stax;
    logic [OUT_WIDTH:0] stay;
    logic [OUT_WIDTH:0] endx;
    logic [OUT_WIDTH:0] endy;

    logic [OUT_WIDTH:0] xbres;
    logic [OUT_WIDTH:0] ybres;
    logic valid_drawing;

    logic done;
    logic go;

    vector_manage #(
        .ADR_WIDTH(ADDRESSWIDTH),
        .FRAME_MAX(VECTOR_MAX),
        .FRAME_MIN(VECTOR_MIN),
        .OUT_WIDTH(OUT_WIDTH),
        .BRES_WIDTH(OUT_WIDTH+1),
        .DATAWIDTH(DATAWIDTH)

    ) u_vector_manage (
        .clk(clk),
        .rst(rst),
        .enable(go_master),

        .data_in(data_in),

        .busy(draw_busy),
        .done(done),

        .go(go),
        .stax(stax),
        .endx(endx),
        .stay(stay),
        .endy(endy),

        .adr(addr),
        .vector_reset(halt)
    );

    bresenham #(
        .BRES_WIDTH(OUT_WIDTH+1),
        .CEASE_CYCLES(CEASE_CYCLES)
    ) u_bresenham (
        .clk(clk),
        .rst(rst),
        .go(go), 
        .enable(go_master),

        .done(done),
        .busy(draw_busy),

        .stax(stax),
        .stay(stay),

        .endx(endx),
        .endy(endy),

        .x(xbres),
        .y(ybres),
        .drawing(valid_drawing)
    );

    valid_buf #(
        .BRES_WIDTH(OUT_WIDTH+1),
        .OUTWIDTH(OUT_WIDTH)
    ) u_valid_buf (
        .clk(clk),
        .rst(rst),
        .enable(go_master),

        .valid(valid_drawing),

        .inx(xbres),
        .iny(ybres),
        .outx(x_ch),
        .outy(y_ch)
    );

endmodule
