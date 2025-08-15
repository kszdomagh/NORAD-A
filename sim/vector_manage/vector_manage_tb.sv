module vector_manage_tb;

    // Testbench signals
    logic clk;
    logic rst;
    logic pos;
    logic line;
    logic [7:0] i_x, i_y;
    logic signed [8:0] o_start_x, o_start_y, o_end_x, o_end_y;
    logic go;
    logic vector_reset;
    
    // Signals for linedraw
    logic signed [8:0] xout, yout;


    typedef enum logic [5:0] {
        RESET      = 6'b000001,
        GETDATA    = 6'b000010,
        CHECKDATA  = 6'b000011,     //fix this later
        SENDDATA   = 6'b000100,
        GODOWN     = 6'b001000,
        WAITBUSY   = 6'b010000,
        ADR        = 6'b100000
    } state_t;

    // Data entries (x, y, draw, pos)
    typedef struct {
        logic [7:0] x;
        logic [7:0] y;
        logic line;
        logic pos;
    } data_entry_t;

        //x     y  line pos
    data_entry_t data_entries[12] = '{
        '{0, 0, 0, 1},
        '{200, 200, 0, 1},
        '{150, 90,  1, 0},
        '{0,    0,  1, 0},
        '{254 , 1,  1, 0},
        '{255, 254, 1, 0},
        '{0, 255,   1, 0},
        '{0, 0,     1 , 0},
        '{250, 250,     1 , 0},
        '{10, 20,     1 , 0},
        '{0, 0,     1 , 1},
        '{20, 20 , 1, 0}

    };

    logic [7:0] addr;
    logic [5:0] state_debug_bits;
    logic done;
    logic busy;

    vector_manage #(
        .ADR_WIDTH(8),
        .FRAME_MAX(255),
        .FRAME_MIN(0),
        .OUT_WIDTH(8)
    ) u_vector_manage (
        .clk(clk),
        .rst(rst),

        .x(i_x),
        .y(i_y),
        .line(line),
        .pos(pos),

        .done(done),
        .busy(busy),

        .go(go),
        .stax(o_start_x),
        .endx(o_end_x),
        .stay(o_start_y),
        .endy(o_end_y),

        .adr(addr),
        .vector_reset(vector_reset)
    );

    logic output_valid;


    bresenham u_bresenham (
        .clk(clk),
        .rst(rst),
        .go(go), 
        .busy(busy),
        .stax(o_start_x),
        .stay(o_start_y),
        .endx(o_end_x),
        .endy(o_end_y),
        .x(xout),
        .y(yout),
        .drawing(output_valid),

        .done(done)
    );

    state_t state_debug;
    assign state_debug = state_t'(state_debug_bits); // cast from raw wire

    // Clock generation
    always #5 clk = ~clk; // 100MHz clock

    initial begin
        clk = 0;
        rst = 1;
        #20 rst = 0;

        

        $monitor("At time %t: pos=%b, line=%b, xout=%d, yout=%d, o_start_x=%d, o_start_y=%d, o_end_x=%d, o_end_y=%d", 
                $time, pos, line, xout, yout, o_start_x, o_start_y, o_end_x, o_end_y);
    end

    int reset_count;
    logic prev_reset;

    always @(posedge clk) begin
        pos  <= data_entries[addr].pos;
        line <= data_entries[addr].line;
        i_x  <= data_entries[addr].x;
        i_y  <= data_entries[addr].y;

        if (vector_reset && !prev_reset && ++reset_count == 3) begin
            $display("Recieved three vector resets at time: %t", $time);
            $display("PASSED :3");
            $finish;
        end
        prev_reset <= vector_reset;
    end
endmodule
