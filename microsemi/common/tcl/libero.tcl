#==============================================================================
# Build a Libero project from Chisel generated Verilog and the Libero TCL
# scriplets generated by each IP block FPGA-Shell.
#==============================================================================

######### Script arguments #########

if {$argc != 5} {
	puts "!!! ERROR !!!: This script takes 5 arguments from the Chisel build environment: BUILD_DIR MODEL PROJECT CONFIG BOARD" 
	exit
}

puts "*****************************************************************"
puts "******************** Building Libero project ********************"
puts "*****************************************************************"

set chisel_build_dir [lindex $argv 0]
set chisel_model [lindex $argv 1]
set chisel_project [lindex $argv 2]
set chisel_config [lindex $argv 3]
set chisel_board  [lindex $argv 4]

puts "Number of arguments: $argc"
puts "Chisel build directory: $chisel_build_dir"
puts "Chisel model: $chisel_model"
puts "Chisel project: $chisel_project"
puts "Chisel config: $chisel_config"
puts "Chisel board: $chisel_board"

set Prjname "$chisel_model"
set Proj "./Libero/$Prjname"

set FPExpressDir "$chisel_build_dir/FlashProExpress"
puts "FlashPro Express folder: $FPExpressDir"
file mkdir $FPExpressDir

set scriptdir [file dirname [info script]]
set commondir [file dirname $scriptdir]
set boarddir [file join [ file dirname $commondir] $chisel_board]

###########################################
set CoreJTAGDebugver {2.0.100}
set PF_DDR3ver {2.3.201}
set PF_DDR4ver {2.3.201}
set PF_CCCver {1.0.115}
set PF_INIT_MONITORver {2.0.103}
set PF_CORERESETPFver {2.1.100}
set PF_PCIEver {2.0.100}
set PF_XCVR_REF_CLKver {1.0.103}
set PF_TX_PLLver {2.0.002}

set use_enhanced_constraint_flow 1
set tb {testbench}
file delete -force "$Proj"
set rootcomp {Top_SD}
set rootcomp1 Top_SD
set TOP Top_SD

set SimTime 100us
set NUM_TX_PLL 1
set quad 1
set txpll_refclk_mode "ded"
set xcvrrefclk_refclk_mode "diff"

#########ORIGINAl SETTINGS#############

#Device Selection
source [file join $boarddir tcl board.tcl]

#Analysis operating conditions
set TEMPR {EXT}
set VOLTR {EXT}
set IOVOLTR_12 {EXT}
set IOVOLTR_15 {EXT}
set IOVOLTR_18 {EXT}
set IOVOLTR_25 {EXT}
set IOVOLTR_33 {EXT}

#Design Flow
set HDL {VERILOG}
set Block 0
set SAPI 0
set vmflow 1
set synth 1
set fanout {10}

#########ORIGINAl SETTINGS#############

new_project -ondemand_build_dh 1 -location "$Proj" -name "$Prjname" -project_description {} -block_mode $Block -standalone_peripheral_initialization $SAPI -use_enhanced_constraint_flow $use_enhanced_constraint_flow -hdl $HDL -family $family -die $die -package $package -speed $speed -die_voltage $die_voltage -part_range $part_range -adv_options IO_DEFT_STD:$IOTech -adv_options RESTRICTPROBEPINS:$ResProbe -adv_options RESTRICTSPIPINS:$ResSPI -adv_options TEMPR:$TEMPR -adv_options VCCI_1.2_VOLTR:$IOVOLTR_12 -adv_options VCCI_1.5_VOLTR:$IOVOLTR_15 -adv_options VCCI_1.8_VOLTR:$IOVOLTR_18 -adv_options VCCI_2.5_VOLTR:$IOVOLTR_25 -adv_options VCCI_3.3_VOLTR:$IOVOLTR_33 -adv_options VOLTR:$VOLTR 

#
# Import Chisel generated verilog files into Libero project
#
import_files \
         -convert_EDN_to_HDL 0 \
         -hdl_source "$chisel_build_dir/$chisel_project.$chisel_config.v" \
         -hdl_source "../../rocket-chip/src/main/resources/vsrc/AsyncResetReg.v" \
         -hdl_source "../../rocket-chip/src/main/resources/vsrc/plusarg_reader.v"

