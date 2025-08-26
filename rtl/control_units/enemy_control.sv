//////////////////////////////////////////////////////////////////////////////
/*
 Module name:   enemy_control
 Author:        kszdom
 Description:  control module for enemy
 */
//////////////////////////////////////////////////////////////////////////////
module enemy_control #(
    parameter int OUT_WIDTH = 8,
    parameter int ADDRESSWIDTH = 0,
    
    //  BASE XY 
    parameter int X_BASE = 0,
    parameter int Y_ENEMY_BASE = 0,

    // COSMETICS
    parameter int DESTOY_ANIMATION_TIME = 3,

    // ENEMY RFLYING RANGE
    parameter int X_ENEMY_START = 8'd20,
    parameter int X_ENEMY_END = 8'd20
)(
	input logic clk,
	input logic rst,

    input logic speed_pulse,
    input logic spawn_pulse,
    input logic rockethit,
    input logic [ADDRESSWIDTH-1:0] adr_enemy_start,
    //input logic enemy_randomize,     // randomize what enemy

    output logic [OUT_WIDTH-1:0] xenemy,
    output logic [OUT_WIDTH-1:0] yenemy,
    output logic spawn,
    output logic [ADDRESSWIDTH-1:0] adr_enemy
);

    import vector_pkg::*;
    import img_pkg::*;

    logic [ADDRESSWIDTH-1:0] adr_enemy_nxt;
    logic [OUT_WIDTH-1:0] yenemy_nxt;
    logic [OUT_WIDTH-1:0] xenemy_nxt;
    logic spawn_nxt, hit_nxt;

    localparam int COUNTER_WIDTH = $clog2(DESTOY_ANIMATION_TIME+1);
    logic [COUNTER_WIDTH-1:0] destroyed_counter;
    logic [COUNTER_WIDTH-1:0] destroyed_counter_nxt;

    typedef enum logic [4:0] {
        RESET             = 5'd0,
        IDLE              = 5'd1,
        FLY               = 5'd2,
        DESTROYED          = 5'd3,
        GONE              = 5'd4
    } state_t;

    state_t state, state_nxt;

    always_ff@(posedge clk) begin
        if(rst) begin
            state <= RESET;

            xenemy    <= X_ENEMY_START;
            yenemy    <= Y_ENEMY_BASE;
            spawn     <= 1'b0;
            adr_enemy <= adr_enemy_nxt;
            destroyed_counter   <= DESTOY_ANIMATION_TIME;

        end else begin
            state <= state_nxt;
            
            xenemy    <= xenemy_nxt;
            yenemy    <= yenemy_nxt;
            spawn     <= spawn_nxt;
            adr_enemy <= adr_enemy_nxt;
            destroyed_counter   <= destroyed_counter_nxt;
        end
    end

    // next state always comb
    always_comb begin
        state_nxt = RESET; //default
        case(state)
            RESET: state_nxt = IDLE;

            IDLE: state_nxt = spawn_pulse ? FLY : IDLE;

            FLY: begin
                if(rockethit) state_nxt = DESTROYED;
                else if(xenemy == X_ENEMY_END) state_nxt = GONE;
                else state_nxt = FLY;
            end

            DESTROYED: begin
                
                if(destroyed_counter < DESTOY_ANIMATION_TIME) begin
                    state_nxt = DESTROYED;
                end else if(xenemy < X_BASE) begin
                    state_nxt = GONE;
                end else begin
                    state_nxt = IDLE;
                end

            end

            GONE: state_nxt = GONE;

            default: state_nxt = RESET;
        endcase
    end

    // outputs always comb
    always_comb begin

        //defaults
        adr_enemy_nxt = adr_enemy_start;
        yenemy_nxt = Y_ENEMY_BASE;
        xenemy_nxt = xenemy;
        spawn_nxt = spawn;
        destroyed_counter_nxt = destroyed_counter;


        case(state)

            RESET: begin
                xenemy_nxt = X_ENEMY_START;
                spawn_nxt = 1'b0;
            end

            IDLE: begin
                destroyed_counter_nxt = 0;  
                xenemy_nxt = X_ENEMY_START;
                spawn_nxt = 1'b0;

            end

            FLY: begin
                xenemy_nxt = xenemy;
                spawn_nxt = 1'b1;
                if(speed_pulse) begin
                    xenemy_nxt = xenemy - 1;
                end
            end

            DESTROYED: begin
                xenemy_nxt = xenemy;
                spawn_nxt = 1'b1;
                adr_enemy_nxt = ADR_EXPLOSION_START;

                destroyed_counter_nxt = destroyed_counter+1; //potem se dodaje az bedzie liczba w parametrze

            end

            GONE: begin
                xenemy_nxt = X_ENEMY_END;
                spawn_nxt = 1'b0;

            end


        endcase

    end


endmodule