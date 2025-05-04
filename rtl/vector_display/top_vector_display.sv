module top_vector_display #(
    
    parameter int OUT_WIDTH = 8,
    parameter int CLK_DIV_VALUE = 100
    
    )(

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
        .DIVIDER(CLK_DIV_VALUE)
    ) x_clk_div (
        .clk_in(clk),
        .rst(rst),
        .clk_out(clk_div_val)
    );



    logic write_en_ram1;

    logic [15:0] rw_adress_ram1;
    logic [17:0] data_in_ram1;

    logic [15:0] r_adress_ram1;
    logic [17:0] r_data_out_ram1;


    /* 

    template_ram #(
        .ADDRESSWIDTH(16),
        .BITWIDTH(18),     // x + y + draw + pos = 8 + 8 + 1 + 1 = 18
        .DEPTH(32)
    ) vector_ram1 (
        .clk(clk),

        .we(write_en_ram1),     //  write enable
        .a(rw_adress_ram1),     //  read n write adress / in
        .din(data_in_ram1),     //  read n write data / in

        .dpra(r_adress_ram1),   //  read only adress / in
        .dpo(r_data_out_ram1)   //  read only data / out

        // ram data is      {x, y, draw, pos}


    );

    */

    uwu_rom #(
        .ADDRESSWIDTH(4)
    ) u_uwu_rom (


        .addr(r_adress_ram1),
        .data_out(r_data_out_ram1)

    );

    logic draw_busy;


    ram_manage #(
        .ADDRESSWIDTH(18)
    ) u_ram_manage (
        .count_adr(r_adress_ram1),
        .inc(draw_busy),
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
        .pos(r_data_out_ram1 [0]),
        .draw(r_data_out_ram1 [1]),
        .i_x(r_data_out_ram1 [9:2]),
        .i_y(r_data_out_ram1 [17:10]),
    
        //  output signals
        .go(go),
        .o_start_x(stax),
        .o_start_y(stay),
        .o_end_x(endx),
        .o_end_y(endy)
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
