



module top_rtl(

        input logic clk,
        input logic rst,
        
        output wire [7:0] xch,
        output wire [7:0] ych
    );
    timeunit 1ns;
    timeprecision 1ps;

    import vector_pkg::*;



    logic [3:0] uwu_adrr;
    logic [17:0] uwu_data;




    top_vector_display #(
        .OUT_WIDTH(DAC_WIDTH)
    ) u_top_vector_display (
        //control signals
        .enable(1),
        .clk(clk),
        .rst(rst),

        // data inputs/outputs
        .data_in(uwu_data),
        .count_adrr(uwu_adrr),
        
        // outputs to DAC
        .x_ch(xch),
        .y_ch(ych)
    );

    uwu_rom #(
        .ADDRESSWIDTH(4),
        .DATAWIDTH(18)
    ) u_uwu_rom (
        .addr(uwu_adrr),
        .data_out(uwu_data)

    );







endmodule