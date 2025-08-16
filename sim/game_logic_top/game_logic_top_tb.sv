module enemy_control_tb;

    // Testbench signals
    logic clk_slow;
    logic clk;
    logic rst;

    import vector_pkg::*;
	import img_pkg::*;

    // INTERNAL WIRES
    logic [DAC_WIDTH-1:0] xenemy;
    logic [DAC_WIDTH-1:0] yenemy;
    logic spawn;
    logic alive;


    game_logic_top #(
        .ADDRESSWIDTH(16),
        .DATAWIDTH(18),
        .OUT_WIDTH(8),

        .TIME_SPAWN_ENEMY1(1_000),
        .TIME_SPAWN_ENEMY2(1_200),
        .TIME_SPAWN_ENEMY3(1_900),

        .TIME_SPEED_ENEMY1(1_000),
        .TIME_SPEED_ENEMY2(1_200),
        .TIME_SPEED_ENEMY3(1_900)
    ) u_DUT (
        .clk100MHz(clk),
        .clk40MHz(clk_slow),
        .clk4MHz(clk_slow),
        .rst(rst),

        .spawn_enemy1(spawn_enemy1),
        .xenemy1(xenemy1),

        .spawn_enemy2(spawn_enemy2),
        .xenemy2(xenemy2),

        .spawn_enemy3(spawn_enemy3),
        .xenemy3(xenemy3)
    );

    logic [DAC_WIDTH-1:0] xenemy1;
    logic [DAC_WIDTH-1:0] xenemy2;
    logic [DAC_WIDTH-1:0] xenemy3;

    logic spawn_enemy1, spawn_enemy2, spawn_enemy3;


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

        //  send a reset
        #1_300_000 rst = 1;
        #20 rst = 0;

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
