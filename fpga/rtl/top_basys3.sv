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
        input  wire clk,
        input  wire btnC,

        output wire JA1,

        // x channel 8bit
        output wire [7:0] JB,
        // y channel 8bit
        output wire [7:0] JC

    );

    timeunit 1ns;
    timeprecision 1ps;



    /**
     *  Project functional top module
     */

    import vector_pkg::*;

    logic clk5MHz;
    logic clk100MHz;
    logic clk40MHz;

    clk_wiz_0 u_clk_manager (
        .clk_in1(clk),

        .clk100MHz(clk100MHz),
        .clk40MHz(clk40MHz),
        .clk5MHz(clk5MHz)

    );

    top_rtl u_top_rtl(
        .clk100MHz(clk100MHz),
        .clk40MHz(clk40MHz),
        .clk5MHz(clk5MHz),
        .rst(btnC),


        .xch( {JB[4], JB[5], JB[6], JB[7], JB[0], JB[1], JB[2], JB[3]} ),

        //      y_ch is flipped lsb x_ch = msb dac_x
        .ych( {JC[0], JC[1], JC[2], JC[3], JC[4], JC[5], JC[6], JC[7]} )
    );




endmodule
