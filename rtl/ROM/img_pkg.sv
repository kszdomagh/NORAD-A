//////////////////////////////////////////////////////////////////////////////
/*
 Module name:   ROM_pkg
 Author:        kszdom
 Description:  module used for holding all constants related to images in ROM memory
 */
//////////////////////////////////////////////////////////////////////////////
package img_pkg;

    // START OF ADRESSES FOR ROM IMAGES
    localparam ADR_MAP_START = 349;

    //          FRAME 
    localparam ADR_FRAME_START = 42;
    localparam FRAME_MID_X = 128;
    localparam FRAME_MID_Y = FRAME_MID_X;

    //      CURSOR
    localparam ADR_CURSOR_START = 517;
    localparam CURSOR_MID_X = 8'd32;   //draw cursor at there coordinates
    localparam CURSOR_MID_Y = 8'd40;   //draw cursor at there coordinates

    localparam CURSORMAX = 8'd235;
    localparam CURSORMIN = 8'd15;




        localparam ENEMY_MID_X = 8'd239;
        localparam ENEMY_MID_Y = 8'd16;


/*///////////////////////////////////////////////////////////////////////////////////////////////
            ENEMIES
///////////////////////////////////////////////////////////////////////////////////////////////*/

        //      BOMBER
        localparam ADR_BOMBER_START      = 54;
        localparam BOMBER_MID_X          = 8'd239;   //draw cursor at these coordinates
        localparam BOMBER_MID_Y          = 8'd239;    //draw cursor at these coordinates

        //      ICBM
        localparam ADR_ICBM_START        = 69;
        localparam ICBM_MID_X            = 8'd239;   
        localparam ICBM_MID_Y            = 8'd16;    

        //      FIGHTER
        localparam ADR_FIGHTER_START     = 87;
        localparam FIGHTER_MID_X         = 8'd239;   
        localparam FIGHTER_MID_Y         = 8'd16;    

        //      SPY PLANE
        localparam ADR_SPYPLANE_START    = 121;
        localparam SPYPLANE_MID_X        = 8'd239;   
        localparam SPYPLANE_MID_Y        = 8'd16;    




/*///////////////////////////////////////////////////////////////////////////////////////////////
            FRIENDLY
///////////////////////////////////////////////////////////////////////////////////////////////*/

        //      AIM9X
        localparam ADR_AIM9X_START      = 159;
        localparam AIM9X_MID_X          = 8'd226;   
        localparam AIM9X_MID_Y          = 8'd226;   

        //      PATRIOT
        localparam ADR_PATRIOT_START     = 178;
        localparam PATRIOT_MID_X         = 8'd226;   
        localparam PATRIOT_MID_Y         = 8'd226;   

        //      INTERCEPTOR
        localparam ADR_INTERCEPTOR_START = 198;
        localparam INTERCEPTOR_MID_X     = 8'd226;   
        localparam INTERCEPTOR_MID_Y     = 8'd226;   





/*///////////////////////////////////////////////////////////////////////////////////////////////
            EFFECTS
///////////////////////////////////////////////////////////////////////////////////////////////*/

        //      EXPLOSION
        localparam ADR_EXPLOSION_START   = 215;
        localparam EXPLOSION_MID_X       = 8'd239;   
        localparam EXPLOSION_MID_Y       = 8'd16;    

        //      NUKE
        localparam ADR_NUKE_START        = 236;
        localparam NUKE_MID_X            = 8'd239;   
        localparam NUKE_MID_Y            = 8'd16;    


/*///////////////////////////////////////////////////////////////////////////////////////////////
            FRIENDLY CITIES / BASES
///////////////////////////////////////////////////////////////////////////////////////////////*/

        //      NEW YORK = BASE1
        localparam ADR_BASE1_START        = 522;
        localparam BASE1_MID_X            = 8'd34;
        localparam BASE1_MID_Y            = 8'd19;


        //      NEW YORK = BASE2
        localparam ADR_BASE2_START        = 522;
        localparam BASE2_MID_X            = 8'd16;
        localparam BASE2_MID_Y            = 8'd20;


        //      NEW YORK = BASE3
        localparam ADR_BASE3_START        = 522;
        localparam BASE3_MID_X            = 8'd16;
        localparam BASE3_MID_Y            = 8'd20;


    // HEIGHT FOR ENEMIES OR BASE POSITIONS - for enemies those are constatnts
    localparam X_BASE1 = 8'd100;
    localparam Y_ENEMY1_BASE1 = 8'd35;

    localparam X_BASE2 = 8'd113;
    localparam Y_ENEMY2_BASE2 = 8'd135;

    localparam X_BASE3 = 8'd120;
    localparam Y_ENEMY3_BASE3 = 8'd192;


    // starting place for enemies - somewhere in the ocean to the right
    localparam X_ENEMY_START = 8'd235; //255 is max 
    localparam X_ENEMY_END = 8'd20; 
    





endpackage
