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
            235: data_out = {8'd184, 8'd168, 1'b1, 1'b1};   // RESET

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

            default: data_out = '0;
        endcase
    end

endmodule
