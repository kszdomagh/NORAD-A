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
 * Testbench for top_fpga.
 * Thanks to the tiff_writer module, an expected image
 * produced by the project is exported to a tif file.
 * Since the vs signal is connected to the go input of
 * the tiff_writer, the first (top-left) pixel of the tif
 * will not correspond to the vga project (0,0) pixel.
 * The active image (not blanked space) in the tif file
 * will be shifted down by the number of lines equal to
 * the difference between VER_SYNC_START and VER_TOTAL_TIME.
 */

module top_fpga_tb;

    timeunit 1ns;
    timeprecision 1ps;

    /**
     *  Local parameters
     */

    localparam CLK_PERIOD = 10;     // 100 MHz


    /**
     * Local variables and signals
     */

    logic clk, rst;
    logic [7:0] portB, portA, JB, JC;

    assign portB = {JB[7], JB[6], JB[5], JB[4], JB[3], JB[2], JB[1], JB[0]};
    assign portA = {JC[7], JC[6], JC[5], JC[4], JC[3], JC[2], JC[1], JC[0]};

    /**
     * Clock generation
     */

    initial begin
        clk = 1'b0;
        forever #(CLK_PERIOD/2) clk = ~clk;
    end


    /**
     * Submodules instances
     */

    top_basys3 dut (
        .clk_in(clk),
        .btnC(rst),


        .JB(JB),
        .JC(JC)
    );



    /**
     * Main test
     */

    initial begin
        rst = 1'b0;
        # 1000 rst = 1'b1;
        # 2000 rst = 1'b0;

        $display("If simulation ends before the testbench");
        $display("completes, use the menu option to run all.");
        $display("Prepare to wait a long time...");

        // End the simulation.
        #1000000;
        $display("Simulation timeout reached.");
        $finish;
    end

endmodule
