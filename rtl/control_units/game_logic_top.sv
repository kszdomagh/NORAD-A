//////////////////////////////////////////////////////////////////////////////
/*
 Module name:   game_logic_top
 Author:        kszdom
 Description:  
 */
//////////////////////////////////////////////////////////////////////////////
module game_logic_top#(
    parameter int ADDRESSWIDTH = 16, 
    parameter int DATAWIDTH = 18,
    parameter int OUT_WIDTH = 8,


    parameter int TIME_SPEED_ENEMY1 = 100_000_000,
    parameter int TIME_SPEED_ENEMY2 = 80_000_000,
    parameter int TIME_SPEED_ENEMY3 = 140_000_000,

    parameter int TIME_SPAWN_ENEMY1 = 10_000_000,
    parameter int TIME_SPAWN_ENEMY2 = 12_000_000,
    parameter int TIME_SPAWN_ENEMY3 = 4_000_000
    )(

        input logic clk100MHz,
        input logic clk40MHz,
        input logic clk4MHz,
        input logic rst,


        //  ENTITIES 
        output wire [OUT_WIDTH-1:0] yenemy1,
        output wire [OUT_WIDTH-1:0] xenemy1,
        output wire spawn_enemy1,


        output wire [OUT_WIDTH-1:0] yenemy2,
        output wire [OUT_WIDTH-1:0] xenemy2,
        output wire spawn_enemy2,


        output wire [OUT_WIDTH-1:0] yenemy3,
        output wire [OUT_WIDTH-1:0] xenemy3,
        output wire spawn_enemy3
        
    );
    timeunit 1ns;
    timeprecision 1ps;

    import vector_pkg::*;
    import ROM_pkg::*;
    //import uwu_pkg::*;


    // INTERNAL WIRES
    wire enemy1_speed_pulse;
    wire spawn_pulse1;

    wire enemy2_speed_pulse;
    wire spawn_pulse2;

    wire enemy3_speed_pulse;
    wire spawn_pulse3;

    //MODULE DECLARATIONS

    timer_cluster #(
        .TIME1(TIME_SPEED_ENEMY1),
        .TIME2(TIME_SPEED_ENEMY2),
        .TIME3(TIME_SPEED_ENEMY3),

        .TIME_SLOW1(TIME_SPAWN_ENEMY1),
        .TIME_SLOW2(TIME_SPAWN_ENEMY2),
        .TIME_SLOW3(TIME_SPAWN_ENEMY3)
    ) u_timer_cluster (
        .clk100MHz(clk100MHz),
        .clk4MHz(clk4MHz),
        .rst(rst),

        .speed1_pulse(enemy1_speed_pulse),
        .speed2_pulse(enemy2_speed_pulse),
        .speed3_pulse(enemy3_speed_pulse),


        .slow1_pulse(spawn_pulse1),
        .slow2_pulse(spawn_pulse2),
        .slow3_pulse(spawn_pulse3)
    );


    enemy_control #(
        .OUT_WIDTH(OUT_WIDTH),
        .TARGET_BASE(1)
    ) u_enemy1_control (
        .clk(clk100MHz),
        .rst(rst),
        .en(1),
        .spawn_pulse(spawn_pulse1),
        .speed_pulse(enemy1_speed_pulse),

        .xenemy(xenemy1),
        .yenemy(yenemy1),
        .spawn(spawn_enemy1)
    );


    enemy_control #(
        .OUT_WIDTH(OUT_WIDTH),
        .TARGET_BASE(2)
    ) u_enemy2_control (
        .clk(clk100MHz),
        .rst(rst),
        .en(rst),
        .spawn_pulse(spawn_pulse2),
        .speed_pulse(enemy2_speed_pulse),

        .xenemy(xenemy2),
        .yenemy(yenemy2),
        .spawn(spawn_enemy2)
    );


    enemy_control #(
        .OUT_WIDTH(OUT_WIDTH),
        .TARGET_BASE(3)
    ) u_enemy3_control (
        .clk(clk100MHz),
        .rst(rst),
        .en(1),
        .spawn_pulse(spawn_pulse3),
        .speed_pulse(enemy3_speed_pulse),

        .xenemy(xenemy3),
        .yenemy(yenemy3),
        .spawn(spawn_enemy3)
    );

endmodule