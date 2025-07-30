module vector_manage_tb;

    // Testbench signals
    logic clk;
    logic rst;
    logic pos;
    logic line;
    logic busy;
    logic [7:0] i_x, i_y;
    logic [7:0] o_start_x, o_start_y, o_end_x, o_end_y;
    logic go;
    
    // Signals for linedraw
    logic wr;
    logic [7:0] xout, yout;


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
    data_entry_t data_entries[17] = '{
        '{200, 210, 0, 1},
        '{220, 230, 0, 1},
        '{160, 140, 0, 1},
        '{200, 160, 1, 0},
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
        '{255 , 255, 1, 1}
    };

    logic [7:0] addr;
    logic [5:0] state_debug_bits;

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

        .busy(busy),

        .go(go),
        .stax(o_start_x),
        .endx(o_end_x),
        .stay(o_start_y),
        .endy(o_end_y),

        .adr(addr),
        .state_debug(state_debug_bits)
    );


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

    always @(posedge clk) begin
        pos  <= data_entries[addr].pos;
        line <= data_entries[addr].line;
        i_x  <= data_entries[addr].x;
        i_y  <= data_entries[addr].y;

        // end if adr = 100
        if (addr == 8'd100) begin
            $display("Simulation ended because addr == 100 at time %t", $time);
            $finish;
        end
    end
endmodule
