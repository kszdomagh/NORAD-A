//////////////////////////////////////////////////////////////////////////////
/*
 Module name:   timer_cluster
 Author:        kszdom
 Description:  timer cluster

 TIME = 80_000_00 IS EQUAL TO PULSE BEING SENT EVERY SECOND DUE TO CLK FAST BEEING 80MHz
 CLK SLOW IS 5MHZ

 to add more timers please:
        - add a new parameter; choose a name for it,
        - add a new output; also choose a name for it,
        - copy and paste the timer module and modify its contents:
                1. clk speed if it needs to be changed to a slower/faster one;
                2. name of the instance
                3. change the parameter and pulse signal name to prev. selected ones
        - done :3 you have now created a new timer in the cluster module
 */
//////////////////////////////////////////////////////////////////////////////
module timer_cluster #(
    parameter int TIME1 = 100_000_000,
    parameter int TIME2 = 100_000_000,
    parameter int TIME3 = 100_000_000,

    parameter int TIME_SLOW1 = 4_600_000,
    parameter int TIME_SLOW2 = 4_600_000,
    parameter int TIME_SLOW3 = 4_600_000,

    parameter int TIME_ENEMY_RANDOM = 1_000_000,

    parameter ADR_START_1 = 1,
    parameter ADR_START_2 = 1,
    parameter ADR_START_3 = 1,
    parameter ADRESSWIDTH = 0
)(
    input  logic clk_fast,
    input  logic clk_slow,
    input  logic rst,

    input logic [30:0] dec,

    output logic speed1_pulse,
    output logic speed2_pulse,
    output logic speed3_pulse,

    output logic slow1_pulse,
    output logic slow2_pulse,
    output logic slow3_pulse,

    output logic adr_enemy_pulse,
    output logic [ADRESSWIDTH-1:0] adr_enemy_random

);


    timer #(.TIMER_TIME(TIME1)) u_timer1 (
        .clk(clk_fast),
        .rst(rst),
        .pulse(speed1_pulse),
        .dec(dec)
    );

    timer #(.TIMER_TIME(TIME2)) u_timer2 (
        .clk(clk_fast),
        .rst(rst),
        .pulse(speed2_pulse),
        .dec(dec)
    );

    timer #(.TIMER_TIME(TIME3)) u_timer3 (
        .clk(clk_fast),
        .rst(rst),
        .pulse(speed3_pulse),
        .dec(dec)
    );


    timer #(.TIMER_TIME(TIME_SLOW1)) u_timerSLOW1 (
        .clk(clk_slow),
        .rst(rst),
        .pulse(slow1_pulse),
        .dec(dec)
    );

    timer #(.TIMER_TIME(TIME_SLOW2)) u_timerSLOW2 (
        .clk(clk_slow),
        .rst(rst),
        .pulse(slow2_pulse),
        .dec(dec)
    );


    timer #(.TIMER_TIME(TIME_SLOW3)) u_timerSLOW3 (
        .clk(clk_slow),
        .rst(rst),
        .pulse(slow3_pulse),
        .dec(dec)
    );

    timer #(.TIMER_TIME(TIME_ENEMY_RANDOM)) u_timerRANDOM (
        .clk(clk_fast),
        .rst(rst),
        .pulse(adr_enemy_pulse),
        .dec(dec)
    );


    random_enemy_adr #(
        .ADR_START_1(ADR_START_1),
        .ADR_START_2(ADR_START_2),
        .ADR_START_3(ADR_START_3),
        .ADRESSWIDTH(ADRESSWIDTH)
    ) u_random_enemy_adr (
        .clk(clk_fast),
        .rst(rst),
        .flip(adr_enemy_pulse),

        .adr_enemy_random(adr_enemy_random)
    );

endmodule
