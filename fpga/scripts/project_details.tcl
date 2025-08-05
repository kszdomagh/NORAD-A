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
set project_name vga_project

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
}

# Specify SystemVerilog design files location   -- EDIT
set sv_files {

    ../rtl/vector_display/vector_pkg.sv
    ../rtl/vector_display/top_vector_display.sv
    ../rtl/vector_display/vector_manage.sv
    ../rtl/vector_display/draw_frame.sv

    ../rtl/vector_display/draw_vector_master.sv
    ../rtl/vector_display/memory_manage.sv
    ../rtl/vector_display/valid_buf.sv
    ../rtl/vector_display/bresenham.sv
    ../rtl/uwu_rom.sv

    ../rtl/template_ram.sv
    ../rtl/top_rtl.sv
    ../rtl/counter.sv
    ../rtl/clk_div.sv
    ../rtl/template_ram.sv
    rtl/top_basys3.sv
}

# Specify Verilog design files location         -- EDIT
set verilog_files {
    ../rtl/vector_display/linedraw.v
    
}

# Specify VHDL design files location            -- EDIT
# set vhdl_files {
#    path/to/file.vhd
# }

# Specify files for a memory initialization     -- EDIT
# set mem_files {
#    path/to/file.data
# }
