module enemy_control_tb;

    // Testbench signals
    logic clk_slow;
    logic clk;
    logic rst;

    import vector_pkg::*;
	import ROM_pkg::*;

    // INTERNAL WIRES
    logic [DAC_WIDTH-1:0] xenemy;
    logic [DAC_WIDTH-1:0] yenemy;
    logic spawn;
    logic alive;


    timer_cluster #(
        .TIME1(1_000),
        .TIME2(2_240),
        .TIME_SLOW1(2_000)
    ) u_timer_cluster (
        .clk100MHz(clk),
        .clk4MHz(clk_slow),
        .rst(rst),
        .speed1_pulse(speed1_pulse),
        .speed2_pulse(speed2_pulse),
        .slow1_pulse(slow1_pulse)

    );

    // DUT
    enemy_control #(
        .OUT_WIDTH(DAC_WIDTH),
        .TARGET_BASE(1)
    ) u_DUT (
        .clk(clk),
        .rst(rst),
        .en(alive),
        .spawn_pulse(slow1_pulse),
        .speed_pulse(speed1_pulse),

        .spawn(spawn),
        .xenemy(xenemy),
        .yenemy(yenemy)
    );


    // Clock generation
    initial clk = 0;
    always #5 clk = ~clk; // 100MHz clock

    initial clk_slow = 0;
    always #100 clk_slow = ~clk_slow;  // 5MHz

    initial alive = 1;

    // Stimulus block
    initial begin
        rst = 1;
        #20 rst = 0;

        //simulate the enemy being hit
        #1_000_000 
        $display("Plane at: %d at time %t", xenemy, $time);
        #100
        alive = '0;
        $display("Plane at: %d at time %t DESTOYED", xenemy, $time);
        #100 alive = 1;

        // Optional: add timeout
        #100000000;
        $display("Simulation timeout reached.");
        $finish;
    end


    int reset_count;

    always @(posedge clk) begin

        if (xenemy == X_BASE1) begin
            $display("Plane reached the base and bombed it at: %t", $time);
            $display("PASSED :3");
            $finish;
        end

    
    end


endmodule
