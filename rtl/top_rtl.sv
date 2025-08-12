



module top_rtl#(
    parameter int ADDRESSWIDTH = 8,
    parameter int DATAWIDTH = 18
    )(

        input logic clk100MHz,
        input logic clk40MHz,
        input logic clk4MHz,

        input logic rst,
        output wire frame_drawn,
        
        output wire [7:0] xch,
        output wire [7:0] ych
        
    );
    timeunit 1ns;
    timeprecision 1ps;

    import vector_pkg::*;

    

    // INTERNAL WIRES
    logic [ADDRESSWIDTH-1:0] uwu_addr;
    logic [DATAWIDTH-1:0] uwu_data;

    logic frame_drawn;

    //MODULE DECLARATIONS

    top_vector_display #(
        .OUT_WIDTH(DAC_WIDTH),
        .ADDRESSWIDTH(ADDRESSWIDTH),
        .DATAWIDTH(DATAWIDTH)
    ) u_vector_display (
        .clk(clk4MHz),
        .rst(rst),

        .data_in(uwu_data),
        .addr(uwu_addr),
        .frame_drawn(frame_drawn),

        .x_ch(xch),
        .y_ch(ych)
    );


    uwu_rom #(
        .ADDRESSWIDTH(ADDRESSWIDTH),
        .DATAWIDTH(DATAWIDTH)
    ) u_uwu_rom (
        .addr(uwu_addr),
        .data_out(uwu_data)
    );

endmodule