module fire_control_tb;

    localparam int OUT_WIDTH    = 8;
    localparam int XY_PRECISION = 5;


    logic clk;
    logic rst;
    logic [OUT_WIDTH-1:0] xcursor, ycursor;
    logic rocketfire;
    logic [OUT_WIDTH-1:0] xenemy1, yenemy1;
    logic [OUT_WIDTH-1:0] xenemy2, yenemy2;
    logic [OUT_WIDTH-1:0] xenemy3, yenemy3;
    logic enemy1_kill, enemy2_kill, enemy3_kill;


    fire_control #(
        .OUT_WIDTH(OUT_WIDTH),
        .XY_PRECISION(XY_PRECISION)
    ) u_dut (
        .clk(clk),
        .rst(rst),
        .xcursor(xcursor),
        .ycursor(ycursor),
        .rocketfire(rocketfire),
        .xenemy1(xenemy1), .yenemy1(yenemy1),
        .xenemy2(xenemy2), .yenemy2(yenemy2),
        .xenemy3(xenemy3), .yenemy3(yenemy3),
        .enemy1_kill(enemy1_kill),
        .enemy2_kill(enemy2_kill),
        .enemy3_kill(enemy3_kill)
    );

    //  clk gen
    always #5 clk = ~clk;


    initial begin
        // init
        $display("starting simulation.");
        clk = 0;
        rst = 1;
        rocketfire = 0;
        xcursor = 0; ycursor = 0;
        xenemy1 = 10; yenemy1 = 10;
        xenemy2 = 30; yenemy2 = 30;
        xenemy3 = 50; yenemy3 = 50;

        $display("reset sent");
        // reset
        #20;
        rst = 0;

        $display("start of test");
        // cursor far away -> no kills
        rocketfire = 1;
        xcursor = 100; ycursor = 100;
        #20;

        // cursor near enemy1 but no rocketfire signal -> should not trigger enemy1_kill
        xcursor = 12; ycursor = 9;  
        #20;

        // Cursor near enemy2 -> should trigger enemy2_kill
        rocketfire = 0;
        #20
        xcursor = 32; ycursor = 29;  
        #20;

        // Cursor near enemy3 -> notshould trigger enemy3_kill
        rocketfire = 1;
        xcursor = 51; ycursor = 54;  
        #20;

        xcursor = 80; ycursor = 80;  
        #20;


        $display("check waveforms :3");
        $display("end of testbench");
        $finish;
    end

endmodule
