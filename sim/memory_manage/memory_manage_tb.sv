module memory_manage_tb;

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

    logic [4:0] state_debug_bits;
    logic frame_reset;


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
        .draw_frame(frame_reset),
        .state_debug(state_debug_bits),

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


    typedef enum logic [4:0] { //5 bit state so 65 states possible
        //CONTROL SIGNALS
        DONE            = 5'd0,
        RESET           = 5'd1,
        WAIT_FRAME_DONE = 5'd2,
        DRAW_RESET      = 5'd3,

        //DRAW BACKGROUND
        DRAW_FRAME = 5'd10,
        DRAW_MAP   = 5'd11,

        //DRAW INTERACTABLES
        DRAW_CURSOR = 5'd12
    } state_t;

    state_t state_debug;
    assign state_debug = state_t'(state_debug_bits);


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

    always @(posedge clk) begin


        if (draw_frame) begin
            $display("Draw frame signal recieved at time: %t", $time);
            $display("PASSED :3");
            $finish;
        end

    
    end


endmodule
