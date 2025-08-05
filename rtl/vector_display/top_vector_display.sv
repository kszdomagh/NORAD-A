module top_vector_display #(
    
    parameter int OUT_WIDTH = 8,
    parameter int ADDRESSWIDTH = 8,
    parameter int DATAWIDTH = 18
    
    )(

    //control signals
    input logic clk,
    input logic rst,
    output logic frame_drawn,

    //data signals
    output logic [ADDRESSWIDTH-1:0] addr,
    input logic [DATAWIDTH-1:0] data_in,

    output logic [OUT_WIDTH-1:0] x_ch,
    output logic [OUT_WIDTH-1:0] y_ch

);
    timeunit 1ns;
    timeprecision 1ps;

    import vector_pkg::*;

    logic go;
    logic [OUT_WIDTH:0] stax;
    logic [OUT_WIDTH:0] stay;
    logic [OUT_WIDTH:0] endx;
    logic [OUT_WIDTH:0] endy;

    logic [OUT_WIDTH:0] xbres;
    logic [OUT_WIDTH:0] ybres;
    logic valid_drawing;

    logic done;

    vector_manage #(
        .ADR_WIDTH(ADDRESSWIDTH),
        .FRAME_MAX(VECTOR_MAX),
        .FRAME_MIN(VECTOR_MIN),
        .OUT_WIDTH(OUT_WIDTH),
        .BRES_WIDTH(OUT_WIDTH+1)

    ) u_vector_manage (
        .clk(clk),
        .rst(rst),

        .x(data_in [9:2]),
        .y(data_in [17:10]),
        .line(data_in [1]),
        .pos(data_in [0]),

        .busy(draw_busy),
        .done(done),

        .go(go),
        .stax(stax),
        .endx(endx),
        .stay(stay),
        .endy(endy),

        .adr(addr),
        .vector_reset(frame_drawn)
    );

    bresenham #(
        .BRES_WIDTH(OUT_WIDTH+1)
    ) u_bresenham (
        .clk(clk),
        .rst(rst),
        .go(go), 

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

        .valid(valid_drawing),

        .inx(xbres),
        .iny(ybres),
        .outx(x_ch),
        .outy(y_ch)
    );

endmodule
