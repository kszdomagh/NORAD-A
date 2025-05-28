module top_vector_display #(
    
    parameter int OUT_WIDTH = 8,
    parameter int CLK_DIV_VALUE = 100,
    parameter int ADDRESSWIDTH = 4,
    parameter int DATAWIDTH = 18
    
    )(

    input logic clk,
    input logic rst,
    input logic enable,
    input logic [DATAWIDTH-1:0]data_in,

    output logic [OUT_WIDTH-1:0] x_ch,
    output logic [OUT_WIDTH-1:0] y_ch,

    output logic [ADDRESSWIDTH-1:0] count_adrr

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


    logic go;
    logic [DAC_WIDTH-1:0] stax;
    logic [DAC_WIDTH-1:0] stay;
    logic [DAC_WIDTH-1:0] endx;
    logic [DAC_WIDTH-1:0] endy;

    memory_draw_vector_master #(
        .OUT_WIDTH(8),
        .FRAME_MIN(0),
        .FRAME_MAX(255),
        .ADDRESSWIDTH(18)
    ) u_memory_draw_vector_master (
    
        //  control signals
        .clk(clk),
        .rst_n(rst),
        .busy(draw_busy),
    
        // input signals
        .pos(data_in [0]),
        .draw(data_in [1]),
        .i_x(data_in [9:2]),
        .i_y(data_in [17:10]),
    
        //  output signals
        .go(go),
        .o_start_x(stax),
        .o_start_y(stay),
        .o_end_x(endx),
        .o_end_y(endy),

        //memory manage signals
        .inc(draw_busy),
        .count_adr(r_adress_ram1)
    );

    logic write;

    linedraw u_linedraw (

        .clk(clk_div_val),
        .go(go),
        .busy(draw_busy),

        .stax(stax),
        .stay(stay),

        .endx(endx),
        .endy(endy),

        .wr(write),

        .xout(x_ch),
        .yout(y_ch)

    );






endmodule
