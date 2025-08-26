`timescale 1ns/1ps

module missile_top_tb;

    // Parameters
    localparam OUT_WIDTH = 8;
    import vector_pkg::*;
    import img_pkg::*;

    // Clock and reset
    logic clk_fast;
    logic rst;

    // Inputs
    logic [OUT_WIDTH-1:0] xcursor, ycursor;
    logic fired;

    logic [OUT_WIDTH-1:0] xenemy1, yenemy1;
    logic spawn_enemy1;

    logic [OUT_WIDTH-1:0] xenemy2, yenemy2;
    logic spawn_enemy2;

    logic [OUT_WIDTH-1:0] xenemy3, yenemy3;
    logic spawn_enemy3;

    // Outputs
    logic hit1, hit2, hit3;
    wire [OUT_WIDTH-1:0] x_missile, y_missile;

    // Instantiate DUT
    missile_top #(
        .OUT_WIDTH(OUT_WIDTH),
        .CEASE_CYCLES(10)
    ) dut (
        .clk_fast(clk_fast),
        .rst(rst),
        .xcursor(xcursor),
        .ycursor(ycursor),
        .fired(fired),
        .xenemy1(xenemy1),
        .yenemy1(yenemy1),
        .spawn_enemy1(spawn_enemy1),
        .xenemy2(xenemy2),
        .yenemy2(yenemy2),
        .spawn_enemy2(spawn_enemy2),
        .xenemy3(xenemy3),
        .yenemy3(yenemy3),
        .spawn_enemy3(spawn_enemy3),
        .hit1(hit1),
        .hit2(hit2),
        .hit3(hit3),
        .x_missile(x_missile),
        .y_missile(y_missile)
    );

    // Clock generation
    initial clk_fast = 0;
    always #5 clk_fast = ~clk_fast; // 100 MHz

    // Stimulus
    initial begin
        // Initialize inputs
        rst = 1;
        xcursor = 0; ycursor = 0;
        fired = 0;
        xenemy1 = 50; yenemy1 = 100; spawn_enemy1 = 1;
        xenemy2 = 100; yenemy2 = 100; spawn_enemy2 = 1;
        xenemy3 = 150; yenemy3 = 150; spawn_enemy3 = 1;

        // Release reset after a few cycles
        #20;
        rst = 0;


        // Move cursor and fire
        #10;
        xcursor = 55; ycursor = 105;
        fired = 1;
        #10;
        fired = 0;



        #100000

        // Move cursor and fire
        #10;
        xcursor = 120; ycursor = 80;
        fired = 1;
        #150;
        xcursor = 24; ycursor = 10;
        fired = 0;


        // Wait for missile to fly
        #2000000;

        $finish;
    end

    // Optional: monitor outputs
    initial begin
        $monitor("Time=%0t x_missile=%0d y_missile=%0d hit1=%b hit2=%b hit3=%b",
                  $time, x_missile, y_missile, hit1, hit2, hit3);
    end

endmodule
