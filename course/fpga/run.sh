# shell script to run complete FPGA flow
echo "================================================"
echo "WELCOME TO VIRTUAL FPGA LAB"
echo "================================================"

#path=$(pwd)
shell_path=$(cd "$(dirname "$0")" && pwd)

echo "================================================"
echo "GOING TO THE REQUIRED DIRECTORY"
echo "================================================"

### TAKING THE REQUIRED INPUT FROM THE USER
echo "================================================"
read -p "WHICH FILE YOU WANT TO UPLOAD ON VIVADO : " filename
echo "================================================"

echo "================================================"
echo "WHICH BOARD YOU WANT TO USE (basys3, edge_artix-7, zedboard)"
read -p "IF YOU HAVE A DIFFERENT BOARD , WRITE THE PART NO: " board
echo "================================================"

if [ "$board" == "basys3" ]; then
  partname="xc7a35tcpg236-1"
  cons_name="$shell_path/contraints/fpga_lab_constr_$board.xdc"

elif [ "$board" == "edge_artix-7" ]; then
  partname="xc7a35tftg256-1"
  cons_name="$shell_path/contraints/fpga_lab_constr_$board.xdc"

elif [ "$board" == "zedboard" ]; then
  partname="xc7z020clg484-1"
  cons_name="$shell_path/contraints/fpga_lab_constr_$board.xdc"

else
  partname=$board
  cons_name="${filename}_$board.xdc"
fi

echo "================================================"
echo "DELETING THE PREVIOUS BUILD FOLDER"
rm -R out_"${filename}_$partname"
echo "================================================"

# Give the respective tlv file as top. For eg, for counter test case give it as counter.tlv
echo "================================================"
echo "PROCESSING .TLV USING SANDPIPER(TM) SaaS EDITION."
echo "------------------------------------------------"
sandpiper-saas -i "$filename".tlv -o "$filename".v --iArgs --default_includes --outdir=out_"${filename}_$partname"
echo "================================================"

echo "================================================="
echo "SETTING UP THE BOARD REQUIREMENTS"
echo "-------------------------------------------------"
read -p "INPUT THE CLOCK(in ns) AT WHICH YOU WANT TO RUN YOUR PROGRAM : " clock_rate
echo "================================================="

### GENERATING A CLOCK CONSTRAINTS FILE WHICH WILL BE  USED AS CONSTRAINTS FILE IN TCL
echo "================================================="
echo "GENERATING CLOCK CONSTRAINTS"

var1=$(expr "scale=3; $clock_rate/1" | bc)
var2=$(expr "scale=3; $clock_rate/2" | bc)

echo "create_clock -period $var1 -name clk -waveform {0.000 $var2} [get_ports clk]" >>./out_"${filename}_$partname"/clock_constraints.xdc
echo "set_input_delay -clock [get_clocks clk] -min -add_delay 0.000 [get_ports reset]" >>./out_"${filename}_$partname"/clock_constraints.xdc
echo "set_input_delay -clock [get_clocks clk] -max -add_delay 0.000 [get_ports reset]" >>./out_"${filename}_$partname"/clock_constraints.xdc

echo "==================================================="

## CREATING A COPY OF INPUT VARIABLES IN THE TCL FILE
echo "$filename" >>tmp.txt
echo "$partname" >>tmp.txt
echo "$cons_name" >>tmp.txt
echo "$shell_path" >>tmp.txt

path=$PWD
echo "================================================"

cd
echo "================================================"
echo "SOURCING VIVADO"
echo "================================================"

cd vivado
source Vivado/2020.2/settings64.sh
cd
cd "$path"
rm vivado*
rm usage_*

vivado -mode batch -source "$shell_path"/run.tcl
rm -f tmp.txt
