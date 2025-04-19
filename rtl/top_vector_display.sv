module top_vector_display #(parameter int CH_WIDTH)(

    input logic clk,
    input logic rst,
    input logic enable,

    output logic [CH_WIDTH-1:0] x_ch,
    output logic [CH_WIDTH-1:0] y_ch



);


    timeunit 1ns;
    timeprecision 1ps;

    wire clk_div_val;

    clk_div #(
        .DIVIDER(1000)
    ) x_clk_div (
        .clk_in(clk),
        .rst(rst),
        .clk_out(clk_div_val)
    );



    counter #(
        .MAXCOUNT(256),
        .COUNT_WIDTH(8)
    ) x_counter (

        //    CONTROL SIGNALS
        .clk(clk_div_val),
        .rst(rst),
        .enable(1),
        .countdown(0),

        //    LOAD
        .load(0),
        .load_number(100),

        //    OUTPUTS
        .count_out(x_ch)
    );


    counter #(
        .MAXCOUNT(256),
        .COUNT_WIDTH(8)
    ) y_counter (

        //    CONTROL SIGNALS
        .clk(clk_div_val),
        .rst(rst),
        .enable(1),
        .countdown(0),

        //    LOAD
        .load(0),
        .load_number(100),

        //    OUTPUTS
        .count_out(y_ch)
    );




    



    


    




endmodule
