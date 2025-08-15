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
    parameter int OUT_WIDTH = 8
    )(

        input logic clk100MHz,
        input logic clk40MHz,
        input logic clk4MHz,
        input logic rst,


        //  ENTITIES 
        output wire [OUT_WIDTH-1:0] yenemy1,
        output wire [OUT_WIDTH-1:0] xenemy1,
        output wire spawn_enemy1

        
    );
    timeunit 1ns;
    timeprecision 1ps;

    import vector_pkg::*;
    import ROM_pkg::*;
    //import uwu_pkg::*;


    // INTERNAL WIRES
    wire enemy1_speed_pulse;
    wire spawn_pulse;

    //MODULE DECLARATIONS

    timer_cluster #(
        .TIME1(100_000_000),
        .TIME_SLOW(5_000_000)
    ) u_timer_cluster (
        .clk100MHz(clk100MHz),
        .clk4MHz(clk4MHz),
        .rst(rst),

        .speed1_pulse(enemy1_speed_pulse),
        .slow1_pulse(spawn_pulse)
    );


    enemy_control #(
        .OUT_WIDTH(OUT_WIDTH),
        .TARGET_BASE(1)
    ) u_enemy1_control (
        .clk(clk100MHz),
        .rst(rst),
        .en(1),
        .spawn_pulse(spawn_pulse),
        .speed_pulse(enemy1_speed_pulse),

        .xenemy(xenemy1),
        .yenemy(yenemy1),
        .spawn(spawn_enemy1)
    );



endmodule