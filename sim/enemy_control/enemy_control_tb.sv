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
    logic rockethit;
    logic [ADDRESSWIDTH-1:0] adr_enemy;


    timer_cluster #(
        .TIME1(100),
        .TIME2(224),
        .TIME_SLOW1(60)
    ) u_timer_cluster (
        .clk_fast(clk),
        .clk_slow(clk_slow),
        .rst(rst),
        .speed1_pulse(speed1_pulse),
        .speed2_pulse(speed2_pulse),
        .slow1_pulse(slow1_pulse)

    );

    // DUT
    enemy_control #(
        .OUT_WIDTH(DAC_WIDTH),
        .ADDRESSWIDTH(ADDRESSWIDTH),
        .DESTOY_ANIMATION_TIME(3),
        
        .X_BASE(X_BASE1),
        .Y_ENEMY_BASE(Y_ENEMY1_BASE1),

        .X_ENEMY_START(X_ENEMY_START),
        .X_ENEMY_END(X_ENEMY_END)


    ) u_DUT (
        .clk(clk),
        .rst(rst),

        .rockethit(rockethit),
        
        .spawn_pulse(slow1_pulse),
        .speed_pulse(speed1_pulse),

        .xenemy(xenemy),
        .yenemy(yenemy),
        .spawn(spawn),
        .adr_enemy(adr_enemy)
    );


    // Clock generation
    initial clk = 0;
    always #5 clk = ~clk; // 100MHz clock

    initial clk_slow = 0;
    always #100 clk_slow = ~clk_slow;  // 5MHz

    initial rockethit = 0;


    // Stimulus block
    initial begin
        rst = 1;
        #20 rst = 0;

        //simulate the enemy being hit
        #40000
        $display("Plane at: %d at time %t", xenemy, $time);
        #100
        rockethit = 1;
        $display("Plane at: %d at time %t HIT WITH ROCKET", xenemy, $time);
        #100 rockethit = 0;

        //  send a reset
        #60000 rst = 1;
        #20 rst = 0;
        
        

        #100000000;
        $display("Simulation timeout reached.");
        $finish;
    end


    int reset_count = 0;

    always @(posedge clk) begin

        if(xenemy == X_ENEMY_END) reset_count <= reset_count + 1;


        if (reset_count >= 10) begin
            $display("Plane reached the base and bombed it at: %t", $time);
            $display("PASSED :3");
            $finish;
        end

    
    end


endmodule
