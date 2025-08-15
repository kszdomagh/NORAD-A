/**
 * San Jose State University
 * EE178 Lab #4
 * Author: prof. Eric Crabilla
 *
 * Modified by:
 * 2025  AGH University of Science and Technology
 * MTM UEC2
 * Piotr Kaczmarczyk
 *
 * Description:
 * Top level synthesizable module including the project top and all the FPGA-referred modules.
 */

module top_basys3 (
        input  wire clk_in,
        input  wire btnC,

        inout wire PS2Clk,
        inout wire PS2Data,

        // x channel 8bit
        output wire [7:0] JB,
        // y channel 8bit
        output wire [7:0] JC,


        //  7SEG
        output wire [6:0] seg,
        output wire [3:0] an,

        output wire [11:0] led


    );

    timeunit 1ns;
    timeprecision 1ps;


    import vector_pkg::*;

    logic clk4MHz;
    logic clk100MHz;
    logic clk40MHz;

    //  mouse signals
    wire [7:0] Xmouse;
    wire [7:0] Ymouse;
    wire Lmouse;
    wire Rmouse;
    logic [7:0] X_debug;


    //  debug signals


    //  clk manager
    clk_wiz_0 u_clk_manager (
        .clk_in(clk_in),

        .clk100MHz(clk100MHz),
        .clk40MHz(clk40MHz),
        .clk4MHz(clk4MHz),

        .reset(btnC)

    );

    //      MOUSE CONTROL MODULE
    MouseCtl u_MouseCtl (
        .clk(clk100MHz),
        .rst(btnC),
        
        .ps2_clk(PS2Clk),
        .ps2_data(PS2Data),

        .xpos(Xmouse),
        .ypos(Ymouse),
        .right(Rmouse),
        .left(Lmouse),

        .setmax_x(8'd255),
        .setmax_y(8'd255),



        .setx(8'd128),
        .sety(8'd128),
        .value(1)
    );

    //  top rtl
    top_rtl u_top_rtl(
        .clk100MHz(clk100MHz),
        .clk40MHz(clk40MHz),
        .clk4MHz(clk4MHz),
        .rst(btnC),



        .go_flag(led[0]),
        .halt_flag(led[1]),


        .xch( {JB[4], JB[5], JB[6], JB[7], JB[0], JB[1], JB[2], JB[3]} ),
        //      y_ch is flipped lsb x_ch = msb dac_x
        .ych( {JC[0], JC[1], JC[2], JC[3], JC[4], JC[5], JC[6], JC[7]} )

    );





    logic [3:0] hex0;
    logic [3:0] hex1;
    logic [3:0] hex2;
    logic [3:0] hex3;

    num_to_hex #(
        .NUMBER_BIT(8)
    ) u_num_to_bcd(
        .number(X_debug),

        .bcd_thousands(hex3),
        .bcd_hundreds(hex2),
        .bcd_tens(hex1),
        .bcd_ones(hex0)

    );

    disp_hex_mux u_bcd_display (
        .clk(clk100MHz),
        .reset(btnC),
        .sseg(seg),
        .an(an),

        .hex0(hex0), // prawo
        .hex1(hex1),

        .hex2(hex2),
        .hex3(hex3)  // lewo
    );



endmodule
