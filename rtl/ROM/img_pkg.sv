//////////////////////////////////////////////////////////////////////////////
/*
 Module name:   ROM_pkg
 Author:        kszdom
 Description:  module used for holding all constants related to images in ROM memory
 */
//////////////////////////////////////////////////////////////////////////////
package img_pkg;

    // START OF ADRESSES FOR ROM IMAGES
    localparam ADR_MAP_START = 0;



    localparam ADR_FRAME_START = 42;
    localparam FRAME_MID_X = 128;
    localparam FRAME_MID_Y = FRAME_MID_X;

    //      CURSOR
    localparam ADR_CURSOR_START = 48;
    localparam CURSOR_MID_X = 8'd22;   //draw cursor at there coordinates
    localparam CURSOR_MID_Y = 8'd50;   //draw cursor at there coordinates




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











    // HEIGHT FOR ENEMIES OR BASE POSITIONS - for enemies those are constatnts
    localparam Y_ENEMY1_BASE1 = 8'd100;
    localparam Y_ENEMY2_BASE2 = 8'd150;
    localparam Y_ENEMY3_BASE3 = 8'd200;

    localparam X_BASE1 = 8'd50;
    localparam X_BASE2 = 8'd40;
    localparam X_BASE3 = 8'd60;

    // starting place for enemies - somewhere in the ocean to the right
    localparam X_ENEMY_START = 8'd235; //255 is max 
    localparam X_ENEMY_END = 8'd20; 
    





endpackage
