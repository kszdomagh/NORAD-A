
module top_vector_display_tb;

    timeunit 1ns;
    timeprecision 1ps;

    /**
     *  Local parameters
     */

    localparam CLK_PERIOD = 100; //10MHz


    /**
     * Local variables and signals
     */

    logic clk, rst, enable;

    logic [7:0] y_ch;
    logic [7:0] x_ch;


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

    top_vector_display #(
        
        .OUT_WIDTH(8),
        .CLK_DIV_VALUE(1)

    ) dut (

        .clk(clk),
        .rst(rst),
        .enable(enable),

        .x_ch(x_ch),
        .y_ch(y_ch)

    );



    /**
     * Main test
     */

    initial begin
        rst = 1'b0;
        enable = 1'b0;

        # 30 rst = 1'b1;
        # 30 rst = 1'b0;

        #30 enable = 1'b1;

        $display("If simulation ends before the testbench");
        $display("completes, use the menu option to run all.");
        $display("Prepare to wait a long time...");

        #200

        if( (x_ch == 'x) || (y_ch == 'x) ) begin
            $display("x_ch or y_ch - high impendace for some time. Check waveforms.");
            $finish;
        end

        // End the simulation.
        // $display("Simulation is over, check the waveforms.");
        // $finish;
    end

endmodule
