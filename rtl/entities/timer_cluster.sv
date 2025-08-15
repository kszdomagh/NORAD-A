//////////////////////////////////////////////////////////////////////////////
/*
 Module name:   timer_cluster
 Author:        kszdom
 Description:  timer cluster

 TIME=100_000_00 IS EQUAL TO PULSE BEING SENT EVERY SECOND DUE TO CLK BEEING 100MHz

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
    parameter int TIME4 = 100_000_000,
    parameter int TIME5 = 100_000_000,
    parameter int TIME6 = 100_000_000,

    parameter int TIME_SLOW = 100_000_000
)(
    input  logic clk100MHz,
    input  logic clk4MHz,
    input  logic rst,

    output logic speed1_pulse,
    output logic speed2_pulse,
    output logic speed3_pulse,
    output logic speed4_pulse,
    output logic speed5_pulse,
    output logic speed6_pulse,

    output logic slow1_pulse

);

    timer #(.TIMER_TIME(TIME1)) u_timer1 (
        .clk100MHz(clk100MHz),
        .rst(rst),
        .pulse(speed1_pulse)
    );

    timer #(.TIMER_TIME(TIME2)) u_timer2 (
        .clk100MHz(clk100MHz),
        .rst(rst),
        .pulse(speed2_pulse)
    );

    timer #(.TIMER_TIME(TIME3)) u_timer3 (
        .clk100MHz(clk100MHz),
        .rst(rst),
        .pulse(speed3_pulse)
    );

    timer #(.TIMER_TIME(TIME4)) u_timer4 (
        .clk100MHz(clk100MHz),
        .rst(rst),
        .pulse(speed4_pulse)
    );

    timer #(.TIMER_TIME(TIME5)) u_timer5 (
        .clk100MHz(clk100MHz),
        .rst(rst),
        .pulse(speed5_pulse)
    );

    timer #(.TIMER_TIME(TIME6)) u_timer6 (
        .clk100MHz(clk100MHz),
        .rst(rst),
        .pulse(speed6_pulse)
    );

    timer #(.TIMER_TIME(TIME_SLOW)) u_timerSLOW (
        .clk100MHz(clk4MHz),
        .rst(rst),
        .pulse(slow1_pulse)
    );

endmodule
