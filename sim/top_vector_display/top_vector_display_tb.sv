//////////////////////////////////////////////////////////////////////////////
/*
 Module name:   top_vector_display_tb
 Author:        kszdom
 Description:   testbench module for top_vector_display
 */
//////////////////////////////////////////////////////////////////////////////

module top_vector_display_tb;

    // Testbench signals
    logic clk;
    logic rst;

    import vector_pkg::*;

    //  INTERNAL SIGNALS
    logic [OUT_WIDTH-1:0] xsignal;
    logic [OUT_WIDTH-1:0] ysignal;


    logic [ADDRESSWIDTH-1:0] addr;
    logic [DATAWIDTH-1:0] rom_data;

    logic go, halt;


    uwu_rom #(
        .ADDRESSWIDTH(ADDRESSWIDTH),
        .DATAWIDTH(DATAWIDTH)
    ) ROM_data (
        .addr(addr),
        .data_out(rom_data)
    );


    //  DUT

    top_vector_display #(
        .ADDRESSWIDTH(ADDRESSWIDTH),
        .DATAWIDTH(DATAWIDTH),
        .OUT_WIDTH(OUT_WIDTH),
        .CEASE_CYCLES(1)        //no need to wait in simulation
    ) u_DUT (
        .clk(clk),
        .rst(rst),
        
        .data_in(rom_data),
        .addr(addr),

        .go_master(go),
        .halt(halt),

        .x_ch(xsignal),
        .y_ch(ysignal)


    );

    // Clock generation
    initial clk = 0;
    always #50 clk = ~clk; // 10MHz clock

    initial begin
        rst = 1;
        go = 0;
        #20 rst = 0;
        #100  go = 1;


        // timeout
        #100000000;
        $display("Simulation timeout reached.");
        $finish;
    end


    int reset_count = 0;
    logic go_reenable;

    always @(posedge clk) begin


        if (halt) begin
            go <= 0;
            go_reenable <= 1;       // flag to restart next cycle
            reset_count <= reset_count + 1;
        end
        
        if (go_reenable) begin
            go <= 1;
            go_reenable <= 0;
        end


        if(reset_count == 5) begin
            $display("Simulation ended at time: %t", $time);
            $display("PASSED :3");
            $finish;
        end
    end


endmodule