download_latest_cores
#download_core -vlnv {Actel:DirectCore:COREDES:3.0.106} -vlnv {Actel:DirectCore:COREAHBLTOAXI:2.1.101} -vlnv {Actel:DirectCore:CORE3DES:3.1.104} -vlnv {Actel:DirectCore:COREAHBTOAPB3:3.1.100} -vlnv {Actel:DirectCore:CoreAPB3:4.1.100} -vlnv {Actel:DirectCore:corepwm:4.3.101} -vlnv {Actel:DirectCore:CoreTimer:2.0.103} -vlnv {Actel:DirectCore:CORECORDIC:4.0.102} -vlnv {Actel:DirectCore:CORESPI:5.1.104} -vlnv {Actel:DirectCore:COREAXI4SRAM:2.1.105} -vlnv {Actel:DirectCore:CoreDDRMemCtrlr:0.0.74} -vlnv {Actel:DirectCore:CoreJESD204BTX:3.0.114} -vlnv {Actel:DirectCore:COREUART:5.6.102} -vlnv {Actel:DirectCore:CoreUARTapb:5.6.102} -vlnv {Actel:DirectCore:COREABC:3.7.101} -vlnv {Actel:DirectCore:COREFFT:7.0.104} -vlnv {Actel:DirectCore:CORERSENC:3.5.102} -vlnv {Actel:DirectCore:CORERSDEC:3.6.104} -vlnv {Actel:DirectCore:COREFIFO:2.6.108} -vlnv {Actel:DirectCore:CORE429:3.12.105} -vlnv {Actel:DirectCore:CORE429_APB:3.12.105} -vlnv {Actel:DirectCore:CORETSE:3.1.102} -vlnv {Actel:DirectCore:CORETSE_AHB:3.1.102} -vlnv {Actel:DirectCore:COREFIR_PF:2.0.104} -vlnv {Actel:DirectCore:COREAXI4DMACONTROLLER:2.0.100} -vlnv {Actel:DirectCore:COREBOOTSTRAP:2.0.100} -vlnv {Actel:DirectCore:CoreJESD204BRX:3.0.126} -vlnv {Actel:DirectCore:CORESGMII:3.2.101} -vlnv {Actel:DirectCore:COREAHBL2AHBL_BRIDGE:2.0.108} -vlnv {Actel:DirectCore:CORERISCV_AXI4:2.0.102} -vlnv {Actel:DirectCore:COREJTAGDEBUG:2.0.100} -vlnv {Actel:DirectCore:CoreAXI4Interconnect:2.2.102} -vlnv {Actel:DirectCore:COREMDIO_APB:2.1.100} -vlnv {Actel:DirectCore:CORERMII:3.0.105} -vlnv {Actel:DirectCore:COREDDR_TIP:1.1.124} -vlnv {Actel:DirectCore:COREDDS:3.0.105} -vlnv {Actel:DirectCore:COREI2C:7.2.101} -vlnv {Actel:DirectCore:CoreAHBLite:5.3.101} -vlnv {Actel:DirectCore:CoreGPIO:3.2.102} -vlnv {Actel:DirectCore:COREAXITOAHBL:3.2.104} -vlnv {Actel:DirectCore:COREEDAC:2.10.104} -vlnv {Microsemi:MiV:MIV_RV32IMA_L1_AHB:2.0.100} -vlnv {Microsemi:MiV:MIV_RV32IMAF_L1_AHB:2.0.100} -vlnv {Actel:DirectCore:CorePCS:3.5.106} -vlnv {Actel:DirectCore:COREPCIF:4.1.123} -vlnv {Actel:DirectCore:COREPCIF_AHB:4.1.123} -vlnv {Actel:SystemBuilder:CORESMARTBERT:2.0.106} -vlnv {Actel:DirectCore:CORESYSSERVICES_PF:2.3.116} -vlnv {Actel:DirectCore:CORERESET_PF:2.1.100} -vlnv {Microsemi:SolutionCore:iog_cdr_test_wrapper:1.0.0} -vlnv {Microsemi:SolutionCore:alpha_blend_control:2.0.0} -vlnv {Microsemi:SolutionCore:BayerConversionTop:2.0.0} -vlnv {Microsemi:SolutionCore:ImageEdgeDetection:2.0.0} -vlnv {Microsemi:SolutionCore:ImageSharpenFilter:2.0.0} -vlnv {Microsemi:SolutionCore:RGB2YCbCr:2.0.0} -vlnv {Microsemi:SolutionCore:Scaler:2.0.0} -vlnv {Microsemi:SolutionCore:ddr_memory_arbiter:2.0.0} -vlnv {Microsemi:SolutionCore:YCbCr2RGB:2.0.0} -vlnv {Microsemi:SolutionCore:display_controller:2.0.0} -vlnv {Microsemi:SolutionCore:DisplayEnhancements:2.0.0} -vlnv {Microsemi:SolutionCore:pattern_generator:2.0.0} -vlnv {Actel:DirectCore:CORE10GMAC:2.1.126} -vlnv {Actel:DirectCore:CORECIC:2.1.103} -vlnv {Microsemi:SolutionCore:CPRI:2.0.0} -vlnv {Microsemi:SolutionCore:LiteFast:1.0.3} -vlnv {Microsemi:MiV:MIV_RV32IMA_L1_AXI:2.0.100} -vlnv {Actel:DirectCore:COREAXI4INTERCONNECT:2.5.100} -vlnv {Actel:DirectCore:COREXAUI:2.0.133} -vlnv {Microsemi:SolutionCore:mipi_csi2_tx:2.0.0} -vlnv {Actel:DirectCore:COREQSGMII:2.0.108} -vlnv {Microsemi:SolutionCore:complex_multiplier:1.0.26} -vlnv {Microsemi:SolutionCore:mipicsi2rxdecoderPF:2.1.0} -location {www.actel-ip.com/repositories/DirectCore} 
#download_core -vlnv {Actel:Simulation:CLK_GEN:1.0.1} -vlnv {Actel:Simulation:PULSE_GEN:1.0.1} -vlnv {Actel:Simulation:RESET_GEN:1.0.1} -vlnv {Actel:DirectCore:CoreDDRMemCtrlr:0.0.74} -vlnv {Actel:DirectCore:COREDDR_TIP:1.1.124} -vlnv {Actel:SgCore:PF_CCC:1.0.112} -vlnv {Actel:SgCore:PF_CRYPTO:1.0.101} -vlnv {Actel:SgCore:PF_DPSRAM:1.1.110} -vlnv {Actel:SgCore:PF_DRI:1.0.101} -vlnv {Actel:SgCore:PF_INIT_MONITOR:2.0.101} -vlnv {Actel:SgCore:PF_NGMUX:1.0.101} -vlnv {Actel:SgCore:PF_OSC:1.0.102} -vlnv {Actel:SgCore:PF_TAMPER:1.0.102} -vlnv {Actel:SgCore:PF_TPSRAM:1.1.108} -vlnv {Actel:SgCore:PF_TX_PLL:1.0.109} -vlnv {Actel:SgCore:PF_UPROM:1.0.108} -vlnv {Actel:SgCore:PF_URAM:1.1.107} -vlnv {Actel:SgCore:PF_XCVR:1.0.223} -vlnv {Actel:SgCore:PF_XCVR_REF_CLK:1.0.103} -vlnv {Actel:SystemBuilder:PF_IOD_CDR:1.0.210} -vlnv {Actel:SystemBuilder:PF_IOD_LVDS7_RX:1.0.104} -vlnv {Actel:SystemBuilder:PF_IOD_LVDS7_TX:1.0.104} -vlnv {Actel:SystemBuilder:CORESMARTBERT:2.0.106} -vlnv {Actel:SgCore:PF_CLK_DIV:1.0.102} -vlnv {Actel:SgCore:PF_PCIE:1.0.234} -vlnv {Actel:SystemBuilder:PF_DDR3:2.2.109} -vlnv {Actel:SystemBuilder:PF_DDR4:2.2.109} -vlnv {Actel:SystemBuilder:PF_IOD_GENERIC_RX:1.0.238} -vlnv {Actel:SystemBuilder:PF_IOD_GENERIC_TX:1.0.234} -vlnv {Actel:SystemBuilder:PF_LPDDR3:2.1.111} -vlnv {Actel:SystemBuilder:PF_RGMII_TO_GMII:1.0.208} -vlnv {Actel:SystemBuilder:PF_SRAM_AHBL_AXI:1.1.123} -location {www.actel-ip.com/repositories/SgCore} 
#
#
# Execute all design entry scripts generated from Chisel flow.
#
set tclfiles [glob -directory $chisel_build_dir $chisel_project.$chisel_config.*.libero.tcl ]

