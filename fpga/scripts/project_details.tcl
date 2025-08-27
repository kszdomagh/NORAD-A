# Copyright (C) 2025  AGH University of Science and Technology
# MTM UEC2
# Author: Piotr Kaczmarczyk
#
# Description:
# Project detiles required for generate_bitstream.tcl
# Make sure that project_name, top_module and target are correct.
# Provide paths to all the files required for synthesis and implementation.
# Depending on the file type, it should be added in the corresponding section.
# If the project does not use files of some type, leave the corresponding section commented out.

#-----------------------------------------------------#
#                   Project details                   #
#-----------------------------------------------------#
# Project name                                  -- EDIT
set project_name norad_a_oscilo_game

# Top module name                               -- EDIT
set top_module top_basys3

# FPGA device
set target xc7a35tcpg236-1

#-----------------------------------------------------#
#                    Design sources                   #
#-----------------------------------------------------#
# Specify .xdc files location                   -- EDIT
set xdc_files {
    constraints/top_basys3.xdc
    constraints/clk_wiz_0.xdc
    constraints/clk_wiz_0_ooc.xdc
    constraints/clk_wiz_0_board.xdc
}

# Specify SystemVerilog design files location   -- EDIT
set sv_files {

    ../rtl/vector_display/vector_pkg.sv

    ../rtl/ROM/img_pkg.sv
    ../rtl/ROM/img_rom.sv
    ../rtl/ROM/end_screen_rom.sv
    ../rtl/ROM/start_screen_rom.sv
    ../rtl/ROM/mtm_rom.sv

    ../rtl/missile/missile_main.sv
    ../rtl/missile/missile_top.sv



    ../rtl/vector_display/bresenham.sv
    ../rtl/vector_display/top_vector_display.sv
    ../rtl/vector_display/valid_buf.sv
    ../rtl/vector_display/vector_manage.sv


    ../rtl/control_units/enemy_control.sv
    ../rtl/control_units/timer_cluster.sv
    ../rtl/control_units/timer.sv
    ../rtl/control_units/random_enemy_adr.sv
    ../rtl/control_units/game_logic_top.sv
    ../rtl/control_units/base_control.sv
    ../rtl/control_units/fire_control.sv


    ../rtl/screen_manage.sv
    ../rtl/memory_manage.sv
    ../rtl/template_ram.sv

    ../rtl/cursor.sv


    ../rtl/hex/disp_hex_mux.sv
    ../rtl/hex/num_to_hex.sv


    ../rtl/top_rtl.sv
    rtl/top_basys3.sv
}

# Specify Verilog design files location         -- EDIT
set verilog_files {

    ../rtl/mmcm/clk_wiz_0.v
    ../rtl/mmcm/clk_wiz_0_clk_wiz.v
    ../rtl/debounce.v
}

# Specify VHDL design files location            -- EDIT
# set vhdl_files {
#
# }

# Specify files for a memory initialization     -- EDIT
# set mem_files {
#    path/to/file.data
# }
