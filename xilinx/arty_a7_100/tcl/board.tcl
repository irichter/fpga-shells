# See LICENSE for license details.
set name {arty-a7-100}
set part_fpga {xc7a100tcsg324-1}
set part_board {digilentinc.com:arty-a7-100:part0:1.1}
set bootrom_inst {rom}
set_param board.repoPaths [file join [file dirname [info script]] "../../../../digilent-boards/new/board_files" ]