foreach f $tclfiles {
    puts "---------- Executing Libero TCL script: $f ----------"
    source $f
}

#
# Build design hierarchy and set project root to design's top level
#
build_design_hierarchy         

#set_root -module {U500PolarFireEvalKitFPGAChip::work}
set proj_root $chisel_model
append proj_root "::work"
puts "project root: $proj_root"
set_root -module $proj_root

#
# Import IO, Placement and timing constrainst
#
puts "-----------------------------------------------------------------"
puts "------------------ Applying design constraints ------------------"
puts "-----------------------------------------------------------------"

set sdc    $chisel_project.$chisel_config.shell.sdc
set io_pdc $chisel_project.$chisel_config.shell.io.pdc

import_files -fp_pdc [file join $boarddir constraints floor_plan.pdc]
import_files -io_pdc [file join $boarddir constraints pin_constraints.pdc]
import_files                    -io_pdc [file join $chisel_build_dir $io_pdc]
import_files -convert_EDN_to_HDL 0 -sdc [file join $chisel_build_dir $sdc]

organize_tool_files -tool {PLACEROUTE} \
         -file $Proj/constraint/fp/floor_plan.pdc \
         -file $Proj/constraint/io/pin_constraints.pdc \
         -file $Proj/constraint/io/$io_pdc \
         -file $Proj/constraint/$sdc \
         -module $proj_root -input_type {constraint}

