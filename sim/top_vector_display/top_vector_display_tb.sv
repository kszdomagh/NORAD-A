module top_vector_display_tb;

    // Testbench signals
    logic clk;
    logic rst;
    logic pos;
    logic draw;
    logic busy;
    logic [7:0] i_x, i_y;
    logic [7:0] o_start_x, o_start_y, o_end_x, o_end_y;
    logic go;
    
    // Signals for linedraw
    logic wr;
    logic [7:0] xout, yout;

    // Data entries (x, y, draw, pos)
    typedef struct {
        logic [7:0] x;
        logic [7:0] y;
        logic draw;
        logic pos;
    } data_entry_t;

    data_entry_t data_entries[15] = '{
        '{174, 162, 1, 1},
        '{161, 147, 1, 0},
        '{148, 162, 1, 0},
        '{92 , 148, 0, 1},
        '{80 , 165, 1, 0},
        '{105, 167, 1, 0},
        '{210, 98 , 0, 1},
        '{208, 65 , 1, 0},
        '{189, 49 , 1, 0},
        '{151, 49 , 1, 0},
        '{133, 68 , 1, 0},
        '{118, 50 , 1, 0},
        '{79 , 51 , 1, 0},
        '{54 , 65 , 1, 0},
        '{54 , 105, 1, 0}
    };

    // Instantiate the draw_vector_master module
    memory_draw_vector_master #(
        .OUT_WIDTH(8),
        .ADDRESSWIDTH(10),
        .FRAME_MIN(0),
        .FRAME_MAX(255)
    ) u_memory_draw_vector_master (
        .clk(clk),
        .rst_n(rst),
        .pos(pos),
        .draw(draw),
        .busy(busy),
        .i_x(i_x),
        .i_y(i_y),
        .go(go_un), // Controlled by testbench
        .o_start_x(o_start_x),
        .o_start_y(o_start_y),
        .o_end_x(o_end_x),
        .o_end_y(o_end_y)
    );

    wire go_uc;
    
    // Instantiate the linedraw module
    linedraw u_linedraw (
        .clk(clk),
        .go(go), // Controlled by testbench
        .busy(busy),
        .stax(o_start_x),
        .stay(o_start_y),
        .endx(o_end_x),
        .endy(o_end_y),
        .wr(wr),
        .xout(xout),
        .yout(yout)
    );

    // Clock generation
    always #5 clk = ~clk; // 100MHz clock

    // Stimulus block
    initial begin
        // Initialize signals
        clk = 0;
        rst = 0;
        pos = 0;
        draw = 0;
        i_x = 8'd50;
        i_y = 8'd50;
        go = 0; // Ensure go is initially off
        
        // Reset the design
        rst = 1;
        #10 rst = 0;
        
        // Iterate over data_entries
        go = 1;
        
        foreach (data_entries[i]) begin
            wait(busy == 0);
            
            // Set position and draw based on data
            pos = data_entries[i].pos;
            draw = data_entries[i].draw;
            i_x = data_entries[i].x;
            i_y = data_entries[i].y;

            // Assert go signal to start draw
            go = 1;
            #10; // Wait for one clock cycle
            go = 0; // Deassert go signal

            // Assert pos and draw, wait for the next cycle
            #10; // Apply position signal
            pos = 0; // Deassert pos

            #20; // Apply draw signal
            draw = 0; // Deassert draw

            wait(busy == 0); 
        end
        
        // Finish the simulation
        $finish;
    end

    // Monitor outputs
    initial begin
        $monitor("At time %t: pos=%b, draw=%b, xout=%d, yout=%d, o_start_x=%d, o_start_y=%d, o_end_x=%d, o_end_y=%d", 
                 $time, pos, draw, xout, yout, o_start_x, o_start_y, o_end_x, o_end_y);
    end

endmodule
