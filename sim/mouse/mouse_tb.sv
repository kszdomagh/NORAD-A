`timescale 1ns/1ps

module tb_ps2_mouse;

    // Clock & reset
    reg clk100MHz;
    reg btnC;

    // PS/2 lines
    reg PS2Clk;
    reg PS2Data;

    // Outputs
    wire [7:0] Xmouse;
    wire [7:0] Ymouse;
    wire Lmouse;
    wire Rmouse;

    // Instantiate DUT
    ps2_mouse u_mouse (
        .i_clk(clk100MHz),
        .i_reset(btnC),
        .i_PS2Clk(PS2Clk),
        .i_PS2Data(PS2Data),
        .o_x(Xmouse),
        .o_y(Ymouse),
        .o_l_click(Lmouse),
        .o_r_click(Rmouse)
    );

    // Clock generation (100 MHz)
    initial clk100MHz = 0;
    always #5 clk100MHz = ~clk100MHz;

    // Idle PS/2 lines high
    initial begin
        PS2Clk = 1;
        PS2Data = 1;
    end

    // Task to send a byte over PS/2
    // PS/2: start(0), 8 data bits (LSB first), parity (odd), stop(1)
    task send_ps2_byte(input [7:0] data);
        integer i;
        reg parity;
        begin
            parity = 1'b1; // odd parity
            // Start bit
            PS2Data = 0;
            toggle_ps2_clock;
            // Data bits
            for (i = 0; i < 8; i = i + 1) begin
                PS2Data = data[i];
                parity = parity ^ data[i];
                toggle_ps2_clock;
            end
            // Parity bit
            PS2Data = parity;
            toggle_ps2_clock;
            // Stop bit
            PS2Data = 1;
            toggle_ps2_clock;
            // Line idle before next byte
            #(200);
        end
    endtask

    // Toggle PS2 clock for one bit time (~100 us typical in real hardware, shorter in sim)
    task toggle_ps2_clock;
        begin
            PS2Clk = 0; #(50);
            PS2Clk = 1; #(50);
        end
    endtask

    // Test sequence
    initial begin
        // Reset
        btnC = 1;
        #100;
        btnC = 0;

        // Wait a bit
        #500;

        // Example packet: Move right (+10), up (+5), no buttons
        send_ps2_byte(8'b0000_0000); // No buttons, no sign bits
        send_ps2_byte(8'd10);        // X movement
        send_ps2_byte(8'd5);         // Y movement

        // Example packet: Left click, move left (-4), down (-3)
        send_ps2_byte(8'b0000_0001 | 8'b0001_0000 | 8'b0010_0000); // Left btn=1, X sign=1, Y sign=1
        send_ps2_byte(8'd252);       // X = -4 (two's complement)
        send_ps2_byte(8'd253);       // Y = -3 (two's complement)

        // Example packet: Right click only, no movement
        send_ps2_byte(8'b0000_0010); // Right btn=1
        send_ps2_byte(8'd0);
        send_ps2_byte(8'd0);

        // End simulation
        #2000;
        $stop;
    end

endmodule