organize_tool_files -tool {VERIFYTIMING} \
         -file $Proj/constraint/$sdc \
         -module $proj_root -input_type {constraint} 
         
run_tool -name {CONSTRAINT_MANAGEMENT} 
derive_constraints_sdc

#
# Synthesis
#
puts "-----------------------------------------------------------------"
puts "--------------------------- Synthesis ---------------------------"
puts "-----------------------------------------------------------------"
run_tool -name {SYNTHESIZE}

#
# Place and route
#
puts "-----------------------------------------------------------------"
puts "------------------------ Place and Route ------------------------"
puts "-----------------------------------------------------------------"
configure_tool -name {PLACEROUTE} -params {EFFORT_LEVEL:true} -params {REPAIR_MIN_DELAY:true} -params {TDPR:true} -params {IOREG_COMBINING:true}
run_tool -name {PLACEROUTE}

#
# Verify Timing
#
puts "-----------------------------------------------------------------"
puts "------------------------- Verify Timing -------------------------"
puts "-----------------------------------------------------------------"
configure_tool -name {VERIFYTIMING}			\
	-params {FORMAT:XML}				\
	-params {CONSTRAINTS_COVERAGE:1}		\
	-params {MAX_TIMING_FAST_HV_LT:1}		\
	-params {MAX_TIMING_SLOW_LV_HT:1}		\
	-params {MAX_TIMING_SLOW_LV_LT:1}		\
	-params {MAX_TIMING_VIOLATIONS_FAST_HV_LT:1}	\
	-params {MAX_TIMING_VIOLATIONS_SLOW_LV_HT:1}	\
	-params {MAX_TIMING_VIOLATIONS_SLOW_LV_LT:1}	\
	-params {MIN_TIMING_FAST_HV_LT:1}		\
	-params {MIN_TIMING_SLOW_LV_HT:1}		\
	-params {MIN_TIMING_SLOW_LV_LT:1}		\
	-params {MIN_TIMING_VIOLATIONS_FAST_HV_LT:1}	\
	-params {MIN_TIMING_VIOLATIONS_SLOW_LV_HT:1}	\
	-params {MIN_TIMING_VIOLATIONS_SLOW_LV_LT:1}
run_tool -name {VERIFYTIMING}

puts ""
puts "Checking timing reports"

set reportdir [file join $chisel_build_dir Libero $Prjname designer $Prjname]
set reports [glob -directory $reportdir [set Prjname]_\{min,max\}_timing_violations_\{fast,slow\}_\{hv,lv\}_\{lt,ht\}.*]
set ok true
set eof true

foreach report [lsort $reports] {
  puts -nonewline " Parsing [file tail ${report}]... "
  set fp [open $report]
  while {[gets $fp line] >= 0} {
    set what [string trim "$line"]
    set eof false
    if { "$what" == "<text>This report was not generated</text>" } {
      puts "empty"
      break
    }
    if { "$what" == "<text>No Path</text>" } {
      puts "pass"
      break
    }
    if { "$what" == "<text>Path 1</text>" } {
      puts "failed"
      set ok false
      break
    }
    set eof true
  }
  close $fp
  if { $eof } {
    puts "end-of-file"
    set ok false
  }
}

if { !$ok } {
  puts ""
  puts "Timing constraints not met!"
  return -code error "timing failed"
}

#
# Generate programming files
#
puts "-----------------------------------------------------------------"
puts "------------------ Generate programming files -------------------"
puts "-----------------------------------------------------------------"
run_tool -name {GENERATEPROGRAMMINGDATA} 

run_tool -name {GENERATEPROGRAMMINGFILE} 

export_prog_job \
    -job_file_name $chisel_model \
    -export_dir $FPExpressDir \
    -bitstream_file_type {TRUSTED_FACILITY} \
    -bitstream_file_components {}
