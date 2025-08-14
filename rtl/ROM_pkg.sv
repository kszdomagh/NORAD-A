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



    localparam ADR_CURSOR_START = 48;
    localparam CURSOR_MID_X = 22;   //draw cursor at there coordinates
    localparam CURSOR_MID_Y = 50;   //draw cursor at there coordinates




endpackage
