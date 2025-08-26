//////////////////////////////////////////////////////////////////////////////
/*
 Module name:   mtm_rom
 Author:        kszdom
 Description:   ROM memory for MTM logo
 */
//////////////////////////////////////////////////////////////////////////////
module mtm_rom #(
    parameter int ADDRESSWIDTH = 14,  // 4 bits => 16 entries
    parameter int DATAWIDTH = 18  // 8+8+1+1 = 18 bits
)(
    input logic [ADDRESSWIDTH-1:0] addr,
    output logic [DATAWIDTH-1:0] data_out
);


    always_comb begin
        unique case (addr)
			//                  x       y       line    pos
            0:  data_out = {8'd32, 8'd98, 1'b0, 1'b1};
            1:  data_out = {8'd33, 8'd94, 1'b1, 1'b0};
            2:  data_out = {8'd35, 8'd92, 1'b1, 1'b0};
            3:  data_out = {8'd41, 8'd92, 1'b1, 1'b0};
            4:  data_out = {8'd44, 8'd95, 1'b1, 1'b0};
            5:  data_out = {8'd44, 8'd101, 1'b1, 1'b0};
            6:  data_out = {8'd41, 8'd104, 1'b1, 1'b0};
            7:  data_out = {8'd35, 8'd104, 1'b1, 1'b0};
            8:  data_out = {8'd32, 8'd98, 1'b1, 1'b0};
            9:  data_out = {8'd32, 8'd173, 1'b0, 1'b1};
            10:  data_out = {8'd37, 8'd175, 1'b1, 1'b0};
            11:  data_out = {8'd63, 8'd175, 1'b1, 1'b0};
            12:  data_out = {8'd66, 8'd172, 1'b1, 1'b0};
            13:  data_out = {8'd80, 8'd128, 1'b1, 1'b0};
            14:  data_out = {8'd83, 8'd125, 1'b1, 1'b0};
            15:  data_out = {8'd87, 8'd126, 1'b1, 1'b0};
            16:  data_out = {8'd103, 8'd172, 1'b1, 1'b0};
            17:  data_out = {8'd107, 8'd175, 1'b1, 1'b0};
            18:  data_out = {8'd155, 8'd175, 1'b1, 1'b0};
            19:  data_out = {8'd159, 8'd170, 1'b1, 1'b0};
            20:  data_out = {8'd175, 8'd126, 1'b1, 1'b0};
            21:  data_out = {8'd177, 8'd125, 1'b1, 1'b0};
            22:  data_out = {8'd180, 8'd128, 1'b1, 1'b0};
            23:  data_out = {8'd195, 8'd172, 1'b1, 1'b0};
            24:  data_out = {8'd198, 8'd175, 1'b1, 1'b0};
            25:  data_out = {8'd226, 8'd175, 1'b1, 1'b0};
            26:  data_out = {8'd229, 8'd172, 1'b1, 1'b0};
            27:  data_out = {8'd229, 8'd167, 1'b1, 1'b0};
            28:  data_out = {8'd226, 8'd163, 1'b1, 1'b0};
            29:  data_out = {8'd199, 8'd163, 1'b1, 1'b0};
            30:  data_out = {8'd197, 8'd161, 1'b1, 1'b0};
            31:  data_out = {8'd183, 8'd116, 1'b1, 1'b0};
            32:  data_out = {8'd180, 8'd113, 1'b1, 1'b0};
            33:  data_out = {8'd173, 8'd113, 1'b1, 1'b0};
            34:  data_out = {8'd169, 8'd118, 1'b1, 1'b0};
            35:  data_out = {8'd156, 8'd160, 1'b1, 1'b0};
            36:  data_out = {8'd152, 8'd163, 1'b1, 1'b0};
            37:  data_out = {8'd140, 8'd163, 1'b1, 1'b0};
            38:  data_out = {8'd137, 8'd160, 1'b1, 1'b0};
            39:  data_out = {8'd137, 8'd95, 1'b1, 1'b0};
            40:  data_out = {8'd134, 8'd92, 1'b1, 1'b0};
            41:  data_out = {8'd127, 8'd92, 1'b1, 1'b0};
            42:  data_out = {8'd124, 8'd95, 1'b1, 1'b0};
            43:  data_out = {8'd123, 8'd160, 1'b1, 1'b0};
            44:  data_out = {8'd119, 8'd163, 1'b1, 1'b0};
            45:  data_out = {8'd107, 8'd163, 1'b1, 1'b0};
            46:  data_out = {8'd104, 8'd157, 1'b1, 1'b0};
            47:  data_out = {8'd90, 8'd117, 1'b1, 1'b0};
            48:  data_out = {8'd88, 8'd113, 1'b1, 1'b0};
            49:  data_out = {8'd81, 8'd113, 1'b1, 1'b0};
            50:  data_out = {8'd76, 8'd118, 1'b1, 1'b0};
            51:  data_out = {8'd64, 8'd160, 1'b1, 1'b0};
            52:  data_out = {8'd59, 8'd163, 1'b1, 1'b0};
            53:  data_out = {8'd35, 8'd163, 1'b1, 1'b0};
            54:  data_out = {8'd32, 8'd167, 1'b1, 1'b0};
            55:  data_out = {8'd32, 8'd173, 1'b1, 1'b0};
            56:  data_out = {8'd217, 8'd99, 1'b0, 1'b1};
            57:  data_out = {8'd220, 8'd104, 1'b1, 1'b0};
            58:  data_out = {8'd225, 8'd104, 1'b1, 1'b0};
            59:  data_out = {8'd228, 8'd100, 1'b1, 1'b0};
            60:  data_out = {8'd229, 8'd95, 1'b1, 1'b0};
            61:  data_out = {8'd226, 8'd92, 1'b1, 1'b0};
            62:  data_out = {8'd219, 8'd92, 1'b1, 1'b0};
            63:  data_out = {8'd217, 8'd95, 1'b1, 1'b0};
            64:  data_out = {8'd217, 8'd99, 1'b1, 1'b0};
            65:  data_out = {8'd217, 8'd99, 1'b1, 1'b1};        //  RESET



            default: data_out = {8'd0, 8'd0, 1'b1, 1'b1};
        endcase
    end

endmodule
