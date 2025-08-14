//////////////////////////////////////////////////////////////////////////////
/*
 Module name:   top_rtl
 Author:        kszdom
 Description:  module with all non-hardware submodules used by the design
 */
//////////////////////////////////////////////////////////////////////////////
module top_rtl#(
    parameter int ADDRESSWIDTH = 16, 
    parameter int DATAWIDTH = 18,
    parameter int OUT_WIDTH = 8
    )(

        input logic clk100MHz,
        input logic clk40MHz,
        input logic clk4MHz,

        input logic rst,

        input logic [OUT_WIDTH-1:0] Xmouse,
        input logic [OUT_WIDTH-1:0] Ymouse,
        input logic Rmouse,
        input logic Lmouse,
        
        output wire [OUT_WIDTH-1:0] xch,
        output wire [OUT_WIDTH-1:0] ych
        
    );
    timeunit 1ns;
    timeprecision 1ps;

    import vector_pkg::*;


    // INTERNAL WIRES
    logic [ADDRESSWIDTH-1:0] ROM_addr;
    logic [ADDRESSWIDTH-1:0] RAM_addr;
    logic [ADDRESSWIDTH-1:0] RAM_write_adr;
    logic [DATAWIDTH-1:0] ROM_data;
    logic [DATAWIDTH-1:0] RAM_data;
    logic [DATAWIDTH-1:0] RAM_write_data;

    logic frame_done;
    logic enable_vector;


    //MODULE DECLARATIONS

    top_vector_display #(
        .OUT_WIDTH(DAC_WIDTH),
        .ADDRESSWIDTH(ADDRESSWIDTH),
        .DATAWIDTH(DATAWIDTH)
    ) u_vector_display (
        .clk(clk4MHz),
        .rst(rst),
        .enable(enable_vector),

        .data_in(RAM_data),
        .addr(RAM_addr),
        .frame_drawn(frame_done),

        .x_ch(xch),
        .y_ch(ych)
    );

    memory_manage #(
        .ADR_WIDTH(ADDRESSWIDTH),
        .DATAWIDTH(DATAWIDTH),
        .OUT_WIDTH(DAC_WIDTH)
    ) u_memory_manage (
        //  control signals
        .clk(clk100MHz),
        .rst(rst),
        //  image ROM
        .adrROM(ROM_addr),
        .dataROM(ROM_data),

        //  RAM 
        .adrWRITE(RAM_write_adr),
        .dataWRITE(RAM_write_data),

        
        .draw_frame(enable_vector),  // to jest rozkaz ze mozna zaczac rysowac klatkę - RAM jest zapełniony danymi
        .frame_done(frame_done),  // to sygnał że narysoano klatke na oscyloskopie - prosze zrobic kolejna i dac nowe dane do RAMU

        //  from mouse input signals
        .x_cursor(8'd175),
        .y_cursor(8'd70)
    );

    template_ram #(
        .ADDRESSWIDTH(ADDRESSWIDTH),
        .BITWIDTH(DATAWIDTH),
        .DEPTH(1000) //1000 punktow moge zapisac
    ) u_RAM_module (
        .clk(clk100MHz),

        //  READ ONLY
        .adr_r(RAM_addr),
        .data_out_r(RAM_data),

        //  READ N WRITE 
        .data_out_rw(), // not connected
        .adr_rw(RAM_write_adr),
        .din(RAM_write_data),
        .we(1)
    );


    uwu_rom #(
        .ADDRESSWIDTH(ADDRESSWIDTH),
        .DATAWIDTH(DATAWIDTH)
    ) u_uwu_rom (
        .addr(ROM_addr),
        .data_out(ROM_data)
    );

endmodule