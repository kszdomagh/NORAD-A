//////////////////////////////////////////////////////////////////////////////
/*
 Module name:   start_screen_rom
 Author:        IG, kszdom
 Description:   ROM memory for all used graphics and more

                after each object there is a RESET signal (LINE=1, POS=1)
 */
//////////////////////////////////////////////////////////////////////////////
module img_rom #(
    parameter int ADDRESSWIDTH = 4,  // 4 bits => 16 entries
    parameter int DATAWIDTH = 18  // 8+8+1+1 = 18 bits
)(
    input logic [ADDRESSWIDTH-1:0] addr,
    output logic [DATAWIDTH-1:0] data_out
);

    always_comb begin
        unique case (addr)
            //                  x       y       line    pos




            //      USA MAP     TEMP
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

            //      FRAME       TEMP
            42:  data_out = {8'd0, 8'd254, 1'b0, 1'b1};
            43:  data_out = {8'd0, 8'd0, 1'b1, 1'b0};
            44:  data_out = {8'd254, 8'd0, 1'b1, 1'b0};
            45:  data_out = {8'd254, 8'd254, 1'b1, 1'b0};
            46:  data_out = {8'd0, 8'd254, 1'b1, 1'b0};
            47:  data_out = {8'd0, 8'd254, 1'b1, 1'b1};       //RESET

            //      CURSOR      TEMP
            48:  data_out = {8'd22, 8'd50, 1'b0, 1'b1};
            49:  data_out = {8'd46, 8'd46, 1'b1, 1'b0};
            50:  data_out = {8'd36, 8'd40, 1'b1, 1'b0};
            51:  data_out = {8'd35, 8'd29, 1'b1, 1'b0};
            52:  data_out = {8'd22, 8'd50, 1'b1, 1'b0};
            53:  data_out = {8'd22, 8'd50, 1'b1, 1'b1};         // RESET







