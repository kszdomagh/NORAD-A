module top_vector_display #(parameter int CH_WIDTH)(

    input logic clk,
    input logic rst,
    input logic enable,

    output logic [CH_WIDTH-1:0] x_ch,
    output logic [CH_WIDTH-1:0] y_ch



);


    timeunit 1ns;
    timeprecision 1ps;




    clk_div #(
        .DIVIDER(100)
    ) x_clk_div (
        .clk_in(clk),
        .rst(rst),
        .clk_out(counter_clk)
    );


    clk_div #(
        .DIVIDER(2000)
    ) y_clk_div (
        .clk_in(clk),
        .rst(rst),
        .clk_out(enable_clk)
    );

    clk_div #(
        .DIVIDER(104)
    ) cd_clk_div (
        .clk_in(clk),
        .rst(rst),
        .clk_out(countdown_clk)
    );



    counter #(
        .MAXCOUNT(256),
        .COUNT_WIDTH(8)
    ) x_counter (

        //    CONTROL SIGNALS
        .clk(counter_clk),
        .rst(rst),
        .enable(enable_clk),
        .countdown(0),
        .load(countdown_clk),

        //    INPUTS
        .load_number(100),

        //    OUTPUTS
        .count_out(x_ch)
    );


    counter #(
        .MAXCOUNT(256),
        .COUNT_WIDTH(8)
    ) y_counter (

        //    CONTROL SIGNALS
        .clk(counter_clk),
        .rst(rst),
        .enable(1),
        .countdown(1),

        //    INPUTS
        .load_number(200),

        //    OUTPUTS
        .count_out(y_ch)
    );




    



    


    




endmodule
