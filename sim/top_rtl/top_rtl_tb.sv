module top_rtl_tb;

    // Testbench signals
    logic clk100MHz;
    logic clk40MHz;
    logic clk4MHz;
    logic rst;

    import vector_pkg::*;
    import ROM_pkg::*;

    // INTERNAL WIRES
    logic [ADDRESSWIDTH-1:0] ROM_addr;
    logic [ADDRESSWIDTH-1:0] RAM_addr;
    logic [ADDRESSWIDTH-1:0] RAM_write_adr;
    logic [DATAWIDTH-1:0] ROM_data;
    logic [DATAWIDTH-1:0] RAM_data;
    logic [DATAWIDTH-1:0] RAM_write_data;

    logic [DAC_WIDTH-1:0] xch;
    logic [DAC_WIDTH-1:0] ych;

    wire go;
    wire halt;

    logic spawn_enemy;

    //MODULE DECLARATIONS
    top_vector_display #(
        .OUT_WIDTH(DAC_WIDTH),
        .ADDRESSWIDTH(ADDRESSWIDTH),
        .DATAWIDTH(DATAWIDTH)
    ) u_vector_display (
        .clk(clk4MHz),
        .rst(rst),
        .go_master(go),
        .data_in(RAM_data),
        .addr(RAM_addr),
        .halt(halt),
        .x_ch(xch),
        .y_ch(ych)
    );

    memory_manage #(
        .ADR_WIDTH(ADDRESSWIDTH),
        .DATAWIDTH(DATAWIDTH),
        .OUT_WIDTH(DAC_WIDTH)
    ) u_memory_manage (
        .clk(clk100MHz),
        .rst(rst),
        .adrROM(ROM_addr),
        .dataROM(ROM_data),
        .adrWRITE(RAM_write_adr),
        .dataWRITE(RAM_write_data),
        .go(go),
        .halt(halt),
        .x_cursor(40),
        .y_cursor(40),
        .spawn_enemy1(spawn_enemy),
        .xenemy1(120),
        .yenemy1(120)
    );

    template_ram #(
        .ADDRESSWIDTH(ADDRESSWIDTH),
        .BITWIDTH(DATAWIDTH),
        .DEPTH(1000)
    ) u_RAM_module (
        .clk(clk100MHz),
        .adr_r(RAM_addr),
        .data_out_r(RAM_data),
        .data_out_rw(), 
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

    // Clock generation
    initial begin
        clk100MHz = 0;
        forever #5 clk100MHz = ~clk100MHz; // 100MHz
    end

    initial begin
        clk40MHz = 0;
        forever #12.5 clk40MHz = ~clk40MHz; // 40MHz
    end

    initial begin
        clk4MHz = 0;
        forever #125 clk4MHz = ~clk4MHz; // 4MHz
    end

    // Stimulus block
    initial begin
        spawn_enemy = 0;
        rst = 1;
        #20 rst = 0;
        
        $display("Simulation timeout reached.");

        // Optional: add timeout
        #10000000;
        $display("Simulation timeout reached.");
        $finish;
    end

    int halt_count = 0;

    always @(posedge clk100MHz) begin

        if(halt_count == 2) spawn_enemy = 1;
        
        if (halt_count == 3) begin
            $display("Recieved three HALT signals at time: %t", $time);
            $display("Ending simulation.");
            $display("PASSED :3");
            $finish;
        end

    end

    always @(posedge halt) begin
        $display("HALT CALLED");
        halt_count = halt_count + 1;
    end

    always @(posedge go) begin
        $display("GO CALLED");
    end



endmodule
