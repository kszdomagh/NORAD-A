module top_vector_display_tb;

    // Testbench signals
    logic clk;
    logic rst;

    import vector_pkg::*;

    // INTERNAL WIRES
    logic [ADDRESSWIDTH-1:0] uwu_addr;
    logic [DATAWIDTH-1:0] uwu_data;

    logic [DAC_WIDTH-1:0] x_data;
    logic [DAC_WIDTH-1:0] y_data;

    logic frame_drawn;
    logic enable;

    logic [DAC_WIDTH-1:0] xch;
    logic [DAC_WIDTH-1:0] ych;

    // DUT
    top_vector_display #(
        .OUT_WIDTH(DAC_WIDTH),
        .ADDRESSWIDTH(ADDRESSWIDTH),
        .DATAWIDTH(DATAWIDTH)
    ) u_vector_display (
        .clk(clk),

        .rst(rst),
        .data_in(uwu_data),
        .addr(uwu_addr),
        .x_ch(xch),
        .y_ch(ych),

        .go_master(enable),
        .halt(frame_drawn)
    );

    uwu_rom #(
        .ADDRESSWIDTH(ADDRESSWIDTH),
        .DATAWIDTH(DATAWIDTH)
    ) u_uwu_rom (
        .addr(uwu_addr),
        .data_out(uwu_data)
    );

    assign x_data = uwu_data[9:2];
    assign y_data = uwu_data[17:10];

    // Clock generation
    initial clk = 0;
    always #5 clk = ~clk; // 100MHz clock

    initial begin
        rst = 1;
        enable = 0;
        #20 rst = 0;
        #100  enable = 1;

        // Optional: add timeout
        #1000000;
        $display("Simulation timeout reached.");
        $finish;
    end


    int reset_count = 0;

    always @(posedge clk) begin

        enable = 1;

        if (frame_drawn) begin
            reset_count = reset_count + 1;
            enable = 0;
        end


        if(reset_count == 6) begin
            $display("Four frames drawn drawn at time: %t", $time);
            $display("PASSED :3");
            $finish;
        end
    end


endmodule
