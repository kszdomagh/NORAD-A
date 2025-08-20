module cursor_tb;

    localparam int OUTWIDTH = 8;
    localparam int STEP     = 5;
    localparam int MINVAL   = 10;
    localparam int MAXVAL   = 245;

    logic clk;
    logic rst;
    logic btnR, btnL, btnC, btnU, btnD;
    logic [OUTWIDTH-1:0] ycursor, xcursor;

    // clkgen
    initial clk = 0;
    always #5 clk = ~clk;   // 100 MHz

    // DUT
    cursor #(
        .OUTWIDTH(OUTWIDTH),
        .STEP(STEP),
        .MINVAL(MINVAL),
        .MAXVAL(MAXVAL)
    ) u_dut (
        .clk(clk),
        .rst(rst),
        .btnR(btnR),
        .btnL(btnL),
        .btnC(btnC),
        .btnU(btnU),
        .btnD(btnD),
        .ycursor(ycursor),
        .xcursor(xcursor)
    );

    // Sekwencja testowa
    initial begin
		$display("starting simulation.");
        // init
        rst   = 1;
        btnR  = 0;
        btnL  = 0;
        btnC  = 0;
        btnU  = 0;
        btnD  = 0;

		$display("reset.");
        // rst
        #20;
        rst = 0;


		$display("simulating moving cursor");
        // 5 moved to right
        repeat(5) begin
            btnR = 1;
            #10;
        end
        btnR = 0;

        // 3 down
        repeat(3) begin
            btnD = 1;
            #10;
        end
        btnD = 0;

        // 4 left
        repeat(4) begin
            btnL = 1;
            #10;
        end
        btnL = 0;

        // going up
        repeat(50) begin
            btnU = 1;
            #10;
        end
        btnU = 0;

        // going down
        repeat(60) begin
            btnR = 1;
            #10;
        end
        btnR = 0;

        #50;
		$display("check waveforrms :3");
		$display("ending simulation.");
        $finish;
    end

    // monitor
    initial begin
        $monitor("T=%0t | X=%0d, Y=%0d | R=%b L=%b U=%b D=%b C=%b",
                 $time, xcursor, ycursor, btnR, btnL, btnU, btnD, btnC);
    end

endmodule
