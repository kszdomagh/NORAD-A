
module draw_line_tb;

    timeunit 1ns;
    timeprecision 1ps;

    /**
     *  Local parameters
     */

    localparam CLK_PERIOD = 100; //10MHz


    /**
     * Local variables and signals
     */

    //  control signals
    logic clk, rst, enable;


    //data signals
    logic [7:0] x_start;
    logic [7:0] y_start;

    logic [7:0] x_end;
    logic [7:0] y_end;

    logic pos, draw;

    //outputs

    logic [7:0] x_out;
    logic [7:0] y_out;


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

    draw_line #(
        
        .OUT_WIDTH(8),
        .FRAME_MAX(255),
        .FRAME_MIN(0)

    ) dut (

        .clk(clk),
        .rst(rst),
        .enabled(enabled),

        .x_end(x_end),
        .y_end(y_end),
        
        .x_start(x_start),
        .y_start(y_start),

        .pos(draw),
        .draw(draw),


        .draw_done(done_signal),


        .y_line(y_out),
        .x_line(x_out)

    );



    /**
     * Main test
     */

    initial begin
        rst = 1'b0;
        enable = 1'b0;

        #30 rst = 1'b1;
        #30 rst = 1'b0;

        #30 enable = 1'b1;

        $display("Prepare to wait a long time...");

        #30;

        x_start = 8'd45;
        y_start = 8'd120;

        x_end = 8'd200;
        y_end = 8'd30;



        #10;

        draw = 1;

        $display("time: %0t x: %0d y: 0d", $time, x_out, y_out);

        if(done_signal) begin
            // End the simulation.
            $display("Simulation is over, check the waveforms.");
            $finish;
        end else begin
            $display("time: %0t x: %0d y: 0d", $time, x_out, y_out);
        end

    end

endmodule
