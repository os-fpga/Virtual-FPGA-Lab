# FPGA Implementation of Virtual FPGA lab

#
#STEP#0: define your customized top file and setting up the board
#

set fp [open "tmp.txt" r]
set content [read $fp]
close $fp
set lines [split $content \n]
set file_name [lindex $lines 0]
set part_name [lindex $lines 1]
set cons_name [lindex $lines 2]
set shell_path [lindex $lines 3]

#
# STEP#1: define output directory area.
#
set outputDir ./out_${file_name}_${part_name}/FPGA_${file_name}
file mkdir $outputDir

#
# STEP#2: setup design sources and constraints
#
read_verilog ./out_${file_name}_${part_name}/${file_name}.v
read_verilog ./out_${file_name}_${part_name}/includes/proj_verilog/clk_gate.v
read_verilog ${shell_path}/../../includes/clock_divider.v
#set_property -include_dirs {./out_${file_name}_${part_name}/includes/* ./out_${file_name}_${part_name}/includes/proj_verilog/* ./out_${file_name}_${part_name}/includes/proj_default/*} [current_fileset]
read_xdc $cons_name
read_xdc ./out_${file_name}_${part_name}/clock_constraints.xdc

#
# STEP#3: run synthesis, report utilization and timing estimates, write checkpoint design
#
set multi_include_dirs " \
./out_${file_name}_${part_name}/includes \
./out_${file_name}_${part_name}/includes/proj_verilog \
./out_${file_name}_${part_name}/includes/proj_default \
"
synth_design -top top -part $part_name -retiming -include_dirs $multi_include_dirs
file mkdir $outputDir/syn/reports
write_checkpoint -force $outputDir/syn/post_synth
report_timing_summary -file $outputDir/syn/reports/post_synth_timing_summary.rpt
report_power -file $outputDir/syn/reports/post_synth_power.rpt

#
# STEP#4: run placement and logic optimzation, report utilization and timing estimates, write checkpoint design
#
opt_design -directive ExploreArea
place_design
phys_opt_design
file mkdir $outputDir/place
file mkdir $outputDir/place/reports
write_checkpoint -force $outputDir/place/post_place
report_timing_summary -file $outputDir/place/reports/post_place_timing_summary.rpt

#
# STEP#5: run router, report actual utilization and timing, write checkpoint design, run drc, write verilog and xdc out
#
route_design
file mkdir $outputDir/route
file mkdir $outputDir/route/reports
write_checkpoint -force $outputDir/route/post_route
report_timing_summary -file $outputDir/route/reports/post_route_timing_summary.rpt
report_timing -sort_by group -max_paths 100 -path_type summary -file $outputDir/route/reports/post_route_timing.rpt
report_clock_utilization -file $outputDir/route/reports/clock_util.rpt
report_utilization -file $outputDir/route/reports/post_route_util.rpt
report_power -file $outputDir/route/reports/post_route_power.rpt
report_drc -file $outputDir/route/reports/post_imp_drc.rpt
write_verilog -force $outputDir/fpga_impl_netlist.v
write_xdc -no_fixed_only -force $outputDir/fpga_impl.xdc

#
#STEP#7: Printing Summary
#
set met_timing "Met Timing Constrains: true"
set no_timing "Timing constraints given : true"
set no_timing_search "There are no user specified timing constraints."
set search "Timing constraints are not met."
set timing_report [open $outputDir/route/reports/post_route_timing_summary.rpt]
 while {[gets $timing_report data] != -1} {
    if {[string match *[string toupper $search]* [string toupper $data]] } {
		set met_timing "Met Timing Constrains: false"
		close $timing_report
		puts $met_timing
		puts "check your timing constraints and run the script again"
		puts "----------------EXITING -----------------"
		exit
		#STEP 6 - write bitstream will not get performed
    } elseif {[string match *[string toupper $no_timing_search]* [string toupper $data]] } {
		set no_timing "Timing constraints given : false"
		close $timing_report
		puts $no_timing
		puts "check your timing constraints and run the script again"
		puts "----------------EXITING -----------------"
		exit
		#STEP 6 - write bitstream will not get performed
    } else {}
 }
close $timing_report
puts $met_timing
puts $no_timing

set search_util "Slice LUTs"
set util_report [open $outputDir/route/reports/post_route_util.rpt]
 while {[gets $util_report data] != -1} {
    if {[string match *[string toupper $search_util]* [string toupper $data]] } {
		set haha $data
    } else {
    }
 }
close $util_report
set theWords [regexp -all -inline {\S+} $haha]
puts $haha
puts [lindex $theWords 4]

#
# STEP#6: generate a bitstream
#
write_bitstream -force $outputDir/$file_name.bit

#
# STEP#7: connect to your board
#
open_hw
connect_hw_server
open_hw_target
#current_hw_device [lindex [get_hw_devices] 0]

set file_loc ./$outputDir/$file_name.bit
puts $file_loc
set test [exec pwd]
puts $test
set_property PROGRAM.FILE $file_loc [current_hw_device]
program_hw_device

exit