//          PLANE BOMBER
            54:  data_out = {8'd255, 8'd0, 1'b0, 1'b1};
            55:  data_out = {8'd253, 8'd0, 1'b1, 1'b0};
            56:  data_out = {8'd255, 8'd2, 1'b1, 1'b0};
            57:  data_out = {8'd251, 8'd6, 1'b1, 1'b0};
            58:  data_out = {8'd254, 8'd9, 1'b1, 1'b0};
            59:  data_out = {8'd251, 8'd12, 1'b0, 1'b1};
            60:  data_out = {8'd255, 8'd16, 1'b1, 1'b0};
            61:  data_out = {8'd251, 8'd20, 1'b1, 1'b0};
            62:  data_out = {8'd254, 8'd23, 1'b1, 1'b0};
            63:  data_out = {8'd251, 8'd25, 1'b1, 1'b0};
            64:  data_out = {8'd255, 8'd29, 1'b1, 1'b0};
            65:  data_out = {8'd253, 8'd31, 1'b1, 1'b0};
            66:  data_out = {8'd238, 8'd16, 1'b1, 1'b0};
            67:  data_out = {8'd253, 8'd0, 1'b1, 1'b0};
            68:  data_out = {8'd253, 8'd0, 1'b1, 1'b1};       // RESET



            // ICBM
            69:  data_out = {8'd254, 8'd0, 1'b0, 1'b1};
            70:  data_out = {8'd255, 8'd1, 1'b1, 1'b0};
            71:  data_out = {8'd255, 8'd2, 1'b1, 1'b0};
            72:  data_out = {8'd254, 8'd2, 1'b1, 1'b0};
            73:  data_out = {8'd254, 8'd4, 1'b1, 1'b0};
            74:  data_out = {8'd255, 8'd4, 1'b1, 1'b0};
            75:  data_out = {8'd255, 8'd5, 1'b1, 1'b0};
            76:  data_out = {8'd254, 8'd5, 1'b1, 1'b0};
            77:  data_out = {8'd254, 8'd6, 1'b1, 1'b0};
            78:  data_out = {8'd241, 8'd6, 1'b1, 1'b0};
            79:  data_out = {8'd239, 8'd5, 1'b1, 1'b0};
            80:  data_out = {8'd229, 8'd5, 1'b1, 1'b0};
            81:  data_out = {8'd226, 8'd3, 1'b1, 1'b0};
            82:  data_out = {8'd229, 8'd1, 1'b1, 1'b0};
            83:  data_out = {8'd239, 8'd1, 1'b1, 1'b0};
            84:  data_out = {8'd241, 8'd0, 1'b1, 1'b0};
            85:  data_out = {8'd254, 8'd0, 1'b1, 1'b0};
            86:  data_out = {8'd184, 8'd168, 1'b1, 1'b1};   // RESET

            // Fighter
            87:  data_out = {8'd249, 8'd0, 1'b0, 1'b1};
            88:  data_out = {8'd244, 8'd0, 1'b1, 1'b0};
            89:  data_out = {8'd248, 8'd0, 1'b0, 1'b1};
            90:  data_out = {8'd248, 8'd2, 1'b1, 1'b0};
            91:  data_out = {8'd244, 8'd10, 1'b1, 1'b0};
            92:  data_out = {8'd251, 8'd10, 1'b1, 1'b0};
            93:  data_out = {8'd253, 8'd6, 1'b1, 1'b0};
            94:  data_out = {8'd254, 8'd6, 1'b1, 1'b0};
            95:  data_out = {8'd254, 8'd11, 1'b1, 1'b0};
            96:  data_out = {8'd255, 8'd11, 1'b1, 1'b0};
            97:  data_out = {8'd255, 8'd13, 1'b1, 1'b0};
            98:  data_out = {8'd254, 8'd13, 1'b1, 1'b0};
            99:  data_out = {8'd254, 8'd18, 1'b1, 1'b0};
            100: data_out = {8'd253, 8'd18, 1'b1, 1'b0};
            101: data_out = {8'd251, 8'd14, 1'b1, 1'b0};
            102: data_out = {8'd244, 8'd14, 1'b1, 1'b0};
            103: data_out = {8'd248, 8'd20, 1'b1, 1'b0};
            104: data_out = {8'd248, 8'd22, 1'b1, 1'b0};
            105: data_out = {8'd249, 8'd22, 1'b1, 1'b0};
            106: data_out = {8'd244, 8'd22, 1'b1, 1'b0};
            107: data_out = {8'd246, 8'd22, 1'b0, 1'b1};
            108: data_out = {8'd246, 8'd21, 1'b1, 1'b0};
            109: data_out = {8'd238, 8'd14, 1'b1, 1'b0};
            110: data_out = {8'd237, 8'd14, 1'b1, 1'b0};
            111: data_out = {8'd236, 8'd13, 1'b1, 1'b0};
            112: data_out = {8'd232, 8'd13, 1'b1, 1'b0};
            113: data_out = {8'd230, 8'd12, 1'b1, 1'b0};
            114: data_out = {8'd232, 8'd11, 1'b1, 1'b0};
            115: data_out = {8'd236, 8'd11, 1'b1, 1'b0};
            116: data_out = {8'd237, 8'd10, 1'b1, 1'b0};
            117: data_out = {8'd238, 8'd10, 1'b1, 1'b0};
            118: data_out = {8'd246, 8'd1, 1'b1, 1'b0};
            119: data_out = {8'd246, 8'd0, 1'b1, 1'b0};
            120: data_out = {8'd184, 8'd168, 1'b1, 1'b1};   // RESET

            // Spy Plane
            121: data_out = {8'd243, 8'd0, 1'b0, 1'b1};
            122: data_out = {8'd245, 8'd7, 1'b1, 1'b0};
            123: data_out = {8'd247, 8'd7, 1'b1, 1'b0};
            124: data_out = {8'd247, 8'd8, 1'b1, 1'b0};
            125: data_out = {8'd245, 8'd8, 1'b1, 1'b0};
            126: data_out = {8'd246, 8'd14, 1'b1, 1'b0};
            127: data_out = {8'd252, 8'd14, 1'b1, 1'b0};
            128: data_out = {8'd254, 8'd10, 1'b1, 1'b0};
            129: data_out = {8'd255, 8'd14, 1'b1, 1'b0};
            130: data_out = {8'd255, 8'd15, 1'b1, 1'b0};
            131: data_out = {8'd254, 8'd19, 1'b1, 1'b0};
            132: data_out = {8'd252, 8'd15, 1'b1, 1'b0};
            133: data_out = {8'd246, 8'd15, 1'b1, 1'b0};
            134: data_out = {8'd245, 8'd21, 1'b1, 1'b0};
            135: data_out = {8'd247, 8'd21, 1'b1, 1'b0};
            136: data_out = {8'd247, 8'd22, 1'b1, 1'b0};
            137: data_out = {8'd245, 8'd22, 1'b1, 1'b0};
            138: data_out = {8'd243, 8'd29, 1'b1, 1'b0};
            139: data_out = {8'd242, 8'd29, 1'b1, 1'b0};
            140: data_out = {8'd240, 8'd22, 1'b1, 1'b0};
            141: data_out = {8'd236, 8'd22, 1'b1, 1'b0};
            142: data_out = {8'd236, 8'd21, 1'b1, 1'b0};
            143: data_out = {8'd240, 8'd21, 1'b1, 1'b0};
            144: data_out = {8'd238, 8'd16, 1'b1, 1'b0};
            145: data_out = {8'd236, 8'd16, 1'b1, 1'b0};
            146: data_out = {8'd235, 8'd15, 1'b1, 1'b0};
            147: data_out = {8'd228, 8'd15, 1'b1, 1'b0};
            148: data_out = {8'd228, 8'd14, 1'b1, 1'b0};
            149: data_out = {8'd235, 8'd14, 1'b1, 1'b0};
            150: data_out = {8'd236, 8'd13, 1'b1, 1'b0};
            151: data_out = {8'd238, 8'd13, 1'b1, 1'b0};
            152: data_out = {8'd240, 8'd8, 1'b1, 1'b0};
            153: data_out = {8'd236, 8'd8, 1'b1, 1'b0};
            154: data_out = {8'd236, 8'd7, 1'b1, 1'b0};
            155: data_out = {8'd240, 8'd7, 1'b1, 1'b0};
            156: data_out = {8'd242, 8'd0, 1'b1, 1'b0};
            157: data_out = {8'd243, 8'd0, 1'b1, 1'b0};
            158: data_out = {8'd184, 8'd168, 1'b1, 1'b1};   // RESET

            // AIM9X
            159: data_out = {8'd226, 8'd209, 1'b0, 1'b1};
            160: data_out = {8'd226, 8'd212, 1'b1, 1'b0};
            161: data_out = {8'd230, 8'd212, 1'b1, 1'b0};
            162: data_out = {8'd226, 8'd215, 1'b1, 1'b0};
            163: data_out = {8'd226, 8'd229, 1'b1, 1'b0};
            164: data_out = {8'd230, 8'd229, 1'b1, 1'b0};
            165: data_out = {8'd226, 8'd233, 1'b1, 1'b0};
            166: data_out = {8'd226, 8'd237, 1'b1, 1'b0};
            167: data_out = {8'd225, 8'd239, 1'b1, 1'b0};
            168: data_out = {8'd224, 8'd237, 1'b1, 1'b0};
            169: data_out = {8'd224, 8'd233, 1'b1, 1'b0};
            170: data_out = {8'd219, 8'd229, 1'b1, 1'b0};
            171: data_out = {8'd224, 8'd229, 1'b1, 1'b0};
            172: data_out = {8'd224, 8'd215, 1'b1, 1'b0};
            173: data_out = {8'd219, 8'd212, 1'b1, 1'b0};
            174: data_out = {8'd224, 8'd212, 1'b1, 1'b0};
            175: data_out = {8'd224, 8'd209, 1'b1, 1'b0};
            176: data_out = {8'd226, 8'd209, 1'b1, 1'b0};
            177: data_out = {8'd184, 8'd168, 1'b1, 1'b1};   // RESET

            // Patriot
            178: data_out = {8'd227, 8'd209, 1'b0, 1'b1};
            179: data_out = {8'd223, 8'd209, 1'b1, 1'b0};
            180: data_out = {8'd226, 8'd209, 1'b0, 1'b1};
            181: data_out = {8'd226, 8'd211, 1'b1, 1'b0};
            182: data_out = {8'd232, 8'd211, 1'b1, 1'b0};
            183: data_out = {8'd227, 8'd217, 1'b1, 1'b0};
            184: data_out = {8'd227, 8'd228, 1'b1, 1'b0};
            185: data_out = {8'd230, 8'd228, 1'b1, 1'b0};
            186: data_out = {8'd227, 8'd231, 1'b1, 1'b0};
            187: data_out = {8'd226, 8'd236, 1'b1, 1'b0};
            188: data_out = {8'd225, 8'd240, 1'b1, 1'b0};
            189: data_out = {8'd224, 8'd236, 1'b1, 1'b0};
            190: data_out = {8'd223, 8'd231, 1'b1, 1'b0};
            191: data_out = {8'd220, 8'd228, 1'b1, 1'b0};
            192: data_out = {8'd223, 8'd228, 1'b1, 1'b0};
            193: data_out = {8'd223, 8'd217, 1'b1, 1'b0};
            194: data_out = {8'd218, 8'd211, 1'b1, 1'b0};
            195: data_out = {8'd224, 8'd211, 1'b1, 1'b0};
            196: data_out = {8'd224, 8'd209, 1'b1, 1'b0};
            197: data_out = {8'd184, 8'd168, 1'b1, 1'b1};   // RESET

            // Interceptor
            198: data_out = {8'd233, 8'd210, 1'b0, 1'b1};
            199: data_out = {8'd230, 8'd213, 1'b1, 1'b0};
            200: data_out = {8'd230, 8'd218, 1'b1, 1'b0};
            201: data_out = {8'd241, 8'd218, 1'b1, 1'b0};
            202: data_out = {8'd241, 8'd221, 1'b1, 1'b0};
            203: data_out = {8'd231, 8'd227, 1'b1, 1'b0};
            204: data_out = {8'd229, 8'd235, 1'b1, 1'b0};
            205: data_out = {8'd227, 8'd242, 1'b1, 1'b0};
            206: data_out = {8'd225, 8'd235, 1'b1, 1'b0};
            207: data_out = {8'd223, 8'd227, 1'b1, 1'b0};
            208: data_out = {8'd211, 8'd221, 1'b1, 1'b0};
            209: data_out = {8'd211, 8'd218, 1'b1, 1'b0};
            210: data_out = {8'd223, 8'd218, 1'b1, 1'b0};
            211: data_out = {8'd223, 8'd213, 1'b1, 1'b0};
            212: data_out = {8'd220, 8'd210, 1'b1, 1'b0};
            213: data_out = {8'd233, 8'd210, 1'b1, 1'b0};
            214: data_out = {8'd184, 8'd168, 1'b1, 1'b1};   // RESET

            // Explosion
            215: data_out = {8'd239, 8'd0, 1'b0, 1'b1};
            216: data_out = {8'd244, 8'd9, 1'b1, 1'b0};
            217: data_out = {8'd251, 8'd2, 1'b1, 1'b0};
            218: data_out = {8'd247, 8'd12, 1'b1, 1'b0};
            219: data_out = {8'd255, 8'd16, 1'b1, 1'b0};
            220: data_out = {8'd248, 8'd22, 1'b1, 1'b0};
            221: data_out = {8'd249, 8'd25, 1'b1, 1'b0};
            222: data_out = {8'd254, 8'd30, 1'b1, 1'b0};
            223: data_out = {8'd247, 8'd27, 1'b1, 1'b0};
            224: data_out = {8'd246, 8'd26, 1'b1, 1'b0};
            225: data_out = {8'd240, 8'd32, 1'b1, 1'b0};
            226: data_out = {8'd238, 8'd30, 1'b1, 1'b0};
            227: data_out = {8'd236, 8'd23, 1'b1, 1'b0};
            228: data_out = {8'd225, 8'd29, 1'b1, 1'b0};
            229: data_out = {8'd233, 8'd20, 1'b1, 1'b0};
            230: data_out = {8'd223, 8'd16, 1'b1, 1'b0};
            231: data_out = {8'd230, 8'd12, 1'b1, 1'b0};
            232: data_out = {8'd223, 8'd1, 1'b1, 1'b0};
            233: data_out = {8'd233, 8'd9, 1'b1, 1'b0};
            234: data_out = {8'd239, 8'd0, 1'b1, 1'b0};
            235: data_out = {8'd239, 8'd0, 1'b1, 1'b1};   // RESET

            // Nuke
            236: data_out = {8'd235, 8'd0, 1'b0, 1'b1};
            237: data_out = {8'd223, 8'd7, 1'b1, 1'b0};
            238: data_out = {8'd221, 8'd13, 1'b1, 1'b0};
            239: data_out = {8'd222, 8'd17, 1'b1, 1'b0};
            240: data_out = {8'd220, 8'd19, 1'b1, 1'b0};
            241: data_out = {8'd221, 8'd21, 1'b1, 1'b0};
            242: data_out = {8'd219, 8'd20, 1'b1, 1'b0};
            243: data_out = {8'd216, 8'd21, 1'b1, 1'b0};
            244: data_out = {8'd219, 8'd20, 1'b1, 1'b0};
            245: data_out = {8'd220, 8'd21, 1'b1, 1'b0};
            246: data_out = {8'd232, 8'd23, 1'b1, 1'b0};
            247: data_out = {8'd238, 8'd23, 1'b1, 1'b0};
            248: data_out = {8'd239, 8'd24, 1'b1, 1'b0};
            249: data_out = {8'd255, 8'd24, 1'b1, 1'b0};
            250: data_out = {8'd242, 8'd26, 1'b1, 1'b0};
            251: data_out = {8'd241, 8'd27, 1'b1, 1'b0};
            252: data_out = {8'd195, 8'd28, 1'b1, 1'b0};
            253: data_out = {8'd184, 8'd27, 1'b1, 1'b0};
            254: data_out = {8'd185, 8'd25, 1'b1, 1'b0};
            255: data_out = {8'd190, 8'd24, 1'b1, 1'b0};
            256: data_out = {8'd205, 8'd23, 1'b1, 1'b0};
            257: data_out = {8'd239, 8'd24, 1'b0, 1'b1};
            258: data_out = {8'd241, 8'd27, 1'b1, 1'b0};
            259: data_out = {8'd244, 8'd33, 1'b1, 1'b0};
            260: data_out = {8'd244, 8'd36, 1'b1, 1'b0};
            261: data_out = {8'd243, 8'd37, 1'b1, 1'b0};
            262: data_out = {8'd245, 8'd40, 1'b1, 1'b0};
            263: data_out = {8'd243, 8'd41, 1'b1, 1'b0};
            264: data_out = {8'd241, 8'd42, 1'b1, 1'b0};
            265: data_out = {8'd239, 8'd44, 1'b1, 1'b0};
            266: data_out = {8'd236, 8'd49, 1'b1, 1'b0};
            267: data_out = {8'd234, 8'd47, 1'b1, 1'b0};
            268: data_out = {8'd228, 8'd50, 1'b1, 1'b0};
            269: data_out = {8'd222, 8'd50, 1'b1, 1'b0};
            270: data_out = {8'd215, 8'd49, 1'b1, 1'b0};
            271: data_out = {8'd210, 8'd45, 1'b1, 1'b0};
            272: data_out = {8'd205, 8'd46, 1'b1, 1'b0};
            273: data_out = {8'd196, 8'd42, 1'b1, 1'b0};
            274: data_out = {8'd195, 8'd37, 1'b1, 1'b0};
            275: data_out = {8'd193, 8'd36, 1'b1, 1'b0};
            276: data_out = {8'd194, 8'd35, 1'b1, 1'b0};
            277: data_out = {8'd192, 8'd31, 1'b1, 1'b0};
            278: data_out = {8'd192, 8'd29, 1'b1, 1'b0};
            279: data_out = {8'd195, 8'd28, 1'b1, 1'b0};
            280: data_out = {8'd205, 8'd23, 1'b1, 1'b0};
            281: data_out = {8'd209, 8'd22, 1'b1, 1'b0};
            282: data_out = {8'd214, 8'd22, 1'b1, 1'b0};
            283: data_out = {8'd216, 8'd21, 1'b1, 1'b0};
            284: data_out = {8'd215, 8'd9, 1'b1, 1'b0};
            285: data_out = {8'd212, 8'd8, 1'b1, 1'b0};
            286: data_out = {8'd214, 8'd7, 1'b1, 1'b0};
            287: data_out = {8'd212, 8'd7, 1'b1, 1'b0};
            288: data_out = {8'd210, 8'd5, 1'b1, 1'b0};
            289: data_out = {8'd200, 8'd0, 1'b1, 1'b0};
            290: data_out = {8'd240, 8'd0, 1'b1, 1'b0};
            291: data_out = {8'd184, 8'd168, 1'b1, 1'b1};   // RESET






            //  NEW YORK    OLD

            292: data_out = {8'd0, 8'd0, 1'b0, 1'b1};
            293: data_out = {8'd0, 8'd4, 1'b1, 1'b0};
            294: data_out = {8'd3, 8'd0, 1'b1, 1'b0};
            295: data_out = {8'd3, 8'd4, 1'b1, 1'b0};
            296: data_out = {8'd8, 8'd4, 1'b0, 1'b1};
            297: data_out = {8'd5, 8'd4, 1'b1, 1'b0};
            298: data_out = {8'd5, 8'd2, 1'b1, 1'b0};
            299: data_out = {8'd7, 8'd2, 1'b1, 1'b0};
            300: data_out = {8'd5, 8'd2, 1'b0, 1'b1};
            301: data_out = {8'd5, 8'd0, 1'b1, 1'b0};
            302: data_out = {8'd8, 8'd0, 1'b1, 1'b0};
            303: data_out = {8'd10, 8'd4, 1'b0, 1'b1};
            304: data_out = {8'd10, 8'd0, 1'b1, 1'b0};
            305: data_out = {8'd12, 8'd2, 1'b1, 1'b0};
            306: data_out = {8'd14, 8'd0, 1'b1, 1'b0};
            307: data_out = {8'd14, 8'd4, 1'b1, 1'b0};
            308: data_out = {8'd18, 8'd4, 1'b0, 1'b1};
            309: data_out = {8'd20, 8'd2, 1'b1, 1'b0};
            310: data_out = {8'd20, 8'd0, 1'b1, 1'b0};
            311: data_out = {8'd20, 8'd2, 1'b0, 1'b1};
            312: data_out = {8'd22, 8'd4, 1'b1, 1'b0};
            313: data_out = {8'd24, 8'd1, 1'b0, 1'b1};
            314: data_out = {8'd25, 8'd0, 1'b1, 1'b0};
            315: data_out = {8'd26, 8'd0, 1'b1, 1'b0};
            316: data_out = {8'd27, 8'd1, 1'b1, 1'b0};
            317: data_out = {8'd27, 8'd3, 1'b1, 1'b0};
            318: data_out = {8'd26, 8'd4, 1'b1, 1'b0};
            319: data_out = {8'd25, 8'd4, 1'b1, 1'b0};
            320: data_out = {8'd24, 8'd3, 1'b1, 1'b0};
            321: data_out = {8'd24, 8'd1, 1'b1, 1'b0};
            322: data_out = {8'd29, 8'd0, 1'b0, 1'b1};
            323: data_out = {8'd29, 8'd2, 1'b1, 1'b0};
            324: data_out = {8'd32, 8'd0, 1'b1, 1'b0};
            325: data_out = {8'd29, 8'd2, 1'b0, 1'b1};
            326: data_out = {8'd31, 8'd2, 1'b1, 1'b0};
            327: data_out = {8'd32, 8'd3, 1'b1, 1'b0};
            328: data_out = {8'd31, 8'd4, 1'b1, 1'b0};
            329: data_out = {8'd29, 8'd4, 1'b1, 1'b0};
            330: data_out = {8'd29, 8'd2, 1'b1, 1'b0};
            331: data_out = {8'd34, 8'd0, 1'b0, 1'b1};
            332: data_out = {8'd34, 8'd4, 1'b1, 1'b0};
            333: data_out = {8'd34, 8'd2, 1'b0, 1'b1};
            334: data_out = {8'd37, 8'd4, 1'b1, 1'b0};
            335: data_out = {8'd34, 8'd2, 1'b0, 1'b1};
            336: data_out = {8'd37, 8'd0, 1'b1, 1'b0};
            337: data_out = {8'd8, 8'd8, 1'b0, 1'b1};
            338: data_out = {8'd30, 8'd22, 1'b1, 1'b0};
            339: data_out = {8'd3, 8'd22, 1'b1, 1'b0};
            340: data_out = {8'd24, 8'd8, 1'b1, 1'b0};
            341: data_out = {8'd16, 8'd30, 1'b1, 1'b0};
            342: data_out = {8'd8, 8'd8, 1'b1, 1'b0};
            343: data_out = {8'd184, 8'd168, 1'b1, 1'b1};   // RESET


            // MAPA USA NOWA
            349: data_out = {8'd0, 8'd58, 1'b1, 1'b0};
            350: data_out = {8'd6, 8'd64, 1'b1, 1'b0};
            351: data_out = {8'd9, 8'd59, 1'b1, 1'b0};
            352: data_out = {8'd13, 8'd60, 1'b1, 1'b0};
            353: data_out = {8'd30, 8'd60, 1'b1, 1'b0};
            354: data_out = {8'd42, 8'd54, 1'b1, 1'b0};
            355: data_out = {8'd53, 8'd59, 1'b1, 1'b0};
            356: data_out = {8'd60, 8'd59, 1'b1, 1'b0};
            357: data_out = {8'd66, 8'd54, 1'b1, 1'b0};
            358: data_out = {8'd72, 8'd51, 1'b1, 1'b0};
            359: data_out = {8'd80, 8'd35, 1'b1, 1'b0};
            360: data_out = {8'd77, 8'd29, 1'b1, 1'b0};
            361: data_out = {8'd82, 8'd24, 1'b1, 1'b0};
            362: data_out = {8'd90, 8'd19, 1'b1, 1'b0};
            363: data_out = {8'd93, 8'd16, 1'b1, 1'b0};
            364: data_out = {8'd100, 8'd9, 1'b1, 1'b0};
            365: data_out = {8'd102, 8'd5, 1'b1, 1'b0};
            366: data_out = {8'd109, 8'd11, 1'b1, 1'b0};
            367: data_out = {8'd111, 8'd19, 1'b1, 1'b0};
            368: data_out = {8'd110, 8'd30, 1'b1, 1'b0};
            369: data_out = {8'd100, 8'd42, 1'b1, 1'b0};
            370: data_out = {8'd99, 8'd48, 1'b1, 1'b0};
            371: data_out = {8'd88, 8'd59, 1'b1, 1'b0};
            372: data_out = {8'd83, 8'd72, 1'b1, 1'b0};
            373: data_out = {8'd82, 8'd80, 1'b1, 1'b0};
            374: data_out = {8'd87, 8'd89, 1'b1, 1'b0};
            375: data_out = {8'd104, 8'd105, 1'b1, 1'b0};
            376: data_out = {8'd110, 8'd117, 1'b1, 1'b0};
            377: data_out = {8'd129, 8'd129, 1'b1, 1'b0};
            378: data_out = {8'd128, 8'd137, 1'b1, 1'b0};
            379: data_out = {8'd136, 8'd138, 1'b1, 1'b0};
            380: data_out = {8'd136, 8'd146, 1'b1, 1'b0};
            381: data_out = {8'd130, 8'd152, 1'b1, 1'b0};
            382: data_out = {8'd126, 8'd157, 1'b1, 1'b0};
            383: data_out = {8'd124, 8'd165, 1'b1, 1'b0};
            384: data_out = {8'd115, 8'd170, 1'b1, 1'b0};
            385: data_out = {8'd114, 8'd174, 1'b1, 1'b0};
            386: data_out = {8'd121, 8'd171, 1'b1, 1'b0};
            387: data_out = {8'd119, 8'd179, 1'b1, 1'b0};
            388: data_out = {8'd125, 8'd188, 1'b1, 1'b0};
            389: data_out = {8'd124, 8'd174, 1'b1, 1'b0};
            390: data_out = {8'd134, 8'd169, 1'b1, 1'b0};
            391: data_out = {8'd133, 8'd163, 1'b1, 1'b0};
            392: data_out = {8'd134, 8'd169, 1'b1, 1'b0};
            393: data_out = {8'd136, 8'd173, 1'b1, 1'b0};
            394: data_out = {8'd134, 8'd179, 1'b1, 1'b0};
            395: data_out = {8'd125, 8'd188, 1'b1, 1'b0};
            396: data_out = {8'd128, 8'd190, 1'b1, 1'b0};
            397: data_out = {8'd131, 8'd192, 1'b1, 1'b0};
            398: data_out = {8'd134, 8'd188, 1'b1, 1'b0};
            399: data_out = {8'd131, 8'd192, 1'b1, 1'b0};
            400: data_out = {8'd135, 8'd194, 1'b1, 1'b0};
            401: data_out = {8'd128, 8'd205, 1'b1, 1'b0};
            402: data_out = {8'd133, 8'd211, 1'b1, 1'b0};
            403: data_out = {8'd140, 8'd208, 1'b1, 1'b0};
            404: data_out = {8'd140, 8'd203, 1'b1, 1'b0};
            405: data_out = {8'd138, 8'd202, 1'b1, 1'b0};
            406: data_out = {8'd142, 8'd199, 1'b1, 1'b0};
            407: data_out = {8'd140, 8'd208, 1'b0, 1'b1};
            408: data_out = {8'd143, 8'd212, 1'b1, 1'b0};
            409: data_out = {8'd162, 8'd217, 1'b1, 1'b0};
            410: data_out = {8'd163, 8'd214, 1'b1, 1'b0};
            411: data_out = {8'd162, 8'd217, 1'b0, 1'b1};
            412: data_out = {8'd165, 8'd224, 1'b1, 1'b0};
            413: data_out = {8'd170, 8'd221, 1'b1, 1'b0};
            414: data_out = {8'd177, 8'd224, 1'b1, 1'b0};
            415: data_out = {8'd166, 8'd230, 1'b1, 1'b0};
            416: data_out = {8'd166, 8'd236, 1'b1, 1'b0};
            417: data_out = {8'd169, 8'd249, 1'b1, 1'b0};
            418: data_out = {8'd174, 8'd251, 1'b1, 1'b0};
            419: data_out = {8'd178, 8'd255, 1'b1, 1'b0};
            420: data_out = {8'd13, 8'd60, 1'b0, 1'b1};
            421: data_out = {8'd10, 8'd66, 1'b1, 1'b0};
            422: data_out = {8'd12, 8'd69, 1'b1, 1'b0};
            423: data_out = {8'd42, 8'd71, 1'b1, 1'b0};
            424: data_out = {8'd78, 8'd66, 1'b1, 1'b0};
            425: data_out = {8'd77, 8'd72, 1'b1, 1'b0};
            426: data_out = {8'd83, 8'd72, 1'b1, 1'b0};
            427: data_out = {8'd42, 8'd71, 1'b0, 1'b1};
            428: data_out = {8'd38, 8'd92, 1'b1, 1'b0};
            429: data_out = {8'd28, 8'd117, 1'b1, 1'b0};
            430: data_out = {8'd0, 8'd115, 1'b1, 1'b0};
            431: data_out = {8'd28, 8'd117, 1'b0, 1'b1};
            432: data_out = {8'd44, 8'd119, 1'b1, 1'b0};
            433: data_out = {8'd54, 8'd119, 1'b1, 1'b0};
            434: data_out = {8'd65, 8'd108, 1'b1, 1'b0};
            435: data_out = {8'd69, 8'd106, 1'b1, 1'b0};
            436: data_out = {8'd87, 8'd89, 1'b1, 1'b0};
            437: data_out = {8'd54, 8'd119, 1'b0, 1'b1};
            438: data_out = {8'd70, 8'd126, 1'b1, 1'b0};
            439: data_out = {8'd90, 8'd123, 1'b1, 1'b0};
            440: data_out = {8'd96, 8'd124, 1'b1, 1'b0};
            441: data_out = {8'd110, 8'd117, 1'b1, 1'b0};
            442: data_out = {8'd44, 8'd119, 1'b0, 1'b1};
            443: data_out = {8'd43, 8'd124, 1'b1, 1'b0};
            444: data_out = {8'd50, 8'd125, 1'b1, 1'b0};
            445: data_out = {8'd71, 8'd141, 1'b1, 1'b0};
            446: data_out = {8'd130, 8'd152, 1'b1, 1'b0};
            447: data_out = {8'd71, 8'd141, 1'b0, 1'b1};
            448: data_out = {8'd50, 8'd139, 1'b1, 1'b0};
            449: data_out = {8'd0, 8'd137, 1'b1, 1'b0};
            450: data_out = {8'd0, 8'd148, 1'b1, 1'b0};
            451: data_out = {8'd14, 8'd155, 1'b1, 1'b0};
            452: data_out = {8'd20, 8'd154, 1'b1, 1'b0};
            453: data_out = {8'd22, 8'd165, 1'b1, 1'b0};
            454: data_out = {8'd30, 8'd165, 1'b1, 1'b0};
            455: data_out = {8'd35, 8'd169, 1'b1, 1'b0};
            456: data_out = {8'd39, 8'd163, 1'b1, 1'b0};
            457: data_out = {8'd56, 8'd165, 1'b1, 1'b0};
            458: data_out = {8'd63, 8'd153, 1'b1, 1'b0};
            459: data_out = {8'd49, 8'd140, 1'b1, 1'b0};
            460: data_out = {8'd63, 8'd153, 1'b0, 1'b1};
            461: data_out = {8'd74, 8'd149, 1'b1, 1'b0};
            462: data_out = {8'd82, 8'd155, 1'b1, 1'b0};
            463: data_out = {8'd85, 8'd165, 1'b1, 1'b0};
            464: data_out = {8'd101, 8'd180, 1'b1, 1'b0};
            465: data_out = {8'd107, 8'd182, 1'b1, 1'b0};
            466: data_out = {8'd113, 8'd174, 1'b1, 1'b0};
            467: data_out = {8'd56, 8'd165, 1'b0, 1'b1};
            468: data_out = {8'd75, 8'd183, 1'b1, 1'b0};
            469: data_out = {8'd91, 8'd182, 1'b1, 1'b0};
            470: data_out = {8'd104, 8'd186, 1'b1, 1'b0};
            471: data_out = {8'd107, 8'd182, 1'b1, 1'b0};
            472: data_out = {8'd104, 8'd186, 1'b0, 1'b1};
            473: data_out = {8'd128, 8'd190, 1'b1, 1'b0};
            474: data_out = {8'd30, 8'd165, 1'b0, 1'b1};
            475: data_out = {8'd25, 8'd185, 1'b1, 1'b0};
            476: data_out = {8'd26, 8'd196, 1'b1, 1'b0};
            477: data_out = {8'd23, 8'd199, 1'b1, 1'b0};
            478: data_out = {8'd6, 8'd199, 1'b1, 1'b0};
            479: data_out = {8'd0, 8'd195, 1'b1, 1'b0};
            480: data_out = {8'd0, 8'd247, 1'b0, 1'b1};
            481: data_out = {8'd13, 8'd252, 1'b1, 1'b0};
            482: data_out = {8'd26, 8'd251, 1'b1, 1'b0};
            483: data_out = {8'd26, 8'd253, 1'b1, 1'b0};
            484: data_out = {8'd47, 8'd249, 1'b1, 1'b0};
            485: data_out = {8'd49, 8'd255, 1'b1, 1'b0}; 
            486: data_out = {8'd67, 8'd248, 1'b1, 1'b0};
            487: data_out = {8'd69, 8'd239, 1'b1, 1'b0};
            488: data_out = {8'd55, 8'd245, 1'b1, 1'b0};
            489: data_out = {8'd51, 8'd222, 1'b1, 1'b0};
            490: data_out = {8'd46, 8'd215, 1'b1, 1'b0};
            491: data_out = {8'd45, 8'd213, 1'b1, 1'b0};
            492: data_out = {8'd39, 8'd201, 1'b1, 1'b0};
            493: data_out = {8'd45, 8'd213, 1'b0, 1'b1};
            494: data_out = {8'd53, 8'd211, 1'b1, 1'b0};
            495: data_out = {8'd68, 8'd217, 1'b1, 1'b0};
            496: data_out = {8'd81, 8'd221, 1'b1, 1'b0};
            497: data_out = {8'd85, 8'd222, 1'b1, 1'b0};
            498: data_out = {8'd76, 8'd209, 1'b1, 1'b0};
            499: data_out = {8'd85, 8'd222, 1'b0, 1'b1};
            500: data_out = {8'd90, 8'd230, 1'b1, 1'b0};
            501: data_out = {8'd104, 8'd228, 1'b1, 1'b0};
            502: data_out = {8'd109, 8'd237, 1'b1, 1'b0};
            503: data_out = {8'd107, 8'd241, 1'b1, 1'b0};
            504: data_out = {8'd117, 8'd253, 1'b1, 1'b0};
            505: data_out = {8'd133, 8'd255, 1'b1, 1'b0};
            506: data_out = {8'd39, 8'd201, 1'b0, 1'b1};
            507: data_out = {8'd23, 8'd200, 1'b1, 1'b0};
            508: data_out = {8'd39, 8'd201, 1'b0, 1'b1};
            509: data_out = {8'd53, 8'd198, 1'b1, 1'b0};
            510: data_out = {8'd69, 8'd207, 1'b1, 1'b0};
            511: data_out = {8'd75, 8'd183, 1'b1, 1'b0};
            512: data_out = {8'd69, 8'd207, 1'b0, 1'b1};
            513: data_out = {8'd76, 8'd210, 1'b1, 1'b0};
            514: data_out = {8'd124, 8'd216, 1'b1, 1'b0};
            515: data_out = {8'd133, 8'd211, 1'b1, 1'b0};
            516: data_out = {8'd184, 8'd168, 1'b1, 1'b1};   // RESET


        //   CURSOR NEW
            517:  data_out = {8'd22, 8'd50, 1'b0, 1'b1};
            518:  data_out = {8'd42, 8'd50, 1'b1, 1'b0};
            519:  data_out = {8'd32, 8'd40, 1'b0, 1'b1};
            520:  data_out = {8'd32, 8'd60, 1'b1, 1'b0};
            521:  data_out = {8'd22, 8'd50, 1'b1, 1'b1};         // RESET





        //  NEW YORK MAP
        522: data_out = {8'd8, 8'd8, 1'b0, 1'b1};
        523: data_out = {8'd30, 8'd22, 1'b1, 1'b0};
        524: data_out = {8'd3, 8'd22, 1'b1, 1'b0};
        525: data_out = {8'd24, 8'd8, 1'b1, 1'b0};
        526: data_out = {8'd16, 8'd30, 1'b1, 1'b0};
        527: data_out = {8'd8, 8'd8, 1'b1, 1'b0};
        528: data_out = {8'd33, 8'd11, 1'b0, 1'b1};
        529: data_out = {8'd33, 8'd26, 1'b1, 1'b0};
        530: data_out = {8'd42, 8'd11, 1'b1, 1'b0};
        531: data_out = {8'd42, 8'd26, 1'b1, 1'b0};
        532: data_out = {8'd46, 8'd26, 1'b0, 1'b1};
        533: data_out = {8'd50, 8'd19, 1'b1, 1'b0};
        534: data_out = {8'd50, 8'd11, 1'b1, 1'b0};
        535: data_out = {8'd50, 8'd19, 1'b0, 1'b1};
        536: data_out = {8'd54, 8'd26, 1'b1, 1'b0};
        537: data_out = {8'd0, 8'd0, 1'b1, 1'b1}; // RESET







            

            default: data_out = {8'd0, 8'd0, 1'b1, 1'b1};
        endcase
    end

endmodule
