module linedraw_tb;

    // Clock parameters
    timeunit 1ns;
    timeprecision 1ps;
    localparam CLK_PERIOD = 100; // 10 MHz clock

    // Signals
    logic clk, go;
    logic [7:0] stax, stay, endx, endy;
    logic wr;
    logic [7:0] xout, yout;
    logic busy;

    // DUT instantiation
    linedraw dut (
        .pclk(clk),
        .go(go),
        .busy(busy),
        .stax(stax),
        .stay(stay),
        .endx(endx),
        .endy(endy),
        .wr(wr),
        .xout(xout),
        .yout(yout)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #(CLK_PERIOD / 2) clk = ~clk;
    end

    // Main test sequence
    initial begin
        $display("Starting linedraw testbench");
        $monitor("Time: %0t | wr: %b | busy: %b | xout: %0d | yout: %0d", $time, wr, busy, xout, yout);

        // Initialize signals
        go = 0;
        stax = 0;
        stay = 0;
        endx = 0;
        endy = 0;

        // Wait for reset-like settling
        #200;

        // Test 1: Simple diagonal line
        stax = 10;
        stay = 10;
        endx = 20;
        endy = 20;
        go = 1;
        #CLK_PERIOD go = 0;

        // Wait for line drawing to complete
        wait (!busy);
        #200;

        // Test 2: Horizontal line
        stax = 50;
        stay = 40;
        endx = 80;
        endy = 40;
        go = 1;
        #CLK_PERIOD go = 0;

        wait (!busy);
        #200;

        // Test 3: Vertical line
        stax = 100;
        stay = 30;
        endx = 100;
        endy = 60;
        go = 1;
        #CLK_PERIOD go = 0;

        wait (!busy);
        #200;

        $display("All tests done.");
        $finish;
    end

endmodule
