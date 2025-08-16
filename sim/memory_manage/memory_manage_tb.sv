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
    logic go;
    logic halt;

    logic [4:0] state_debug_bits;


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
        .halt(halt),
        .go(go),
        .state_debug(state_debug_bits),

        //  ROM signals
        .adrROM(adrROM),
        .dataROM(dataROM),

        //  RAM SIGNALS
        .adrWRITE(adrWRITE),
        .dataWRITE(dataWRITE),

        //  MOUSE POS SIGNALS
        .xcursor(100),
        .ycursor(120),

        .spawn_enemy1(1),
        .xenemy1(200),
        .yenemy1(53)

	);


    uwu_rom #(
        .ADDRESSWIDTH(ADDRESSWIDTH),
        .DATAWIDTH(DATAWIDTH)
    ) u_uwu_rom (
        .addr(adrROM),
        .data_out(dataROM)
    );

    template_ram #(
        .ADDRESSWIDTH(ADDRESSWIDTH),
        .BITWIDTH(DATAWIDTH),
        .DEPTH(100)
    ) u_RAM (

        .clk(clk),
        .we(1),
        .adr_rw(adrWRITE),
        .din(dataWRITE)
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

        //DRAW ENEMIES
        DRAW_ENEMY1 = 5'd13,
        DRAW_ENEMY2 = 5'd14,
        DRAW_ENEMY3 = 5'd15,

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
        halt = 0;
        #20 rst = 0;

        // timeout
        #1000000;
        $display("Simulation timeout reached.");
        $finish;
    end


    int reset_count = 0;

    always @(posedge clk) begin

        halt = 0;

        if (go) begin
            reset_count = reset_count + 1;
            halt = 1;
        end


        if(reset_count == 4) begin
            $display("Four resets/ four frames drawn at time: %t", $time);
            $display("PASSED :3");
            $finish;
        end

    
    end


endmodule
