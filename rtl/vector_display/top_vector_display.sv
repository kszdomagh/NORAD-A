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

    wire clk_div;
    logic inc;

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
        .clk(clk_div),
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

    bresenham u_bresenham (
        .clk(clk),
        .go(go), 
        .done(done),

        .stax(stax),
        .stay(stay),

        .endx(endx),
        .endy(endy),

        .x(x_ch),
        .y(y_ch)
    );

endmodule
