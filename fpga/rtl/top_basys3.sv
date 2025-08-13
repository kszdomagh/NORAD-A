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

        output wire JA1,

        inout logic ps2data,
        input logic ps2clk,

        // x channel 8bit
        output wire [7:0] JB,
        // y channel 8bit
        output wire [7:0] JC,

        output wire LD0,
        input logic SW15,
        output wire LD15

    );

    timeunit 1ns;
    timeprecision 1ps;


    import vector_pkg::*;

    logic clk4MHz;
    logic clk100MHz;
    logic clk40MHz;

    //  mouse signals
    logic [7:0] Xmouse;
    logic [7:0] Ymouse;
    logic Lmouse;
    logic Rmouse;



    //  debug signals
    assign JA1=clk4MHz; // debug clk
    assign LD15=SW15;

    // mouse control input
    MouseCtl u_mouse_controller (
        .clk(clk100MHz),
        .rst(btnC),
        
        .ps2_clk(ps2clk),
        .ps2_data(ps2data),

        .xpos(Xmouse),
        .ypos(Ymouse),
        .right(Rmouse),
        .left(Lmouse),

        .setmax_x(VECTOR_MAX),
        .setmax_y(VECTOR_MAX)
    );


    //  clk manager
    clk_wiz_0 u_clk_manager (
        .clk_in(clk_in),

        .clk100MHz(clk100MHz),
        .clk40MHz(clk40MHz),
        .clk4MHz(clk4MHz),

        .reset(btnC)

    );


    //  top rtl
    top_rtl u_top_rtl(
        .clk100MHz(clk100MHz),
        .clk40MHz(clk40MHz),
        .clk4MHz(clk4MHz),
        .rst(btnC),
        
        //MOUSE INPUTS
        .Xmouse(Xmouse),
        .Ymouse(Ymouse),
        .Lmouse(Lmouse),
        .Rmouse(Rmouse),

        .enable_vector(LD15),

        .xch( {JB[4], JB[5], JB[6], JB[7], JB[0], JB[1], JB[2], JB[3]} ),

        //      y_ch is flipped lsb x_ch = msb dac_x
        .ych( {JC[0], JC[1], JC[2], JC[3], JC[4], JC[5], JC[6], JC[7]} ),
        
        .frame_drawn(LD0) //    debug
    );




endmodule
