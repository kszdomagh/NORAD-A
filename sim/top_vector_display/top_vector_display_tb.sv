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

    logic [DAC_WIDTH-1:0] xch;
    logic [DAC_WIDTH-1:0] ych;

    // DUT
    top_vector_display #(
        .OUT_WIDTH(DAC_WIDTH),
        .CLK_DIV_VALUE(100),
        .ADDRESSWIDTH(ADDRESSWIDTH),
        .DATAWIDTH(DATAWIDTH)
    ) u_vector_display (
        .enable(1'b1),
        .clk(clk),
        .rst(rst),
        .data_in(uwu_data),
        .addr(uwu_addr),
        .x_ch(xch),
        .y_ch(ych),
        .frame_drawn(frame_drawn)
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
        $display("Time: %0t | addr=%0d | data_in=%b | xch=%0d | ych=%0d | frame_drawn=%b",
                 $time, uwu_addr, uwu_data, xch, ych, frame_drawn);


        if (frame_drawn && !frame_reset && ++reset_count == 4) begin
            $display("Drawn frame two times in time: %t", $time);
            $display("PASSED :3");
            $finish;
        end
        frame_reset <= frame_drawn;

    
    end


endmodule
