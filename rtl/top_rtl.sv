//////////////////////////////////////////////////////////////////////////////
/*
 Module name:   top_rtl
 Author:        kszdom
 Description:  module with all non-hardware submodules used by the design
 */
//////////////////////////////////////////////////////////////////////////////
module top_rtl#(
    parameter int ADDRESSWIDTH = 8,
    parameter int DATAWIDTH = 18,
    parameter int OUT_WIDTH = 8
    )(

        input logic clk100MHz,
        input logic clk40MHz,
        input logic clk4MHz,

        input logic rst,
        input logic enable_vector,

        input logic [OUT_WIDTH-1:0] Xmouse,
        input logic [OUT_WIDTH-1:0] Ymouse,
        input logic Rmouse,
        input logic Lmouse,
        
        output wire frame_drawn,
        
        output wire [OUT_WIDTH-1:0] xch,
        output wire [OUT_WIDTH-1:0] ych
        
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
        .enable(enable_vector),

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