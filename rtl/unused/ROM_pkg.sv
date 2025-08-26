//////////////////////////////////////////////////////////////////////////////
/*
 Module name:   ROM_pkg
 Author:        kszdom
 Description:  module used for holding all constants related to images in ROM memory
 */
//////////////////////////////////////////////////////////////////////////////
package ROM_pkg;

    // START OF ADRESSES FOR ROM IMAGES
    localparam ADR_MAP_START = 0;



    localparam ADR_FRAME_START = 42;
    localparam FRAME_MID_X = 128;
    localparam FRAME_MID_Y = FRAME_MID_X;

    //      CURSOR
    localparam ADR_CURSOR_START = 48;
    localparam CURSOR_MID_X = 8'd22;   //draw cursor at there coordinates
    localparam CURSOR_MID_Y = 8'd50;   //draw cursor at there coordinates


    //      TESTPLANE
    localparam ADR_TESTPLANE_START = 54;
    localparam TESTPLANE_MID_X = 8'd247;   //draw cursor at there coordinates
    localparam TESTPLANE_MID_Y = 8'd16;   //draw cursor at there coordinates



    // HEIGHT FOR ENEMIES OR BASE POSITIONS - for enemies those are constatnts
    localparam Y_ENEMY1_BASE1 = 8'd100;
    localparam Y_ENEMY2_BASE2 = 8'd150;
    localparam Y_ENEMY3_BASE3 = 8'd200;

    localparam X_BASE1 = 8'd50;
    localparam X_BASE2 = 8'd40;
    localparam X_BASE3 = 8'd60;

    // starting place for enemies - somewhere in the ocean to the right
    localparam X_ENEMY1_START = 240; //255 is max 
    localparam X_ENEMY1_END = X_BASE1; //enemy ends where the base is 
    




endpackage
