module top_vector_display #(
    
    parameter int OUT_WIDTH = 8,
    parameter int CLK_DIV_VALUE = 100,
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

    clk_div #(
        .DIVIDER(CLK_DIV_VALUE)
    ) x_clk_div (
        .clk_in(clk),
        .rst(rst),
        .clk_out(clk_div_val)
    );



    logic draw_busy;


    memory_manage #(
        .ADDRESSWIDTH(18)
    ) u_memory_manage (
        .count_adr(addr),
        .inc(draw_busy),
        .zero(zero),
        .clk(clk_div_val)
    );


    logic go;
    logic [DAC_WIDTH-1:0] stax;
    logic [DAC_WIDTH-1:0] stay;
    logic [DAC_WIDTH-1:0] endx;
    logic [DAC_WIDTH-1:0] endy;

    draw_vector_master #(
        .OUT_WIDTH(8),
        .FRAME_MIN(0),
        .FRAME_MAX(255)
    ) u_draw_vector_master (
    
        //  control signals
        .clk(clk),
        .rst(rst),
        .busy(draw_busy),
    
        // input signals
        .pos(data_in [0]),
        .line(data_in [1]),
        .i_x(data_in [9:2]),
        .i_y(data_in [17:10]),
    
        //  output signals
        .go(go),
        .o_start_x(stax),
        .o_start_y(stay),
        .o_end_x(endx),
        .o_end_y(endy)
    );


    linedraw u_linedraw (

        .clk(clk_div_val),
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
