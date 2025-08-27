//////////////////////////////////////////////////////////////////////////////
// Module name:   random_enemy_adr
// Author:        kszdom
// Description:   Cyclical enemy starting address selector on posedge flip
//////////////////////////////////////////////////////////////////////////////

module random_enemy_adr #(
    parameter ADRESSWIDTH = 10,
    parameter ADR_START_1 = 0,
    parameter ADR_START_2 = 1,
    parameter ADR_START_3 = 2
)(
    input clk,
    input rst,
    input flip, // positive edge triggers address change
    output reg [ADRESSWIDTH-1:0] adr_enemy_random
);

    reg [1:0] count;            // 0..2
    reg flip_d;            // previous state of flip for edge detection

    always @(posedge clk) begin
        if (rst) begin
            count <= 0;
            adr_enemy_random <= ADR_START_1;
            flip_d <= 0;
        end else begin
            // edge detection
            flip_d <= flip;
            if (flip & ~flip_d) begin
                // positive edge detected
                case (count)
                    0: begin
                        count <= 1;
                        adr_enemy_random <= ADR_START_1;
                    end
                    1: begin
                        count <= 2;
                        adr_enemy_random <= ADR_START_2;
                    end
                    2: begin
                        count <= 0;
                        adr_enemy_random <= ADR_START_3;
                    end
                endcase
            end
        end
    end

endmodule
