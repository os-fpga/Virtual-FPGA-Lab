// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2020.2 (lin64) Build 3064766 Wed Nov 18 09:12:47 MST 2020
// Date        : Sat Oct 30 02:37:19 2021
// Host        : DESKTOP-D80LUPK running 64-bit Ubuntu 20.04.3 LTS
// Command     : write_verilog -force ./../out/edge_artix-7/led_counter/Output/fpga_impl_netlist.v
// Design      : top
// Purpose     : This is a Verilog netlist of the current design or from a specific cell of the design. The output is an
//               IEEE 1364-2001 compliant Verilog HDL file that contains netlist information obtained from the input
//               design files.
// Device      : xc7a35tftg256-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module clk_gate
   (\LED_PIPE_count1_a1_reg[11] ,
    \LED_PIPE_count1_a1_reg[24] ,
    \LED_PIPE_count1_a1_reg[28] ,
    CLK,
    LED_PIPE_count1_a1,
    O,
    latched_clk_en_reg_i_6_0,
    latched_clk_en_reg_i_3_0,
    latched_clk_en_reg_i_6_1,
    latched_clk_en_reg_i_3_1,
    latched_clk_en_reg_i_3_2,
    latched_clk_en_reg_i_3_3,
    latched_clk_en_reg_i_3_4,
    LED_PIPE_rst1_a1,
    clk_IBUF,
    clk_IBUF_BUFG);
  output \LED_PIPE_count1_a1_reg[11] ;
  output \LED_PIPE_count1_a1_reg[24] ;
  output \LED_PIPE_count1_a1_reg[28] ;
  output CLK;
  input [25:0]LED_PIPE_count1_a1;
  input [3:0]O;
  input [3:0]latched_clk_en_reg_i_6_0;
  input [3:0]latched_clk_en_reg_i_3_0;
  input [3:0]latched_clk_en_reg_i_6_1;
  input [3:0]latched_clk_en_reg_i_3_1;
  input [3:0]latched_clk_en_reg_i_3_2;
  input [3:0]latched_clk_en_reg_i_3_3;
  input [2:0]latched_clk_en_reg_i_3_4;
  input LED_PIPE_rst1_a1;
  input clk_IBUF;
  input clk_IBUF_BUFG;

  wire CLK;
  wire GND_1;
  wire [25:0]LED_PIPE_count1_a1;
  wire \LED_PIPE_count1_a1_reg[11] ;
  wire \LED_PIPE_count1_a1_reg[24] ;
  wire \LED_PIPE_count1_a1_reg[28] ;
  wire LED_PIPE_refresh_a0;
  wire LED_PIPE_rst1_a1;
  wire [3:0]O;
  wire VCC_1;
  wire clk_IBUF;
  wire clk_IBUF_BUFG;
  wire latched_clk_en;
  wire latched_clk_en_reg_i_10_n_0;
  wire latched_clk_en_reg_i_11_n_0;
  wire latched_clk_en_reg_i_12_n_0;
  wire latched_clk_en_reg_i_13_n_0;
  wire latched_clk_en_reg_i_14_n_0;
  wire [3:0]latched_clk_en_reg_i_3_0;
  wire [3:0]latched_clk_en_reg_i_3_1;
  wire [3:0]latched_clk_en_reg_i_3_2;
  wire [3:0]latched_clk_en_reg_i_3_3;
  wire [2:0]latched_clk_en_reg_i_3_4;
  wire latched_clk_en_reg_i_3_n_0;
  wire [3:0]latched_clk_en_reg_i_6_0;
  wire [3:0]latched_clk_en_reg_i_6_1;
  wire latched_clk_en_reg_i_6_n_0;
  wire latched_clk_en_reg_i_7_n_0;
  wire latched_clk_en_reg_i_8_n_0;
  wire latched_clk_en_reg_i_9_n_0;

  GND GND
       (.G(GND_1));
  LUT2 #(
    .INIT(4'h8)) 
    \LED_PIPE_Leds_a0[15]_i_2 
       (.I0(latched_clk_en),
        .I1(clk_IBUF),
        .O(CLK));
  LUT6 #(
    .INIT(64'h0000000000000001)) 
    \LED_PIPE_count1_a1[31]_i_3 
       (.I0(LED_PIPE_count1_a1[22]),
        .I1(LED_PIPE_count1_a1[23]),
        .I2(LED_PIPE_count1_a1[20]),
        .I3(LED_PIPE_count1_a1[21]),
        .I4(LED_PIPE_count1_a1[25]),
        .I5(LED_PIPE_count1_a1[24]),
        .O(\LED_PIPE_count1_a1_reg[28] ));
  VCC VCC
       (.P(VCC_1));
  (* OPT_MODIFIED = "MLO" *) 
  (* XILINX_LEGACY_PRIM = "LD" *) 
  LDCE #(
    .INIT(1'b0),
    .IS_G_INVERTED(1'b1)) 
    latched_clk_en_reg
       (.CLR(GND_1),
        .D(LED_PIPE_refresh_a0),
        .G(clk_IBUF_BUFG),
        .GE(VCC_1),
        .Q(latched_clk_en));
  LUT4 #(
    .INIT(16'hA800)) 
    latched_clk_en_reg_i_1
       (.I0(latched_clk_en_reg_i_3_n_0),
        .I1(\LED_PIPE_count1_a1_reg[11] ),
        .I2(\LED_PIPE_count1_a1_reg[24] ),
        .I3(latched_clk_en_reg_i_6_n_0),
        .O(LED_PIPE_refresh_a0));
  LUT4 #(
    .INIT(16'h0001)) 
    latched_clk_en_reg_i_10
       (.I0(LED_PIPE_count1_a1[2]),
        .I1(LED_PIPE_count1_a1[1]),
        .I2(LED_PIPE_count1_a1[4]),
        .I3(LED_PIPE_count1_a1[3]),
        .O(latched_clk_en_reg_i_10_n_0));
  LUT4 #(
    .INIT(16'h7FFF)) 
    latched_clk_en_reg_i_11
       (.I0(LED_PIPE_count1_a1[14]),
        .I1(LED_PIPE_count1_a1[13]),
        .I2(LED_PIPE_count1_a1[16]),
        .I3(LED_PIPE_count1_a1[15]),
        .O(latched_clk_en_reg_i_11_n_0));
  LUT6 #(
    .INIT(64'h15555555FFFFFFFF)) 
    latched_clk_en_reg_i_12
       (.I0(LED_PIPE_count1_a1[10]),
        .I1(LED_PIPE_count1_a1[7]),
        .I2(LED_PIPE_count1_a1[6]),
        .I3(LED_PIPE_count1_a1[9]),
        .I4(LED_PIPE_count1_a1[8]),
        .I5(LED_PIPE_count1_a1[11]),
        .O(latched_clk_en_reg_i_12_n_0));
  LUT6 #(
    .INIT(64'h0000000000002000)) 
    latched_clk_en_reg_i_13
       (.I0(latched_clk_en_reg_i_6_1[1]),
        .I1(latched_clk_en_reg_i_6_1[2]),
        .I2(O[3]),
        .I3(latched_clk_en_reg_i_6_1[0]),
        .I4(latched_clk_en_reg_i_6_0[0]),
        .I5(latched_clk_en_reg_i_6_1[3]),
        .O(latched_clk_en_reg_i_13_n_0));
  LUT6 #(
    .INIT(64'h0008000000000000)) 
    latched_clk_en_reg_i_14
       (.I0(latched_clk_en_reg_i_6_0[3]),
        .I1(latched_clk_en_reg_i_3_0[0]),
        .I2(latched_clk_en_reg_i_6_0[1]),
        .I3(latched_clk_en_reg_i_6_0[2]),
        .I4(latched_clk_en_reg_i_3_0[2]),
        .I5(latched_clk_en_reg_i_3_0[1]),
        .O(latched_clk_en_reg_i_14_n_0));
  LUT4 #(
    .INIT(16'h8000)) 
    latched_clk_en_reg_i_3
       (.I0(latched_clk_en_reg_i_7_n_0),
        .I1(\LED_PIPE_count1_a1_reg[28] ),
        .I2(latched_clk_en_reg_i_8_n_0),
        .I3(latched_clk_en_reg_i_9_n_0),
        .O(latched_clk_en_reg_i_3_n_0));
  LUT5 #(
    .INIT(32'h00010000)) 
    latched_clk_en_reg_i_4
       (.I0(LED_PIPE_count1_a1[5]),
        .I1(LED_PIPE_count1_a1[10]),
        .I2(LED_PIPE_count1_a1[12]),
        .I3(LED_PIPE_count1_a1[18]),
        .I4(latched_clk_en_reg_i_10_n_0),
        .O(\LED_PIPE_count1_a1_reg[11] ));
  LUT6 #(
    .INIT(64'h45455545FFFFFFFF)) 
    latched_clk_en_reg_i_5
       (.I0(LED_PIPE_count1_a1[18]),
        .I1(latched_clk_en_reg_i_11_n_0),
        .I2(LED_PIPE_count1_a1[17]),
        .I3(latched_clk_en_reg_i_12_n_0),
        .I4(LED_PIPE_count1_a1[12]),
        .I5(LED_PIPE_count1_a1[19]),
        .O(\LED_PIPE_count1_a1_reg[24] ));
  LUT5 #(
    .INIT(32'h80000000)) 
    latched_clk_en_reg_i_6
       (.I0(latched_clk_en_reg_i_13_n_0),
        .I1(O[2]),
        .I2(O[1]),
        .I3(O[0]),
        .I4(latched_clk_en_reg_i_14_n_0),
        .O(latched_clk_en_reg_i_6_n_0));
  LUT6 #(
    .INIT(64'h0000000000000001)) 
    latched_clk_en_reg_i_7
       (.I0(latched_clk_en_reg_i_3_4[1]),
        .I1(latched_clk_en_reg_i_3_4[2]),
        .I2(latched_clk_en_reg_i_3_3[3]),
        .I3(latched_clk_en_reg_i_3_4[0]),
        .I4(LED_PIPE_count1_a1[0]),
        .I5(LED_PIPE_rst1_a1),
        .O(latched_clk_en_reg_i_7_n_0));
  LUT6 #(
    .INIT(64'h0020000000000000)) 
    latched_clk_en_reg_i_8
       (.I0(latched_clk_en_reg_i_3_1[2]),
        .I1(latched_clk_en_reg_i_3_1[1]),
        .I2(latched_clk_en_reg_i_3_1[0]),
        .I3(latched_clk_en_reg_i_3_0[3]),
        .I4(latched_clk_en_reg_i_3_2[0]),
        .I5(latched_clk_en_reg_i_3_1[3]),
        .O(latched_clk_en_reg_i_8_n_0));
  LUT6 #(
    .INIT(64'h0000000000002000)) 
    latched_clk_en_reg_i_9
       (.I0(latched_clk_en_reg_i_3_3[0]),
        .I1(latched_clk_en_reg_i_3_2[3]),
        .I2(latched_clk_en_reg_i_3_2[1]),
        .I3(latched_clk_en_reg_i_3_2[2]),
        .I4(latched_clk_en_reg_i_3_3[2]),
        .I5(latched_clk_en_reg_i_3_3[1]),
        .O(latched_clk_en_reg_i_9_n_0));
endmodule

(* ECO_CHECKSUM = "96723c4c" *) 
(* STRUCTURAL_NETLIST = "yes" *)
module top
   (clk,
    reset,
    led);
  input clk;
  input reset;
  output [15:0]led;

  wire \<const0> ;
  wire \<const1> ;
  wire [15:0]LED_PIPE_Leds_a0;
  wire \LED_PIPE_Leds_a0_reg[12]_i_1_n_0 ;
  wire \LED_PIPE_Leds_a0_reg[4]_i_1_n_0 ;
  wire \LED_PIPE_Leds_a0_reg[8]_i_1_n_0 ;
  wire [15:0]LED_PIPE_Leds_n10_in;
  wire [31:0]LED_PIPE_count1_a1;
  wire \LED_PIPE_count1_a1[0]_i_1_n_0 ;
  wire \LED_PIPE_count1_a1[31]_i_1_n_0 ;
  wire \LED_PIPE_count1_a1[31]_i_4_n_0 ;
  wire \LED_PIPE_count1_a1[31]_i_5_n_0 ;
  wire \LED_PIPE_count1_a1_reg[12]_i_1_n_0 ;
  wire \LED_PIPE_count1_a1_reg[12]_i_1_n_4 ;
  wire \LED_PIPE_count1_a1_reg[12]_i_1_n_5 ;
  wire \LED_PIPE_count1_a1_reg[12]_i_1_n_6 ;
  wire \LED_PIPE_count1_a1_reg[12]_i_1_n_7 ;
  wire \LED_PIPE_count1_a1_reg[16]_i_1_n_0 ;
  wire \LED_PIPE_count1_a1_reg[16]_i_1_n_4 ;
  wire \LED_PIPE_count1_a1_reg[16]_i_1_n_5 ;
  wire \LED_PIPE_count1_a1_reg[16]_i_1_n_6 ;
  wire \LED_PIPE_count1_a1_reg[16]_i_1_n_7 ;
  wire \LED_PIPE_count1_a1_reg[20]_i_1_n_0 ;
  wire \LED_PIPE_count1_a1_reg[20]_i_1_n_4 ;
  wire \LED_PIPE_count1_a1_reg[20]_i_1_n_5 ;
  wire \LED_PIPE_count1_a1_reg[20]_i_1_n_6 ;
  wire \LED_PIPE_count1_a1_reg[20]_i_1_n_7 ;
  wire \LED_PIPE_count1_a1_reg[24]_i_1_n_0 ;
  wire \LED_PIPE_count1_a1_reg[24]_i_1_n_4 ;
  wire \LED_PIPE_count1_a1_reg[24]_i_1_n_5 ;
  wire \LED_PIPE_count1_a1_reg[24]_i_1_n_6 ;
  wire \LED_PIPE_count1_a1_reg[24]_i_1_n_7 ;
  wire \LED_PIPE_count1_a1_reg[28]_i_1_n_0 ;
  wire \LED_PIPE_count1_a1_reg[28]_i_1_n_4 ;
  wire \LED_PIPE_count1_a1_reg[28]_i_1_n_5 ;
  wire \LED_PIPE_count1_a1_reg[28]_i_1_n_6 ;
  wire \LED_PIPE_count1_a1_reg[28]_i_1_n_7 ;
  wire \LED_PIPE_count1_a1_reg[31]_i_2_n_5 ;
  wire \LED_PIPE_count1_a1_reg[31]_i_2_n_6 ;
  wire \LED_PIPE_count1_a1_reg[31]_i_2_n_7 ;
  wire \LED_PIPE_count1_a1_reg[4]_i_1_n_0 ;
  wire \LED_PIPE_count1_a1_reg[4]_i_1_n_4 ;
  wire \LED_PIPE_count1_a1_reg[4]_i_1_n_5 ;
  wire \LED_PIPE_count1_a1_reg[4]_i_1_n_6 ;
  wire \LED_PIPE_count1_a1_reg[4]_i_1_n_7 ;
  wire \LED_PIPE_count1_a1_reg[8]_i_1_n_0 ;
  wire \LED_PIPE_count1_a1_reg[8]_i_1_n_4 ;
  wire \LED_PIPE_count1_a1_reg[8]_i_1_n_5 ;
  wire \LED_PIPE_count1_a1_reg[8]_i_1_n_6 ;
  wire \LED_PIPE_count1_a1_reg[8]_i_1_n_7 ;
  wire LED_PIPE_rst1_a1;
  wire clk;
  wire clkF_LED_PIPE_refresh_a1;
  wire clk_IBUF;
  wire clk_IBUF_BUFG;
  wire gen_clkF_LED_PIPE_refresh_a1_n_0;
  wire gen_clkF_LED_PIPE_refresh_a1_n_1;
  wire gen_clkF_LED_PIPE_refresh_a1_n_2;
  wire [15:0]led;
  wire [15:0]led_OBUF;
  wire reset;
  wire reset_IBUF;
  wire [3:0]\NLW_LED_PIPE_Leds_a0_reg[12]_i_1_CO_UNCONNECTED ;
  wire [3:0]\NLW_LED_PIPE_Leds_a0_reg[4]_i_1_CO_UNCONNECTED ;
  wire [3:0]\NLW_LED_PIPE_Leds_a0_reg[8]_i_1_CO_UNCONNECTED ;
  wire [3:0]\NLW_LED_PIPE_count1_a1_reg[12]_i_1_CO_UNCONNECTED ;
  wire [3:0]\NLW_LED_PIPE_count1_a1_reg[16]_i_1_CO_UNCONNECTED ;
  wire [3:0]\NLW_LED_PIPE_count1_a1_reg[20]_i_1_CO_UNCONNECTED ;
  wire [3:0]\NLW_LED_PIPE_count1_a1_reg[24]_i_1_CO_UNCONNECTED ;
  wire [3:0]\NLW_LED_PIPE_count1_a1_reg[28]_i_1_CO_UNCONNECTED ;
  wire [3:0]\NLW_LED_PIPE_count1_a1_reg[4]_i_1_CO_UNCONNECTED ;
  wire [3:0]\NLW_LED_PIPE_count1_a1_reg[8]_i_1_CO_UNCONNECTED ;

  GND GND
       (.G(\<const0> ));
  LUT1 #(
    .INIT(2'h1)) 
    \LED_PIPE_Leds_a0[0]_i_1 
       (.I0(LED_PIPE_Leds_a0[0]),
        .O(LED_PIPE_Leds_n10_in[0]));
  FDSE \LED_PIPE_Leds_a0_reg[0] 
       (.C(clkF_LED_PIPE_refresh_a1),
        .CE(\<const1> ),
        .D(LED_PIPE_Leds_n10_in[0]),
        .Q(LED_PIPE_Leds_a0[0]),
        .S(reset_IBUF));
  FDRE \LED_PIPE_Leds_a0_reg[10] 
       (.C(clkF_LED_PIPE_refresh_a1),
        .CE(\<const1> ),
        .D(LED_PIPE_Leds_n10_in[10]),
        .Q(LED_PIPE_Leds_a0[10]),
        .R(reset_IBUF));
  FDRE \LED_PIPE_Leds_a0_reg[11] 
       (.C(clkF_LED_PIPE_refresh_a1),
        .CE(\<const1> ),
        .D(LED_PIPE_Leds_n10_in[11]),
        .Q(LED_PIPE_Leds_a0[11]),
        .R(reset_IBUF));
  FDRE \LED_PIPE_Leds_a0_reg[12] 
       (.C(clkF_LED_PIPE_refresh_a1),
        .CE(\<const1> ),
        .D(LED_PIPE_Leds_n10_in[12]),
        .Q(LED_PIPE_Leds_a0[12]),
        .R(reset_IBUF));
  (* ADDER_THRESHOLD = "35" *) 
  (* OPT_MODIFIED = "SWEEP" *) 
  CARRY4 \LED_PIPE_Leds_a0_reg[12]_i_1 
       (.CI(\LED_PIPE_Leds_a0_reg[8]_i_1_n_0 ),
        .CO({\LED_PIPE_Leds_a0_reg[12]_i_1_n_0 ,\NLW_LED_PIPE_Leds_a0_reg[12]_i_1_CO_UNCONNECTED [2:0]}),
        .CYINIT(\<const0> ),
        .DI({\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .O(LED_PIPE_Leds_n10_in[12:9]),
        .S(LED_PIPE_Leds_a0[12:9]));
  FDRE \LED_PIPE_Leds_a0_reg[13] 
       (.C(clkF_LED_PIPE_refresh_a1),
        .CE(\<const1> ),
        .D(LED_PIPE_Leds_n10_in[13]),
        .Q(LED_PIPE_Leds_a0[13]),
        .R(reset_IBUF));
  FDRE \LED_PIPE_Leds_a0_reg[14] 
       (.C(clkF_LED_PIPE_refresh_a1),
        .CE(\<const1> ),
        .D(LED_PIPE_Leds_n10_in[14]),
        .Q(LED_PIPE_Leds_a0[14]),
        .R(reset_IBUF));
  FDRE \LED_PIPE_Leds_a0_reg[15] 
       (.C(clkF_LED_PIPE_refresh_a1),
        .CE(\<const1> ),
        .D(LED_PIPE_Leds_n10_in[15]),
        .Q(LED_PIPE_Leds_a0[15]),
        .R(reset_IBUF));
  (* ADDER_THRESHOLD = "35" *) 
  (* OPT_MODIFIED = "SWEEP" *) 
  CARRY4 \LED_PIPE_Leds_a0_reg[15]_i_1 
       (.CI(\LED_PIPE_Leds_a0_reg[12]_i_1_n_0 ),
        .CYINIT(\<const0> ),
        .DI({\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .O(LED_PIPE_Leds_n10_in[15:13]),
        .S({\<const0> ,LED_PIPE_Leds_a0[15:13]}));
  FDRE \LED_PIPE_Leds_a0_reg[1] 
       (.C(clkF_LED_PIPE_refresh_a1),
        .CE(\<const1> ),
        .D(LED_PIPE_Leds_n10_in[1]),
        .Q(LED_PIPE_Leds_a0[1]),
        .R(reset_IBUF));
  FDRE \LED_PIPE_Leds_a0_reg[2] 
       (.C(clkF_LED_PIPE_refresh_a1),
        .CE(\<const1> ),
        .D(LED_PIPE_Leds_n10_in[2]),
        .Q(LED_PIPE_Leds_a0[2]),
        .R(reset_IBUF));
  FDRE \LED_PIPE_Leds_a0_reg[3] 
       (.C(clkF_LED_PIPE_refresh_a1),
        .CE(\<const1> ),
        .D(LED_PIPE_Leds_n10_in[3]),
        .Q(LED_PIPE_Leds_a0[3]),
        .R(reset_IBUF));
  FDRE \LED_PIPE_Leds_a0_reg[4] 
       (.C(clkF_LED_PIPE_refresh_a1),
        .CE(\<const1> ),
        .D(LED_PIPE_Leds_n10_in[4]),
        .Q(LED_PIPE_Leds_a0[4]),
        .R(reset_IBUF));
  (* ADDER_THRESHOLD = "35" *) 
  (* OPT_MODIFIED = "SWEEP" *) 
  CARRY4 \LED_PIPE_Leds_a0_reg[4]_i_1 
       (.CI(\<const0> ),
        .CO({\LED_PIPE_Leds_a0_reg[4]_i_1_n_0 ,\NLW_LED_PIPE_Leds_a0_reg[4]_i_1_CO_UNCONNECTED [2:0]}),
        .CYINIT(LED_PIPE_Leds_a0[0]),
        .DI({\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .O(LED_PIPE_Leds_n10_in[4:1]),
        .S(LED_PIPE_Leds_a0[4:1]));
  FDRE \LED_PIPE_Leds_a0_reg[5] 
       (.C(clkF_LED_PIPE_refresh_a1),
        .CE(\<const1> ),
        .D(LED_PIPE_Leds_n10_in[5]),
        .Q(LED_PIPE_Leds_a0[5]),
        .R(reset_IBUF));
  FDRE \LED_PIPE_Leds_a0_reg[6] 
       (.C(clkF_LED_PIPE_refresh_a1),
        .CE(\<const1> ),
        .D(LED_PIPE_Leds_n10_in[6]),
        .Q(LED_PIPE_Leds_a0[6]),
        .R(reset_IBUF));
  FDRE \LED_PIPE_Leds_a0_reg[7] 
       (.C(clkF_LED_PIPE_refresh_a1),
        .CE(\<const1> ),
        .D(LED_PIPE_Leds_n10_in[7]),
        .Q(LED_PIPE_Leds_a0[7]),
        .R(reset_IBUF));
  FDRE \LED_PIPE_Leds_a0_reg[8] 
       (.C(clkF_LED_PIPE_refresh_a1),
        .CE(\<const1> ),
        .D(LED_PIPE_Leds_n10_in[8]),
        .Q(LED_PIPE_Leds_a0[8]),
        .R(reset_IBUF));
  (* ADDER_THRESHOLD = "35" *) 
  (* OPT_MODIFIED = "SWEEP" *) 
  CARRY4 \LED_PIPE_Leds_a0_reg[8]_i_1 
       (.CI(\LED_PIPE_Leds_a0_reg[4]_i_1_n_0 ),
        .CO({\LED_PIPE_Leds_a0_reg[8]_i_1_n_0 ,\NLW_LED_PIPE_Leds_a0_reg[8]_i_1_CO_UNCONNECTED [2:0]}),
        .CYINIT(\<const0> ),
        .DI({\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .O(LED_PIPE_Leds_n10_in[8:5]),
        .S(LED_PIPE_Leds_a0[8:5]));
  FDRE \LED_PIPE_Leds_a0_reg[9] 
       (.C(clkF_LED_PIPE_refresh_a1),
        .CE(\<const1> ),
        .D(LED_PIPE_Leds_n10_in[9]),
        .Q(LED_PIPE_Leds_a0[9]),
        .R(reset_IBUF));
  (* \PinAttr:I0:HOLD_DETOUR  = "195" *) 
  LUT1 #(
    .INIT(2'h1)) 
    \LED_PIPE_count1_a1[0]_i_1 
       (.I0(LED_PIPE_count1_a1[0]),
        .O(\LED_PIPE_count1_a1[0]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hBBBFBFBF)) 
    \LED_PIPE_count1_a1[31]_i_1 
       (.I0(LED_PIPE_rst1_a1),
        .I1(gen_clkF_LED_PIPE_refresh_a1_n_2),
        .I2(gen_clkF_LED_PIPE_refresh_a1_n_1),
        .I3(gen_clkF_LED_PIPE_refresh_a1_n_0),
        .I4(\LED_PIPE_count1_a1[31]_i_4_n_0 ),
        .O(\LED_PIPE_count1_a1[31]_i_1_n_0 ));
  (* \PinAttr:I1:HOLD_DETOUR  = "195" *) 
  LUT4 #(
    .INIT(16'hBFFF)) 
    \LED_PIPE_count1_a1[31]_i_4 
       (.I0(\LED_PIPE_count1_a1[31]_i_5_n_0 ),
        .I1(LED_PIPE_count1_a1[0]),
        .I2(LED_PIPE_count1_a1[5]),
        .I3(LED_PIPE_count1_a1[6]),
        .O(\LED_PIPE_count1_a1[31]_i_4_n_0 ));
  LUT4 #(
    .INIT(16'h7FFF)) 
    \LED_PIPE_count1_a1[31]_i_5 
       (.I0(LED_PIPE_count1_a1[2]),
        .I1(LED_PIPE_count1_a1[1]),
        .I2(LED_PIPE_count1_a1[4]),
        .I3(LED_PIPE_count1_a1[3]),
        .O(\LED_PIPE_count1_a1[31]_i_5_n_0 ));
  FDRE \LED_PIPE_count1_a1_reg[0] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\LED_PIPE_count1_a1[0]_i_1_n_0 ),
        .Q(LED_PIPE_count1_a1[0]),
        .R(\LED_PIPE_count1_a1[31]_i_1_n_0 ));
  FDRE \LED_PIPE_count1_a1_reg[10] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\LED_PIPE_count1_a1_reg[12]_i_1_n_6 ),
        .Q(LED_PIPE_count1_a1[10]),
        .R(\LED_PIPE_count1_a1[31]_i_1_n_0 ));
  FDRE \LED_PIPE_count1_a1_reg[11] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\LED_PIPE_count1_a1_reg[12]_i_1_n_5 ),
        .Q(LED_PIPE_count1_a1[11]),
        .R(\LED_PIPE_count1_a1[31]_i_1_n_0 ));
  FDRE \LED_PIPE_count1_a1_reg[12] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\LED_PIPE_count1_a1_reg[12]_i_1_n_4 ),
        .Q(LED_PIPE_count1_a1[12]),
        .R(\LED_PIPE_count1_a1[31]_i_1_n_0 ));
  (* ADDER_THRESHOLD = "35" *) 
  (* OPT_MODIFIED = "SWEEP" *) 
  CARRY4 \LED_PIPE_count1_a1_reg[12]_i_1 
       (.CI(\LED_PIPE_count1_a1_reg[8]_i_1_n_0 ),
        .CO({\LED_PIPE_count1_a1_reg[12]_i_1_n_0 ,\NLW_LED_PIPE_count1_a1_reg[12]_i_1_CO_UNCONNECTED [2:0]}),
        .CYINIT(\<const0> ),
        .DI({\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .O({\LED_PIPE_count1_a1_reg[12]_i_1_n_4 ,\LED_PIPE_count1_a1_reg[12]_i_1_n_5 ,\LED_PIPE_count1_a1_reg[12]_i_1_n_6 ,\LED_PIPE_count1_a1_reg[12]_i_1_n_7 }),
        .S(LED_PIPE_count1_a1[12:9]));
  FDRE \LED_PIPE_count1_a1_reg[13] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\LED_PIPE_count1_a1_reg[16]_i_1_n_7 ),
        .Q(LED_PIPE_count1_a1[13]),
        .R(\LED_PIPE_count1_a1[31]_i_1_n_0 ));
  FDRE \LED_PIPE_count1_a1_reg[14] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\LED_PIPE_count1_a1_reg[16]_i_1_n_6 ),
        .Q(LED_PIPE_count1_a1[14]),
        .R(\LED_PIPE_count1_a1[31]_i_1_n_0 ));
  FDRE \LED_PIPE_count1_a1_reg[15] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\LED_PIPE_count1_a1_reg[16]_i_1_n_5 ),
        .Q(LED_PIPE_count1_a1[15]),
        .R(\LED_PIPE_count1_a1[31]_i_1_n_0 ));
  FDRE \LED_PIPE_count1_a1_reg[16] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\LED_PIPE_count1_a1_reg[16]_i_1_n_4 ),
        .Q(LED_PIPE_count1_a1[16]),
        .R(\LED_PIPE_count1_a1[31]_i_1_n_0 ));
  (* ADDER_THRESHOLD = "35" *) 
  (* OPT_MODIFIED = "SWEEP" *) 
  CARRY4 \LED_PIPE_count1_a1_reg[16]_i_1 
       (.CI(\LED_PIPE_count1_a1_reg[12]_i_1_n_0 ),
        .CO({\LED_PIPE_count1_a1_reg[16]_i_1_n_0 ,\NLW_LED_PIPE_count1_a1_reg[16]_i_1_CO_UNCONNECTED [2:0]}),
        .CYINIT(\<const0> ),
        .DI({\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .O({\LED_PIPE_count1_a1_reg[16]_i_1_n_4 ,\LED_PIPE_count1_a1_reg[16]_i_1_n_5 ,\LED_PIPE_count1_a1_reg[16]_i_1_n_6 ,\LED_PIPE_count1_a1_reg[16]_i_1_n_7 }),
        .S(LED_PIPE_count1_a1[16:13]));
  FDRE \LED_PIPE_count1_a1_reg[17] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\LED_PIPE_count1_a1_reg[20]_i_1_n_7 ),
        .Q(LED_PIPE_count1_a1[17]),
        .R(\LED_PIPE_count1_a1[31]_i_1_n_0 ));
  FDRE \LED_PIPE_count1_a1_reg[18] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\LED_PIPE_count1_a1_reg[20]_i_1_n_6 ),
        .Q(LED_PIPE_count1_a1[18]),
        .R(\LED_PIPE_count1_a1[31]_i_1_n_0 ));
  FDRE \LED_PIPE_count1_a1_reg[19] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\LED_PIPE_count1_a1_reg[20]_i_1_n_5 ),
        .Q(LED_PIPE_count1_a1[19]),
        .R(\LED_PIPE_count1_a1[31]_i_1_n_0 ));
  FDRE \LED_PIPE_count1_a1_reg[1] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\LED_PIPE_count1_a1_reg[4]_i_1_n_7 ),
        .Q(LED_PIPE_count1_a1[1]),
        .R(\LED_PIPE_count1_a1[31]_i_1_n_0 ));
  FDRE \LED_PIPE_count1_a1_reg[20] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\LED_PIPE_count1_a1_reg[20]_i_1_n_4 ),
        .Q(LED_PIPE_count1_a1[20]),
        .R(\LED_PIPE_count1_a1[31]_i_1_n_0 ));
  (* ADDER_THRESHOLD = "35" *) 
  (* OPT_MODIFIED = "SWEEP" *) 
  CARRY4 \LED_PIPE_count1_a1_reg[20]_i_1 
       (.CI(\LED_PIPE_count1_a1_reg[16]_i_1_n_0 ),
        .CO({\LED_PIPE_count1_a1_reg[20]_i_1_n_0 ,\NLW_LED_PIPE_count1_a1_reg[20]_i_1_CO_UNCONNECTED [2:0]}),
        .CYINIT(\<const0> ),
        .DI({\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .O({\LED_PIPE_count1_a1_reg[20]_i_1_n_4 ,\LED_PIPE_count1_a1_reg[20]_i_1_n_5 ,\LED_PIPE_count1_a1_reg[20]_i_1_n_6 ,\LED_PIPE_count1_a1_reg[20]_i_1_n_7 }),
        .S(LED_PIPE_count1_a1[20:17]));
  FDRE \LED_PIPE_count1_a1_reg[21] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\LED_PIPE_count1_a1_reg[24]_i_1_n_7 ),
        .Q(LED_PIPE_count1_a1[21]),
        .R(\LED_PIPE_count1_a1[31]_i_1_n_0 ));
  FDRE \LED_PIPE_count1_a1_reg[22] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\LED_PIPE_count1_a1_reg[24]_i_1_n_6 ),
        .Q(LED_PIPE_count1_a1[22]),
        .R(\LED_PIPE_count1_a1[31]_i_1_n_0 ));
  FDRE \LED_PIPE_count1_a1_reg[23] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\LED_PIPE_count1_a1_reg[24]_i_1_n_5 ),
        .Q(LED_PIPE_count1_a1[23]),
        .R(\LED_PIPE_count1_a1[31]_i_1_n_0 ));
  FDRE \LED_PIPE_count1_a1_reg[24] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\LED_PIPE_count1_a1_reg[24]_i_1_n_4 ),
        .Q(LED_PIPE_count1_a1[24]),
        .R(\LED_PIPE_count1_a1[31]_i_1_n_0 ));
  (* ADDER_THRESHOLD = "35" *) 
  (* OPT_MODIFIED = "SWEEP" *) 
  CARRY4 \LED_PIPE_count1_a1_reg[24]_i_1 
       (.CI(\LED_PIPE_count1_a1_reg[20]_i_1_n_0 ),
        .CO({\LED_PIPE_count1_a1_reg[24]_i_1_n_0 ,\NLW_LED_PIPE_count1_a1_reg[24]_i_1_CO_UNCONNECTED [2:0]}),
        .CYINIT(\<const0> ),
        .DI({\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .O({\LED_PIPE_count1_a1_reg[24]_i_1_n_4 ,\LED_PIPE_count1_a1_reg[24]_i_1_n_5 ,\LED_PIPE_count1_a1_reg[24]_i_1_n_6 ,\LED_PIPE_count1_a1_reg[24]_i_1_n_7 }),
        .S(LED_PIPE_count1_a1[24:21]));
  FDRE \LED_PIPE_count1_a1_reg[25] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\LED_PIPE_count1_a1_reg[28]_i_1_n_7 ),
        .Q(LED_PIPE_count1_a1[25]),
        .R(\LED_PIPE_count1_a1[31]_i_1_n_0 ));
  FDRE \LED_PIPE_count1_a1_reg[26] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\LED_PIPE_count1_a1_reg[28]_i_1_n_6 ),
        .Q(LED_PIPE_count1_a1[26]),
        .R(\LED_PIPE_count1_a1[31]_i_1_n_0 ));
  FDRE \LED_PIPE_count1_a1_reg[27] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\LED_PIPE_count1_a1_reg[28]_i_1_n_5 ),
        .Q(LED_PIPE_count1_a1[27]),
        .R(\LED_PIPE_count1_a1[31]_i_1_n_0 ));
  FDRE \LED_PIPE_count1_a1_reg[28] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\LED_PIPE_count1_a1_reg[28]_i_1_n_4 ),
        .Q(LED_PIPE_count1_a1[28]),
        .R(\LED_PIPE_count1_a1[31]_i_1_n_0 ));
  (* ADDER_THRESHOLD = "35" *) 
  (* OPT_MODIFIED = "SWEEP" *) 
  CARRY4 \LED_PIPE_count1_a1_reg[28]_i_1 
       (.CI(\LED_PIPE_count1_a1_reg[24]_i_1_n_0 ),
        .CO({\LED_PIPE_count1_a1_reg[28]_i_1_n_0 ,\NLW_LED_PIPE_count1_a1_reg[28]_i_1_CO_UNCONNECTED [2:0]}),
        .CYINIT(\<const0> ),
        .DI({\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .O({\LED_PIPE_count1_a1_reg[28]_i_1_n_4 ,\LED_PIPE_count1_a1_reg[28]_i_1_n_5 ,\LED_PIPE_count1_a1_reg[28]_i_1_n_6 ,\LED_PIPE_count1_a1_reg[28]_i_1_n_7 }),
        .S(LED_PIPE_count1_a1[28:25]));
  FDRE \LED_PIPE_count1_a1_reg[29] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\LED_PIPE_count1_a1_reg[31]_i_2_n_7 ),
        .Q(LED_PIPE_count1_a1[29]),
        .R(\LED_PIPE_count1_a1[31]_i_1_n_0 ));
  FDRE \LED_PIPE_count1_a1_reg[2] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\LED_PIPE_count1_a1_reg[4]_i_1_n_6 ),
        .Q(LED_PIPE_count1_a1[2]),
        .R(\LED_PIPE_count1_a1[31]_i_1_n_0 ));
  FDRE \LED_PIPE_count1_a1_reg[30] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\LED_PIPE_count1_a1_reg[31]_i_2_n_6 ),
        .Q(LED_PIPE_count1_a1[30]),
        .R(\LED_PIPE_count1_a1[31]_i_1_n_0 ));
  FDRE \LED_PIPE_count1_a1_reg[31] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\LED_PIPE_count1_a1_reg[31]_i_2_n_5 ),
        .Q(LED_PIPE_count1_a1[31]),
        .R(\LED_PIPE_count1_a1[31]_i_1_n_0 ));
  (* ADDER_THRESHOLD = "35" *) 
  (* OPT_MODIFIED = "SWEEP" *) 
  CARRY4 \LED_PIPE_count1_a1_reg[31]_i_2 
       (.CI(\LED_PIPE_count1_a1_reg[28]_i_1_n_0 ),
        .CYINIT(\<const0> ),
        .DI({\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .O({\LED_PIPE_count1_a1_reg[31]_i_2_n_5 ,\LED_PIPE_count1_a1_reg[31]_i_2_n_6 ,\LED_PIPE_count1_a1_reg[31]_i_2_n_7 }),
        .S({\<const0> ,LED_PIPE_count1_a1[31:29]}));
  FDRE \LED_PIPE_count1_a1_reg[3] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\LED_PIPE_count1_a1_reg[4]_i_1_n_5 ),
        .Q(LED_PIPE_count1_a1[3]),
        .R(\LED_PIPE_count1_a1[31]_i_1_n_0 ));
  FDRE \LED_PIPE_count1_a1_reg[4] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\LED_PIPE_count1_a1_reg[4]_i_1_n_4 ),
        .Q(LED_PIPE_count1_a1[4]),
        .R(\LED_PIPE_count1_a1[31]_i_1_n_0 ));
  (* ADDER_THRESHOLD = "35" *) 
  (* OPT_MODIFIED = "SWEEP" *) 
  CARRY4 \LED_PIPE_count1_a1_reg[4]_i_1 
       (.CI(\<const0> ),
        .CO({\LED_PIPE_count1_a1_reg[4]_i_1_n_0 ,\NLW_LED_PIPE_count1_a1_reg[4]_i_1_CO_UNCONNECTED [2:0]}),
        .CYINIT(LED_PIPE_count1_a1[0]),
        .DI({\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .O({\LED_PIPE_count1_a1_reg[4]_i_1_n_4 ,\LED_PIPE_count1_a1_reg[4]_i_1_n_5 ,\LED_PIPE_count1_a1_reg[4]_i_1_n_6 ,\LED_PIPE_count1_a1_reg[4]_i_1_n_7 }),
        .S(LED_PIPE_count1_a1[4:1]));
  FDRE \LED_PIPE_count1_a1_reg[5] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\LED_PIPE_count1_a1_reg[8]_i_1_n_7 ),
        .Q(LED_PIPE_count1_a1[5]),
        .R(\LED_PIPE_count1_a1[31]_i_1_n_0 ));
  FDRE \LED_PIPE_count1_a1_reg[6] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\LED_PIPE_count1_a1_reg[8]_i_1_n_6 ),
        .Q(LED_PIPE_count1_a1[6]),
        .R(\LED_PIPE_count1_a1[31]_i_1_n_0 ));
  FDRE \LED_PIPE_count1_a1_reg[7] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\LED_PIPE_count1_a1_reg[8]_i_1_n_5 ),
        .Q(LED_PIPE_count1_a1[7]),
        .R(\LED_PIPE_count1_a1[31]_i_1_n_0 ));
  FDRE \LED_PIPE_count1_a1_reg[8] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\LED_PIPE_count1_a1_reg[8]_i_1_n_4 ),
        .Q(LED_PIPE_count1_a1[8]),
        .R(\LED_PIPE_count1_a1[31]_i_1_n_0 ));
  (* ADDER_THRESHOLD = "35" *) 
  (* OPT_MODIFIED = "SWEEP" *) 
  CARRY4 \LED_PIPE_count1_a1_reg[8]_i_1 
       (.CI(\LED_PIPE_count1_a1_reg[4]_i_1_n_0 ),
        .CO({\LED_PIPE_count1_a1_reg[8]_i_1_n_0 ,\NLW_LED_PIPE_count1_a1_reg[8]_i_1_CO_UNCONNECTED [2:0]}),
        .CYINIT(\<const0> ),
        .DI({\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .O({\LED_PIPE_count1_a1_reg[8]_i_1_n_4 ,\LED_PIPE_count1_a1_reg[8]_i_1_n_5 ,\LED_PIPE_count1_a1_reg[8]_i_1_n_6 ,\LED_PIPE_count1_a1_reg[8]_i_1_n_7 }),
        .S(LED_PIPE_count1_a1[8:5]));
  FDRE \LED_PIPE_count1_a1_reg[9] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(\LED_PIPE_count1_a1_reg[12]_i_1_n_7 ),
        .Q(LED_PIPE_count1_a1[9]),
        .R(\LED_PIPE_count1_a1[31]_i_1_n_0 ));
  FDRE LED_PIPE_rst1_a1_reg
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(reset_IBUF),
        .Q(LED_PIPE_rst1_a1),
        .R(\<const0> ));
  VCC VCC
       (.P(\<const1> ));
  BUFG clk_IBUF_BUFG_inst
       (.I(clk_IBUF),
        .O(clk_IBUF_BUFG));
  IBUF clk_IBUF_inst
       (.I(clk),
        .O(clk_IBUF));
  clk_gate gen_clkF_LED_PIPE_refresh_a1
       (.CLK(clkF_LED_PIPE_refresh_a1),
        .LED_PIPE_count1_a1({LED_PIPE_count1_a1[31:7],LED_PIPE_count1_a1[0]}),
        .\LED_PIPE_count1_a1_reg[11] (gen_clkF_LED_PIPE_refresh_a1_n_0),
        .\LED_PIPE_count1_a1_reg[24] (gen_clkF_LED_PIPE_refresh_a1_n_1),
        .\LED_PIPE_count1_a1_reg[28] (gen_clkF_LED_PIPE_refresh_a1_n_2),
        .LED_PIPE_rst1_a1(LED_PIPE_rst1_a1),
        .O({\LED_PIPE_count1_a1_reg[4]_i_1_n_4 ,\LED_PIPE_count1_a1_reg[4]_i_1_n_5 ,\LED_PIPE_count1_a1_reg[4]_i_1_n_6 ,\LED_PIPE_count1_a1_reg[4]_i_1_n_7 }),
        .clk_IBUF(clk_IBUF),
        .clk_IBUF_BUFG(clk_IBUF_BUFG),
        .latched_clk_en_reg_i_3_0({\LED_PIPE_count1_a1_reg[16]_i_1_n_4 ,\LED_PIPE_count1_a1_reg[16]_i_1_n_5 ,\LED_PIPE_count1_a1_reg[16]_i_1_n_6 ,\LED_PIPE_count1_a1_reg[16]_i_1_n_7 }),
        .latched_clk_en_reg_i_3_1({\LED_PIPE_count1_a1_reg[20]_i_1_n_4 ,\LED_PIPE_count1_a1_reg[20]_i_1_n_5 ,\LED_PIPE_count1_a1_reg[20]_i_1_n_6 ,\LED_PIPE_count1_a1_reg[20]_i_1_n_7 }),
        .latched_clk_en_reg_i_3_2({\LED_PIPE_count1_a1_reg[24]_i_1_n_4 ,\LED_PIPE_count1_a1_reg[24]_i_1_n_5 ,\LED_PIPE_count1_a1_reg[24]_i_1_n_6 ,\LED_PIPE_count1_a1_reg[24]_i_1_n_7 }),
        .latched_clk_en_reg_i_3_3({\LED_PIPE_count1_a1_reg[28]_i_1_n_4 ,\LED_PIPE_count1_a1_reg[28]_i_1_n_5 ,\LED_PIPE_count1_a1_reg[28]_i_1_n_6 ,\LED_PIPE_count1_a1_reg[28]_i_1_n_7 }),
        .latched_clk_en_reg_i_3_4({\LED_PIPE_count1_a1_reg[31]_i_2_n_5 ,\LED_PIPE_count1_a1_reg[31]_i_2_n_6 ,\LED_PIPE_count1_a1_reg[31]_i_2_n_7 }),
        .latched_clk_en_reg_i_6_0({\LED_PIPE_count1_a1_reg[12]_i_1_n_4 ,\LED_PIPE_count1_a1_reg[12]_i_1_n_5 ,\LED_PIPE_count1_a1_reg[12]_i_1_n_6 ,\LED_PIPE_count1_a1_reg[12]_i_1_n_7 }),
        .latched_clk_en_reg_i_6_1({\LED_PIPE_count1_a1_reg[8]_i_1_n_4 ,\LED_PIPE_count1_a1_reg[8]_i_1_n_5 ,\LED_PIPE_count1_a1_reg[8]_i_1_n_6 ,\LED_PIPE_count1_a1_reg[8]_i_1_n_7 }));
  OBUF \led_OBUF[0]_inst 
       (.I(led_OBUF[0]),
        .O(led[0]));
  OBUF \led_OBUF[10]_inst 
       (.I(led_OBUF[10]),
        .O(led[10]));
  OBUF \led_OBUF[11]_inst 
       (.I(led_OBUF[11]),
        .O(led[11]));
  OBUF \led_OBUF[12]_inst 
       (.I(led_OBUF[12]),
        .O(led[12]));
  OBUF \led_OBUF[13]_inst 
       (.I(led_OBUF[13]),
        .O(led[13]));
  OBUF \led_OBUF[14]_inst 
       (.I(led_OBUF[14]),
        .O(led[14]));
  OBUF \led_OBUF[15]_inst 
       (.I(led_OBUF[15]),
        .O(led[15]));
  OBUF \led_OBUF[1]_inst 
       (.I(led_OBUF[1]),
        .O(led[1]));
  OBUF \led_OBUF[2]_inst 
       (.I(led_OBUF[2]),
        .O(led[2]));
  OBUF \led_OBUF[3]_inst 
       (.I(led_OBUF[3]),
        .O(led[3]));
  OBUF \led_OBUF[4]_inst 
       (.I(led_OBUF[4]),
        .O(led[4]));
  OBUF \led_OBUF[5]_inst 
       (.I(led_OBUF[5]),
        .O(led[5]));
  OBUF \led_OBUF[6]_inst 
       (.I(led_OBUF[6]),
        .O(led[6]));
  OBUF \led_OBUF[7]_inst 
       (.I(led_OBUF[7]),
        .O(led[7]));
  OBUF \led_OBUF[8]_inst 
       (.I(led_OBUF[8]),
        .O(led[8]));
  OBUF \led_OBUF[9]_inst 
       (.I(led_OBUF[9]),
        .O(led[9]));
  FDRE \led_reg[0] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(LED_PIPE_Leds_a0[0]),
        .Q(led_OBUF[0]),
        .R(\<const0> ));
  FDRE \led_reg[10] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(LED_PIPE_Leds_a0[10]),
        .Q(led_OBUF[10]),
        .R(\<const0> ));
  FDRE \led_reg[11] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(LED_PIPE_Leds_a0[11]),
        .Q(led_OBUF[11]),
        .R(\<const0> ));
  (* \PinAttr:D:HOLD_DETOUR  = "1103" *) 
  FDRE \led_reg[12] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(LED_PIPE_Leds_a0[12]),
        .Q(led_OBUF[12]),
        .R(\<const0> ));
  FDRE \led_reg[13] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(LED_PIPE_Leds_a0[13]),
        .Q(led_OBUF[13]),
        .R(\<const0> ));
  (* \PinAttr:D:HOLD_DETOUR  = "1215" *) 
  FDRE \led_reg[14] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(LED_PIPE_Leds_a0[14]),
        .Q(led_OBUF[14]),
        .R(\<const0> ));
  FDRE \led_reg[15] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(LED_PIPE_Leds_a0[15]),
        .Q(led_OBUF[15]),
        .R(\<const0> ));
  FDRE \led_reg[1] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(LED_PIPE_Leds_a0[1]),
        .Q(led_OBUF[1]),
        .R(\<const0> ));
  (* \PinAttr:D:HOLD_DETOUR  = "1178" *) 
  FDRE \led_reg[2] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(LED_PIPE_Leds_a0[2]),
        .Q(led_OBUF[2]),
        .R(\<const0> ));
  (* \PinAttr:D:HOLD_DETOUR  = "1307" *) 
  FDRE \led_reg[3] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(LED_PIPE_Leds_a0[3]),
        .Q(led_OBUF[3]),
        .R(\<const0> ));
  FDRE \led_reg[4] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(LED_PIPE_Leds_a0[4]),
        .Q(led_OBUF[4]),
        .R(\<const0> ));
  FDRE \led_reg[5] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(LED_PIPE_Leds_a0[5]),
        .Q(led_OBUF[5]),
        .R(\<const0> ));
  FDRE \led_reg[6] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(LED_PIPE_Leds_a0[6]),
        .Q(led_OBUF[6]),
        .R(\<const0> ));
  FDRE \led_reg[7] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(LED_PIPE_Leds_a0[7]),
        .Q(led_OBUF[7]),
        .R(\<const0> ));
  FDRE \led_reg[8] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(LED_PIPE_Leds_a0[8]),
        .Q(led_OBUF[8]),
        .R(\<const0> ));
  FDRE \led_reg[9] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(LED_PIPE_Leds_a0[9]),
        .Q(led_OBUF[9]),
        .R(\<const0> ));
  IBUF reset_IBUF_inst
       (.I(reset),
        .O(reset_IBUF));
endmodule
