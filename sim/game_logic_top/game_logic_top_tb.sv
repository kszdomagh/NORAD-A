module game_logic_top_tb;

    // Testbench signals
    logic clk_slow;
    logic clk;
    logic rst;

    import vector_pkg::*;
	import img_pkg::*;

    // INTERNAL WIRES
    logic [DAC_WIDTH-1:0] xenemy1;
    logic [DAC_WIDTH-1:0] xenemy2;
    logic [DAC_WIDTH-1:0] xenemy3;


    logic [ADDRESSWIDTH-1:0] adr_enemy1;
    logic [ADDRESSWIDTH-1:0] adr_enemy2;
    logic [ADDRESSWIDTH-1:0] adr_enemy3;

    logic spawn_enemy1, spawn_enemy2, spawn_enemy3;


    game_logic_top #(
        .ADDRESSWIDTH(16),
        .OUT_WIDTH(8),

        .TIME_SPAWN_ENEMY1(1_000),
        .TIME_SPAWN_ENEMY2(1_200),
        .TIME_SPAWN_ENEMY3(1_900),

        .TIME_SPEED_ENEMY1(1_000),
        .TIME_SPEED_ENEMY2(1_200),
        .TIME_SPEED_ENEMY3(1_900)
    ) u_DUT (
        .clk_fast(clk),
        .clk_slow(clk_slow),
        .rst(rst),

        .spawn_enemy1(spawn_enemy1),
        .xenemy1(xenemy1),
        .adr_enemy1(adr_enemy1),

        .spawn_enemy2(spawn_enemy2),
        .xenemy2(xenemy2),
        .adr_enemy2(adr_enemy2),

        .spawn_enemy3(spawn_enemy3),
        .xenemy3(xenemy3),
        .adr_enemy3(adr_enemy3)
    );



    // Clock generation
    initial clk = 0;
    always #5 clk = ~clk; // 100MHz clock

    initial clk_slow = 0;
    always #100 clk_slow = ~clk_slow;  // 5MHz


    // Stimulus block
    initial begin
        rst = 1;
        #20 rst = 0;

        //  send a reset
        #1_300_000 rst = 1;
        #20 rst = 0;

        // timeout
        #100000000;
        $display("Simulation timeout reached.");
        $finish;
    end



    always @(posedge clk) begin

        if ( (xenemy1 == X_ENEMY_END) & (xenemy2 == X_ENEMY_END) & (xenemy3 == X_ENEMY_END) ) begin
            $display("all 3 planes reached the end of a map at: %t", $time);
            $display("PASSED :3");
            $finish;
        end

    
    end


endmodule
