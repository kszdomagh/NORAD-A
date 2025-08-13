module top_vector_display_tb;

    // Testbench signals
    logic clk;
    logic rst;

    import vector_pkg::*;
	import ROM_pkg::*;

    // INTERNAL WIRES
    logic [DATAWIDTH-1:0] dataROM;
    logic [ADDRESSWIDTH-1:0] adrROM;
    logic [DATAWIDTH-1:0] dataWRITE;
    logic [ADDRESSWIDTH-1:0] adrWRITE;
    logic draw_frame;


    // DUT
	memory_manage #(
        .ADR_WIDTH(ADDRESSWIDTH),
        .DATAWIDTH(DATAWIDTH),
        .FRAME_MAX(VECTOR_MAX),
        .FRAME_MIN(VECTOR_MIN),
        .OUT_WIDTH(DAC_WIDTH)
    ) u_DUT (
        .clk(clk),
        .rst(rst),
        .frame_done(1),
        .draw_frame(draw_frame),

        //  ROM signals
        .adrROM(adrROM),
        .dataROM(dataROM),

        //  RAM SIGNALS
        .adrWRITE(adrWRITE),
        .dataWRITE(dataWRITE),

        //  MOUSE POS SIGNALS
        .x_cursor(100),
        .y_cursor(120)
	);


    uwu_rom #(
        .ADDRESSWIDTH(ADDRESSWIDTH),
        .DATAWIDTH(DATAWIDTH)
    ) u_uwu_rom (
        .addr(adrROM),
        .data_out(dataROM)
    );


    // Clock generation
    initial clk = 0;
    always #5 clk = ~clk; // 100MHz clock

    // Stimulus block
    initial begin
        rst = 1;
        #20 rst = 0;

        // Optional: add timeout
        #1000000;
        $display("Simulation timeout reached.");
        $finish;
    end


    int reset_count;
    logic frame_reset;

    always @(posedge clk) begin


        if (draw_frame) begin
            $display("Draw frame signal recieved at time: %t", $time);
            $display("PASSED :3");
            $finish;
        end

    
    end


endmodule
