module top_vector_display_tb;

    // Testbench signals
    logic clk;
    logic rst;
    logic pos;
    logic line;
    logic busy;
    logic [7:0] i_x, i_y;
    logic [7:0] o_start_x, o_start_y, o_end_x, o_end_y;
    logic go;
    logic inc;
    
    // Signals for linedraw
    logic wr;
    logic [7:0] xout, yout;

    // Data entries (x, y, draw, pos)
    typedef struct {
        logic [7:0] x;
        logic [7:0] y;
        logic line;
        logic pos;
    } data_entry_t;

    data_entry_t data_entries[16] = '{
        '{174, 162, 1, 0},
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
        '{54 , 105, 1, 0},
        '{255 , 255, 0, 1}
    };

    // Instantiate the draw_vector_master module
    draw_vector_master #(
        .OUT_WIDTH(8)
    ) u_draw_vector_master (
        .clk(clk),
        .rst(rst),
        .pos(pos),
        .line(line),
        .busy(busy),
        .i_x(i_x),
        .i_y(i_y),
        .go(go), // Controlled by testbench
        .o_start_x(o_start_x),
        .o_start_y(o_start_y),
        .o_end_x(o_end_x),
        .o_end_y(o_end_y),
        .inc(inc)
    );
    
    // Instantiate the linedraw module
    linedraw u_linedraw (
        .clk(clk),
        .go(go), 
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
        line = 0;

        // Reset the design
        rst = 1;
        #10 rst = 0;

        foreach (data_entries[i]) begin

            // wait for con dutions to write memory
            wait(busy == 0);
            wait(inc == 1);
            
            // set memory
            pos = data_entries[i].pos;
            line = data_entries[i].line;
            i_x = data_entries[i].x;
            i_y = data_entries[i].y;
            
            // wait for operation
            wait(busy == 1); // Wait for the system to be idle
            wait(busy == 0); // Ensure the system is idle
        end
    end

    // Monitor outputs
    initial begin
        $monitor("At time %t: pos=%b, line=%b, xout=%d, yout=%d, o_start_x=%d, o_start_y=%d, o_end_x=%d, o_end_y=%d", 
                 $time, pos, line, xout, yout, o_start_x, o_start_y, o_end_x, o_end_y);
    end

endmodule
