module top_rtl_tb;

    // Testbench signals
    logic clk100MHz;
    logic clk40MHz;
    logic clk4MHz;
    logic rst;

    import vector_pkg::*;
    import ROM_pkg::*;

    // INTERNAL WIRES
    logic halt_flag;
    logic go_flag;
    logic [OUT_WIDTH-1:0] xsignal;
    logic [OUT_WIDTH-1:0] ysignal;

    //MODULE DECLARATIONS
    top_rtl #(
        .ADDRESSWIDTH(ADDRESSWIDTH),
        .DATAWIDTH(DATAWIDTH),
        .OUT_WIDTH(OUT_WIDTH)
    ) u_DUT (
        .clk100MHz(clk100MHz),
        .clk40MHz(clk40MHz),
        .clk4MHz(clk4MHz),
        .rst(rst),

        .go_flag(go_flag),
        .halt_flag(halt_flag),

        .xch(xsignal),
        .ych(ysignal)
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
        rst = 1;
        #20 rst = 0;
        

        // Optional: add timeout
        #10000000;
        $display("Simulation timeout reached.");
        $finish;
    end

    int halt_count = 0;

    always @(posedge clk100MHz) begin

        if(go_flag) $display("GO FLAG SET");
        if(halt_flag) $display("HALT FLAG SET");
        
        if (halt_count == 3) begin
            $display("Recieved three HALT signals at time: %t", $time);
            $display("Ending simulation.");
            $display("PASSED :3");
            $finish;
        end

    end

    always @(posedge halt_flag) begin
        $display("halt count inc");
        halt_count <= halt_count + 1;
    end



endmodule
