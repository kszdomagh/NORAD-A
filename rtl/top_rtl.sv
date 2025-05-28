



module top_rtl#(
    parameter int ADDRESSWIDTH = 8,
    parameter int DATAWIDTH = 18
    )(

        input logic clk,
        input logic rst,
        
        output wire [7:0] xch,
        output wire [7:0] ych
    );
    timeunit 1ns;
    timeprecision 1ps;

    import vector_pkg::*;

    

    // INTERNAL WIRES
    logic [ADDRESSWIDTH-1:0] uwu_addr;
    logic [DATAWIDTH-1:0] uwu_data;




    //MODULE DECLARATIONS

    top_vector_display #(
        .OUT_WIDTH(DAC_WIDTH)
    ) u_vector_display (
        .enable(1),
        .clk(clk),
        .rst(rst),

        .data_in(uwu_data),
        .addr(uwu_addr),
        
        .x_ch(xch),
        .y_ch(ych)
    );


    uwu_rom #(
        .ADDRESSWIDTH(4),
        .DATAWIDTH(18)
    ) u_uwu_rom (

        .addr(uwu_addr),
        .data_out(uwu_data)

    );













endmodule