module uwu_rom #(
    parameter int ADDRESSWIDTH = 16,  // 4 bits => 16 entries
    parameter int DATAWIDTH = 18  // 8+8+1+1 = 18 bits
)(
    input logic [ADDRESSWIDTH-1:0] addr,
    output logic [DATAWIDTH-1:0] data_out
);


    always_comb begin
        unique case (addr)
            //                  x       y       line    pos

            //      USA MAP
            0:  data_out = {8'd150, 8'd255, 1'b0, 1'b1};
            1:  data_out = {8'd142, 8'd227, 1'b1, 1'b0};
            2:  data_out = {8'd131, 8'd225, 1'b1, 1'b0};
            3:  data_out = {8'd132, 8'd245, 1'b1, 1'b0};
            4:  data_out = {8'd111, 8'd209, 1'b1, 1'b0};
            5:  data_out = {8'd120, 8'd197, 1'b1, 1'b0};
            6:  data_out = {8'd101, 8'd187, 1'b1, 1'b0};
            7:  data_out = {8'd104, 8'd175, 1'b1, 1'b0};
            8:  data_out = {8'd108, 8'd132, 1'b1, 1'b0};
            9:  data_out = {8'd82, 8'd87, 1'b1, 1'b0};
            10:  data_out = {8'd100, 8'd60, 1'b1, 1'b0};
            11:  data_out = {8'd97, 8'd39, 1'b1, 1'b0};
            12:  data_out = {8'd75, 8'd68, 1'b1, 1'b0};
            13:  data_out = {8'd43, 8'd71, 1'b1, 1'b0};
            14:  data_out = {8'd0, 8'd55, 1'b1, 1'b0};
            15:  data_out = {8'd0, 8'd218, 1'b0, 1'b1};
            16:  data_out = {8'd15, 8'd223, 1'b1, 1'b0};
            17:  data_out = {8'd59, 8'd204, 1'b1, 1'b0};
            18:  data_out = {8'd56, 8'd190, 1'b1, 1'b0};
            19:  data_out = {8'd85, 8'd205, 1'b1, 1'b0};
            20:  data_out = {8'd60, 8'd205, 1'b1, 1'b0};
            21:  data_out = {8'd44, 8'd169, 1'b1, 1'b0};
            22:  data_out = {8'd46, 8'd183, 1'b1, 1'b0};
            23:  data_out = {8'd31, 8'd195, 1'b1, 1'b0};
            24:  data_out = {8'd30, 8'd165, 1'b1, 1'b0};
            25:  data_out = {8'd20, 8'd159, 1'b1, 1'b0};
            26:  data_out = {8'd12, 8'd197, 1'b1, 1'b0};
            27:  data_out = {8'd21, 8'd206, 1'b1, 1'b0};
            28:  data_out = {8'd0, 8'd203, 1'b1, 1'b0};
            29:  data_out = {8'd78, 8'd13, 1'b0, 1'b1};
            30:  data_out = {8'd110, 8'd28, 1'b1, 1'b0};
            31:  data_out = {8'd152, 8'd23, 1'b1, 1'b0};
            32:  data_out = {8'd130, 8'd11, 1'b1, 1'b0};
            33:  data_out = {8'd107, 8'd16, 1'b1, 1'b0};
            34:  data_out = {8'd77, 8'd12, 1'b1, 1'b0};
            35:  data_out = {8'd158, 8'd10, 1'b0, 1'b1};
            36:  data_out = {8'd162, 8'd25, 1'b1, 1'b0};
            37:  data_out = {8'd183, 8'd32, 1'b1, 1'b0};
            38:  data_out = {8'd198, 8'd30, 1'b1, 1'b0};
            39:  data_out = {8'd177, 8'd9, 1'b1, 1'b0};
            40:  data_out = {8'd156, 8'd8, 1'b1, 1'b0};
            41:  data_out = {8'd156, 8'd8, 1'b1, 1'b1};       //RESET


            //      FRAME
            42:  data_out = {8'd0, 8'd255, 1'b0, 1'b1};
            43:  data_out = {8'd0, 8'd0, 1'b1, 1'b0};
            44:  data_out = {8'd255, 8'd0, 1'b1, 1'b0};
            45:  data_out = {8'd255, 8'd255, 1'b1, 1'b0};
            46:  data_out = {8'd0, 8'd255, 1'b1, 1'b0};
            47:  data_out = {8'd0, 8'd255, 1'b1, 1'b1};       //RESET



            default: data_out = '0;
        endcase
    end

endmodule
