// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2020.2 (lin64) Build 3064766 Wed Nov 18 09:12:47 MST 2020
// Date        : Thu Jul 15 21:51:42 2021
// Host        : ATOM running 64-bit Ubuntu 20.04.1 LTS
// Command     : write_verilog -force ./out_led_counter_xc7a35tcpg236-1/FPGA_led_counter/fpga_impl_netlist.v
// Design      : top
// Purpose     : This is a Verilog netlist of the current design or from a specific cell of the design. The output is an
//               IEEE 1364-2001 compliant Verilog HDL file that contains netlist information obtained from the input
//               design files.
// Device      : xc7a35tcpg236-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module clock_divider
   (divided_clk_reg_0,
    clk_IBUF_BUFG);
  output divided_clk_reg_0;
  input clk_IBUF_BUFG;

  wire \<const0> ;
  wire \<const1> ;
  wire clk_IBUF_BUFG;
  wire [31:0]counter_value;
  wire counter_value0_carry__0_n_0;
  wire counter_value0_carry__1_n_0;
  wire counter_value0_carry__2_n_0;
  wire counter_value0_carry__3_n_0;
  wire counter_value0_carry__4_n_0;
  wire counter_value0_carry__5_n_0;
  wire counter_value0_carry_n_0;
  wire \counter_value[31]_i_2_n_0 ;
  wire \counter_value[31]_i_3_n_0 ;
  wire \counter_value[31]_i_4_n_0 ;
  wire \counter_value[31]_i_5_n_0 ;
  wire \counter_value[31]_i_6_n_0 ;
  wire \counter_value[31]_i_7_n_0 ;
  wire \counter_value[31]_i_8_n_0 ;
  wire \counter_value[31]_i_9_n_0 ;
  wire [0:0]counter_value_0;
  wire [31:1]data0;
  wire divided_clk;
  wire divided_clk_i_1_n_0;
  wire divided_clk_reg_0;
  wire [3:0]NLW_counter_value0_carry_CO_UNCONNECTED;
  wire [3:0]NLW_counter_value0_carry__0_CO_UNCONNECTED;
  wire [3:0]NLW_counter_value0_carry__1_CO_UNCONNECTED;
  wire [3:0]NLW_counter_value0_carry__2_CO_UNCONNECTED;
  wire [3:0]NLW_counter_value0_carry__3_CO_UNCONNECTED;
  wire [3:0]NLW_counter_value0_carry__4_CO_UNCONNECTED;
  wire [3:0]NLW_counter_value0_carry__5_CO_UNCONNECTED;

  GND GND
       (.G(\<const0> ));
  VCC VCC
       (.P(\<const1> ));
  (* ADDER_THRESHOLD = "35" *) 
  (* OPT_MODIFIED = "SWEEP" *) 
  CARRY4 counter_value0_carry
       (.CI(\<const0> ),
        .CO({counter_value0_carry_n_0,NLW_counter_value0_carry_CO_UNCONNECTED[2:0]}),
        .CYINIT(counter_value[0]),
        .DI({\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .O(data0[4:1]),
        .S(counter_value[4:1]));
  (* ADDER_THRESHOLD = "35" *) 
  (* OPT_MODIFIED = "SWEEP" *) 
  CARRY4 counter_value0_carry__0
       (.CI(counter_value0_carry_n_0),
        .CO({counter_value0_carry__0_n_0,NLW_counter_value0_carry__0_CO_UNCONNECTED[2:0]}),
        .CYINIT(\<const0> ),
        .DI({\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .O(data0[8:5]),
        .S(counter_value[8:5]));
  (* ADDER_THRESHOLD = "35" *) 
  (* OPT_MODIFIED = "SWEEP" *) 
  CARRY4 counter_value0_carry__1
       (.CI(counter_value0_carry__0_n_0),
        .CO({counter_value0_carry__1_n_0,NLW_counter_value0_carry__1_CO_UNCONNECTED[2:0]}),
        .CYINIT(\<const0> ),
        .DI({\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .O(data0[12:9]),
        .S(counter_value[12:9]));
  (* ADDER_THRESHOLD = "35" *) 
  (* OPT_MODIFIED = "SWEEP" *) 
  CARRY4 counter_value0_carry__2
       (.CI(counter_value0_carry__1_n_0),
        .CO({counter_value0_carry__2_n_0,NLW_counter_value0_carry__2_CO_UNCONNECTED[2:0]}),
        .CYINIT(\<const0> ),
        .DI({\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .O(data0[16:13]),
        .S(counter_value[16:13]));
  (* ADDER_THRESHOLD = "35" *) 
  (* OPT_MODIFIED = "SWEEP" *) 
  CARRY4 counter_value0_carry__3
       (.CI(counter_value0_carry__2_n_0),
        .CO({counter_value0_carry__3_n_0,NLW_counter_value0_carry__3_CO_UNCONNECTED[2:0]}),
        .CYINIT(\<const0> ),
        .DI({\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .O(data0[20:17]),
        .S(counter_value[20:17]));
  (* ADDER_THRESHOLD = "35" *) 
  (* OPT_MODIFIED = "SWEEP" *) 
  CARRY4 counter_value0_carry__4
       (.CI(counter_value0_carry__3_n_0),
        .CO({counter_value0_carry__4_n_0,NLW_counter_value0_carry__4_CO_UNCONNECTED[2:0]}),
        .CYINIT(\<const0> ),
        .DI({\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .O(data0[24:21]),
        .S(counter_value[24:21]));
  (* ADDER_THRESHOLD = "35" *) 
  (* OPT_MODIFIED = "SWEEP" *) 
  CARRY4 counter_value0_carry__5
       (.CI(counter_value0_carry__4_n_0),
        .CO({counter_value0_carry__5_n_0,NLW_counter_value0_carry__5_CO_UNCONNECTED[2:0]}),
        .CYINIT(\<const0> ),
        .DI({\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .O(data0[28:25]),
        .S(counter_value[28:25]));
  (* ADDER_THRESHOLD = "35" *) 
  (* OPT_MODIFIED = "SWEEP" *) 
  CARRY4 counter_value0_carry__6
       (.CI(counter_value0_carry__5_n_0),
        .CYINIT(\<const0> ),
        .DI({\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .O(data0[31:29]),
        .S({\<const0> ,counter_value[31:29]}));
  LUT1 #(
    .INIT(2'h1)) 
    \counter_value[0]_i_1 
       (.I0(counter_value[0]),
        .O(counter_value_0));
  LUT4 #(
    .INIT(16'h0001)) 
    \counter_value[31]_i_1 
       (.I0(\counter_value[31]_i_2_n_0 ),
        .I1(\counter_value[31]_i_3_n_0 ),
        .I2(\counter_value[31]_i_4_n_0 ),
        .I3(\counter_value[31]_i_5_n_0 ),
        .O(divided_clk));
  LUT5 #(
    .INIT(32'hFFFFF7FF)) 
    \counter_value[31]_i_2 
       (.I0(counter_value[18]),
        .I1(counter_value[19]),
        .I2(counter_value[17]),
        .I3(counter_value[16]),
        .I4(\counter_value[31]_i_6_n_0 ),
        .O(\counter_value[31]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'hFFFFFEFF)) 
    \counter_value[31]_i_3 
       (.I0(counter_value[26]),
        .I1(counter_value[27]),
        .I2(counter_value[25]),
        .I3(counter_value[24]),
        .I4(\counter_value[31]_i_7_n_0 ),
        .O(\counter_value[31]_i_3_n_0 ));
  LUT5 #(
    .INIT(32'hFFFF7FFF)) 
    \counter_value[31]_i_4 
       (.I0(counter_value[2]),
        .I1(counter_value[3]),
        .I2(counter_value[0]),
        .I3(counter_value[1]),
        .I4(\counter_value[31]_i_8_n_0 ),
        .O(\counter_value[31]_i_4_n_0 ));
  LUT5 #(
    .INIT(32'hFFFFFFFB)) 
    \counter_value[31]_i_5 
       (.I0(counter_value[10]),
        .I1(counter_value[11]),
        .I2(counter_value[8]),
        .I3(counter_value[9]),
        .I4(\counter_value[31]_i_9_n_0 ),
        .O(\counter_value[31]_i_5_n_0 ));
  LUT4 #(
    .INIT(16'hFF7F)) 
    \counter_value[31]_i_6 
       (.I0(counter_value[21]),
        .I1(counter_value[20]),
        .I2(counter_value[22]),
        .I3(counter_value[23]),
        .O(\counter_value[31]_i_6_n_0 ));
  LUT4 #(
    .INIT(16'hFFFE)) 
    \counter_value[31]_i_7 
       (.I0(counter_value[29]),
        .I1(counter_value[28]),
        .I2(counter_value[31]),
        .I3(counter_value[30]),
        .O(\counter_value[31]_i_7_n_0 ));
  LUT4 #(
    .INIT(16'hFFF7)) 
    \counter_value[31]_i_8 
       (.I0(counter_value[5]),
        .I1(counter_value[4]),
        .I2(counter_value[7]),
        .I3(counter_value[6]),
        .O(\counter_value[31]_i_8_n_0 ));
  LUT4 #(
    .INIT(16'hFF7F)) 
    \counter_value[31]_i_9 
       (.I0(counter_value[13]),
        .I1(counter_value[12]),
        .I2(counter_value[14]),
        .I3(counter_value[15]),
        .O(\counter_value[31]_i_9_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \counter_value_reg[0] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(counter_value_0),
        .Q(counter_value[0]),
        .R(\<const0> ));
  FDRE #(
    .INIT(1'b0)) 
    \counter_value_reg[10] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(data0[10]),
        .Q(counter_value[10]),
        .R(divided_clk));
  FDRE #(
    .INIT(1'b0)) 
    \counter_value_reg[11] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(data0[11]),
        .Q(counter_value[11]),
        .R(divided_clk));
  FDRE #(
    .INIT(1'b0)) 
    \counter_value_reg[12] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(data0[12]),
        .Q(counter_value[12]),
        .R(divided_clk));
  FDRE #(
    .INIT(1'b0)) 
    \counter_value_reg[13] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(data0[13]),
        .Q(counter_value[13]),
        .R(divided_clk));
  FDRE #(
    .INIT(1'b0)) 
    \counter_value_reg[14] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(data0[14]),
        .Q(counter_value[14]),
        .R(divided_clk));
  FDRE #(
    .INIT(1'b0)) 
    \counter_value_reg[15] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(data0[15]),
        .Q(counter_value[15]),
        .R(divided_clk));
  FDRE #(
    .INIT(1'b0)) 
    \counter_value_reg[16] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(data0[16]),
        .Q(counter_value[16]),
        .R(divided_clk));
  FDRE #(
    .INIT(1'b0)) 
    \counter_value_reg[17] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(data0[17]),
        .Q(counter_value[17]),
        .R(divided_clk));
  FDRE #(
    .INIT(1'b0)) 
    \counter_value_reg[18] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(data0[18]),
        .Q(counter_value[18]),
        .R(divided_clk));
  FDRE #(
    .INIT(1'b0)) 
    \counter_value_reg[19] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(data0[19]),
        .Q(counter_value[19]),
        .R(divided_clk));
  FDRE #(
    .INIT(1'b0)) 
    \counter_value_reg[1] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(data0[1]),
        .Q(counter_value[1]),
        .R(divided_clk));
  FDRE #(
    .INIT(1'b0)) 
    \counter_value_reg[20] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(data0[20]),
        .Q(counter_value[20]),
        .R(divided_clk));
  FDRE #(
    .INIT(1'b0)) 
    \counter_value_reg[21] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(data0[21]),
        .Q(counter_value[21]),
        .R(divided_clk));
  FDRE #(
    .INIT(1'b0)) 
    \counter_value_reg[22] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(data0[22]),
        .Q(counter_value[22]),
        .R(divided_clk));
  FDRE #(
    .INIT(1'b0)) 
    \counter_value_reg[23] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(data0[23]),
        .Q(counter_value[23]),
        .R(divided_clk));
  FDRE #(
    .INIT(1'b0)) 
    \counter_value_reg[24] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(data0[24]),
        .Q(counter_value[24]),
        .R(divided_clk));
  FDRE #(
    .INIT(1'b0)) 
    \counter_value_reg[25] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(data0[25]),
        .Q(counter_value[25]),
        .R(divided_clk));
  FDRE #(
    .INIT(1'b0)) 
    \counter_value_reg[26] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(data0[26]),
        .Q(counter_value[26]),
        .R(divided_clk));
  FDRE #(
    .INIT(1'b0)) 
    \counter_value_reg[27] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(data0[27]),
        .Q(counter_value[27]),
        .R(divided_clk));
  FDRE #(
    .INIT(1'b0)) 
    \counter_value_reg[28] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(data0[28]),
        .Q(counter_value[28]),
        .R(divided_clk));
  FDRE #(
    .INIT(1'b0)) 
    \counter_value_reg[29] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(data0[29]),
        .Q(counter_value[29]),
        .R(divided_clk));
  FDRE #(
    .INIT(1'b0)) 
    \counter_value_reg[2] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(data0[2]),
        .Q(counter_value[2]),
        .R(divided_clk));
  FDRE #(
    .INIT(1'b0)) 
    \counter_value_reg[30] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(data0[30]),
        .Q(counter_value[30]),
        .R(divided_clk));
  FDRE #(
    .INIT(1'b0)) 
    \counter_value_reg[31] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(data0[31]),
        .Q(counter_value[31]),
        .R(divided_clk));
  FDRE #(
    .INIT(1'b0)) 
    \counter_value_reg[3] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(data0[3]),
        .Q(counter_value[3]),
        .R(divided_clk));
  FDRE #(
    .INIT(1'b0)) 
    \counter_value_reg[4] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(data0[4]),
        .Q(counter_value[4]),
        .R(divided_clk));
  FDRE #(
    .INIT(1'b0)) 
    \counter_value_reg[5] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(data0[5]),
        .Q(counter_value[5]),
        .R(divided_clk));
  FDRE #(
    .INIT(1'b0)) 
    \counter_value_reg[6] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(data0[6]),
        .Q(counter_value[6]),
        .R(divided_clk));
  FDRE #(
    .INIT(1'b0)) 
    \counter_value_reg[7] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(data0[7]),
        .Q(counter_value[7]),
        .R(divided_clk));
  FDRE #(
    .INIT(1'b0)) 
    \counter_value_reg[8] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(data0[8]),
        .Q(counter_value[8]),
        .R(divided_clk));
  FDRE #(
    .INIT(1'b0)) 
    \counter_value_reg[9] 
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(data0[9]),
        .Q(counter_value[9]),
        .R(divided_clk));
  LUT5 #(
    .INIT(32'hFFFE0001)) 
    divided_clk_i_1
       (.I0(\counter_value[31]_i_2_n_0 ),
        .I1(\counter_value[31]_i_3_n_0 ),
        .I2(\counter_value[31]_i_4_n_0 ),
        .I3(\counter_value[31]_i_5_n_0 ),
        .I4(divided_clk_reg_0),
        .O(divided_clk_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    divided_clk_reg
       (.C(clk_IBUF_BUFG),
        .CE(\<const1> ),
        .D(divided_clk_i_1_n_0),
        .Q(divided_clk_reg_0),
        .R(\<const0> ));
endmodule

module test
   (led_OBUF,
    reset_IBUF,
    \LED_PIPE_leds_a1_reg[15]_0 );
  output [15:0]led_OBUF;
  input reset_IBUF;
  input \LED_PIPE_leds_a1_reg[15]_0 ;

  wire \<const0> ;
  wire \<const1> ;
  wire LED_PIPE_leds_a0_00_carry__0_n_0;
  wire LED_PIPE_leds_a0_00_carry__0_n_4;
  wire LED_PIPE_leds_a0_00_carry__0_n_5;
  wire LED_PIPE_leds_a0_00_carry__0_n_6;
  wire LED_PIPE_leds_a0_00_carry__0_n_7;
  wire LED_PIPE_leds_a0_00_carry__1_n_0;
  wire LED_PIPE_leds_a0_00_carry__1_n_4;
  wire LED_PIPE_leds_a0_00_carry__1_n_5;
  wire LED_PIPE_leds_a0_00_carry__1_n_6;
  wire LED_PIPE_leds_a0_00_carry__1_n_7;
  wire LED_PIPE_leds_a0_00_carry__2_n_5;
  wire LED_PIPE_leds_a0_00_carry__2_n_6;
  wire LED_PIPE_leds_a0_00_carry__2_n_7;
  wire LED_PIPE_leds_a0_00_carry_n_0;
  wire LED_PIPE_leds_a0_00_carry_n_4;
  wire LED_PIPE_leds_a0_00_carry_n_5;
  wire LED_PIPE_leds_a0_00_carry_n_6;
  wire LED_PIPE_leds_a0_00_carry_n_7;
  wire [15:0]LED_PIPE_leds_a1;
  wire \LED_PIPE_leds_a1[0]_i_1_n_0 ;
  wire \LED_PIPE_leds_a1_reg[15]_0 ;
  wire [15:0]led_OBUF;
  wire reset_IBUF;
  wire [3:0]NLW_LED_PIPE_leds_a0_00_carry_CO_UNCONNECTED;
  wire [3:0]NLW_LED_PIPE_leds_a0_00_carry__0_CO_UNCONNECTED;
  wire [3:0]NLW_LED_PIPE_leds_a0_00_carry__1_CO_UNCONNECTED;

  GND GND
       (.G(\<const0> ));
  (* ADDER_THRESHOLD = "35" *) 
  (* OPT_MODIFIED = "SWEEP" *) 
  CARRY4 LED_PIPE_leds_a0_00_carry
       (.CI(\<const0> ),
        .CO({LED_PIPE_leds_a0_00_carry_n_0,NLW_LED_PIPE_leds_a0_00_carry_CO_UNCONNECTED[2:0]}),
        .CYINIT(LED_PIPE_leds_a1[0]),
        .DI({\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .O({LED_PIPE_leds_a0_00_carry_n_4,LED_PIPE_leds_a0_00_carry_n_5,LED_PIPE_leds_a0_00_carry_n_6,LED_PIPE_leds_a0_00_carry_n_7}),
        .S(LED_PIPE_leds_a1[4:1]));
  (* ADDER_THRESHOLD = "35" *) 
  (* OPT_MODIFIED = "SWEEP" *) 
  CARRY4 LED_PIPE_leds_a0_00_carry__0
       (.CI(LED_PIPE_leds_a0_00_carry_n_0),
        .CO({LED_PIPE_leds_a0_00_carry__0_n_0,NLW_LED_PIPE_leds_a0_00_carry__0_CO_UNCONNECTED[2:0]}),
        .CYINIT(\<const0> ),
        .DI({\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .O({LED_PIPE_leds_a0_00_carry__0_n_4,LED_PIPE_leds_a0_00_carry__0_n_5,LED_PIPE_leds_a0_00_carry__0_n_6,LED_PIPE_leds_a0_00_carry__0_n_7}),
        .S(LED_PIPE_leds_a1[8:5]));
  (* ADDER_THRESHOLD = "35" *) 
  (* OPT_MODIFIED = "SWEEP" *) 
  CARRY4 LED_PIPE_leds_a0_00_carry__1
       (.CI(LED_PIPE_leds_a0_00_carry__0_n_0),
        .CO({LED_PIPE_leds_a0_00_carry__1_n_0,NLW_LED_PIPE_leds_a0_00_carry__1_CO_UNCONNECTED[2:0]}),
        .CYINIT(\<const0> ),
        .DI({\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .O({LED_PIPE_leds_a0_00_carry__1_n_4,LED_PIPE_leds_a0_00_carry__1_n_5,LED_PIPE_leds_a0_00_carry__1_n_6,LED_PIPE_leds_a0_00_carry__1_n_7}),
        .S(LED_PIPE_leds_a1[12:9]));
  (* ADDER_THRESHOLD = "35" *) 
  (* OPT_MODIFIED = "SWEEP" *) 
  CARRY4 LED_PIPE_leds_a0_00_carry__2
       (.CI(LED_PIPE_leds_a0_00_carry__1_n_0),
        .CYINIT(\<const0> ),
        .DI({\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .O({LED_PIPE_leds_a0_00_carry__2_n_5,LED_PIPE_leds_a0_00_carry__2_n_6,LED_PIPE_leds_a0_00_carry__2_n_7}),
        .S({\<const0> ,LED_PIPE_leds_a1[15:13]}));
  LUT1 #(
    .INIT(2'h1)) 
    \LED_PIPE_leds_a1[0]_i_1 
       (.I0(LED_PIPE_leds_a1[0]),
        .O(\LED_PIPE_leds_a1[0]_i_1_n_0 ));
  FDRE \LED_PIPE_leds_a1_reg[0] 
       (.C(\LED_PIPE_leds_a1_reg[15]_0 ),
        .CE(\<const1> ),
        .D(\LED_PIPE_leds_a1[0]_i_1_n_0 ),
        .Q(LED_PIPE_leds_a1[0]),
        .R(reset_IBUF));
  FDRE \LED_PIPE_leds_a1_reg[10] 
       (.C(\LED_PIPE_leds_a1_reg[15]_0 ),
        .CE(\<const1> ),
        .D(LED_PIPE_leds_a0_00_carry__1_n_6),
        .Q(LED_PIPE_leds_a1[10]),
        .R(reset_IBUF));
  FDRE \LED_PIPE_leds_a1_reg[11] 
       (.C(\LED_PIPE_leds_a1_reg[15]_0 ),
        .CE(\<const1> ),
        .D(LED_PIPE_leds_a0_00_carry__1_n_5),
        .Q(LED_PIPE_leds_a1[11]),
        .R(reset_IBUF));
  FDRE \LED_PIPE_leds_a1_reg[12] 
       (.C(\LED_PIPE_leds_a1_reg[15]_0 ),
        .CE(\<const1> ),
        .D(LED_PIPE_leds_a0_00_carry__1_n_4),
        .Q(LED_PIPE_leds_a1[12]),
        .R(reset_IBUF));
  FDRE \LED_PIPE_leds_a1_reg[13] 
       (.C(\LED_PIPE_leds_a1_reg[15]_0 ),
        .CE(\<const1> ),
        .D(LED_PIPE_leds_a0_00_carry__2_n_7),
        .Q(LED_PIPE_leds_a1[13]),
        .R(reset_IBUF));
  FDRE \LED_PIPE_leds_a1_reg[14] 
       (.C(\LED_PIPE_leds_a1_reg[15]_0 ),
        .CE(\<const1> ),
        .D(LED_PIPE_leds_a0_00_carry__2_n_6),
        .Q(LED_PIPE_leds_a1[14]),
        .R(reset_IBUF));
  FDRE \LED_PIPE_leds_a1_reg[15] 
       (.C(\LED_PIPE_leds_a1_reg[15]_0 ),
        .CE(\<const1> ),
        .D(LED_PIPE_leds_a0_00_carry__2_n_5),
        .Q(LED_PIPE_leds_a1[15]),
        .R(reset_IBUF));
  FDRE \LED_PIPE_leds_a1_reg[1] 
       (.C(\LED_PIPE_leds_a1_reg[15]_0 ),
        .CE(\<const1> ),
        .D(LED_PIPE_leds_a0_00_carry_n_7),
        .Q(LED_PIPE_leds_a1[1]),
        .R(reset_IBUF));
  FDRE \LED_PIPE_leds_a1_reg[2] 
       (.C(\LED_PIPE_leds_a1_reg[15]_0 ),
        .CE(\<const1> ),
        .D(LED_PIPE_leds_a0_00_carry_n_6),
        .Q(LED_PIPE_leds_a1[2]),
        .R(reset_IBUF));
  FDRE \LED_PIPE_leds_a1_reg[3] 
       (.C(\LED_PIPE_leds_a1_reg[15]_0 ),
        .CE(\<const1> ),
        .D(LED_PIPE_leds_a0_00_carry_n_5),
        .Q(LED_PIPE_leds_a1[3]),
        .R(reset_IBUF));
  FDRE \LED_PIPE_leds_a1_reg[4] 
       (.C(\LED_PIPE_leds_a1_reg[15]_0 ),
        .CE(\<const1> ),
        .D(LED_PIPE_leds_a0_00_carry_n_4),
        .Q(LED_PIPE_leds_a1[4]),
        .R(reset_IBUF));
  FDRE \LED_PIPE_leds_a1_reg[5] 
       (.C(\LED_PIPE_leds_a1_reg[15]_0 ),
        .CE(\<const1> ),
        .D(LED_PIPE_leds_a0_00_carry__0_n_7),
        .Q(LED_PIPE_leds_a1[5]),
        .R(reset_IBUF));
  FDRE \LED_PIPE_leds_a1_reg[6] 
       (.C(\LED_PIPE_leds_a1_reg[15]_0 ),
        .CE(\<const1> ),
        .D(LED_PIPE_leds_a0_00_carry__0_n_6),
        .Q(LED_PIPE_leds_a1[6]),
        .R(reset_IBUF));
  FDRE \LED_PIPE_leds_a1_reg[7] 
       (.C(\LED_PIPE_leds_a1_reg[15]_0 ),
        .CE(\<const1> ),
        .D(LED_PIPE_leds_a0_00_carry__0_n_5),
        .Q(LED_PIPE_leds_a1[7]),
        .R(reset_IBUF));
  FDRE \LED_PIPE_leds_a1_reg[8] 
       (.C(\LED_PIPE_leds_a1_reg[15]_0 ),
        .CE(\<const1> ),
        .D(LED_PIPE_leds_a0_00_carry__0_n_4),
        .Q(LED_PIPE_leds_a1[8]),
        .R(reset_IBUF));
  FDRE \LED_PIPE_leds_a1_reg[9] 
       (.C(\LED_PIPE_leds_a1_reg[15]_0 ),
        .CE(\<const1> ),
        .D(LED_PIPE_leds_a0_00_carry__1_n_7),
        .Q(LED_PIPE_leds_a1[9]),
        .R(reset_IBUF));
  VCC VCC
       (.P(\<const1> ));
  LUT2 #(
    .INIT(4'h1)) 
    \led_OBUF[0]_inst_i_1 
       (.I0(reset_IBUF),
        .I1(LED_PIPE_leds_a1[0]),
        .O(led_OBUF[0]));
  LUT2 #(
    .INIT(4'h2)) 
    \led_OBUF[10]_inst_i_1 
       (.I0(LED_PIPE_leds_a0_00_carry__1_n_6),
        .I1(reset_IBUF),
        .O(led_OBUF[10]));
  LUT2 #(
    .INIT(4'h2)) 
    \led_OBUF[11]_inst_i_1 
       (.I0(LED_PIPE_leds_a0_00_carry__1_n_5),
        .I1(reset_IBUF),
        .O(led_OBUF[11]));
  LUT2 #(
    .INIT(4'h2)) 
    \led_OBUF[12]_inst_i_1 
       (.I0(LED_PIPE_leds_a0_00_carry__1_n_4),
        .I1(reset_IBUF),
        .O(led_OBUF[12]));
  LUT2 #(
    .INIT(4'h2)) 
    \led_OBUF[13]_inst_i_1 
       (.I0(LED_PIPE_leds_a0_00_carry__2_n_7),
        .I1(reset_IBUF),
        .O(led_OBUF[13]));
  LUT2 #(
    .INIT(4'h2)) 
    \led_OBUF[14]_inst_i_1 
       (.I0(LED_PIPE_leds_a0_00_carry__2_n_6),
        .I1(reset_IBUF),
        .O(led_OBUF[14]));
  LUT2 #(
    .INIT(4'h2)) 
    \led_OBUF[15]_inst_i_1 
       (.I0(LED_PIPE_leds_a0_00_carry__2_n_5),
        .I1(reset_IBUF),
        .O(led_OBUF[15]));
  LUT2 #(
    .INIT(4'h2)) 
    \led_OBUF[1]_inst_i_1 
       (.I0(LED_PIPE_leds_a0_00_carry_n_7),
        .I1(reset_IBUF),
        .O(led_OBUF[1]));
  LUT2 #(
    .INIT(4'h2)) 
    \led_OBUF[2]_inst_i_1 
       (.I0(LED_PIPE_leds_a0_00_carry_n_6),
        .I1(reset_IBUF),
        .O(led_OBUF[2]));
  LUT2 #(
    .INIT(4'h2)) 
    \led_OBUF[3]_inst_i_1 
       (.I0(LED_PIPE_leds_a0_00_carry_n_5),
        .I1(reset_IBUF),
        .O(led_OBUF[3]));
  LUT2 #(
    .INIT(4'h2)) 
    \led_OBUF[4]_inst_i_1 
       (.I0(LED_PIPE_leds_a0_00_carry_n_4),
        .I1(reset_IBUF),
        .O(led_OBUF[4]));
  LUT2 #(
    .INIT(4'h2)) 
    \led_OBUF[5]_inst_i_1 
       (.I0(LED_PIPE_leds_a0_00_carry__0_n_7),
        .I1(reset_IBUF),
        .O(led_OBUF[5]));
  LUT2 #(
    .INIT(4'h2)) 
    \led_OBUF[6]_inst_i_1 
       (.I0(LED_PIPE_leds_a0_00_carry__0_n_6),
        .I1(reset_IBUF),
        .O(led_OBUF[6]));
  LUT2 #(
    .INIT(4'h2)) 
    \led_OBUF[7]_inst_i_1 
       (.I0(LED_PIPE_leds_a0_00_carry__0_n_5),
        .I1(reset_IBUF),
        .O(led_OBUF[7]));
  LUT2 #(
    .INIT(4'h2)) 
    \led_OBUF[8]_inst_i_1 
       (.I0(LED_PIPE_leds_a0_00_carry__0_n_4),
        .I1(reset_IBUF),
        .O(led_OBUF[8]));
  LUT2 #(
    .INIT(4'h2)) 
    \led_OBUF[9]_inst_i_1 
       (.I0(LED_PIPE_leds_a0_00_carry__1_n_7),
        .I1(reset_IBUF),
        .O(led_OBUF[9]));
endmodule

(* ECO_CHECKSUM = "75f3f80c" *) 
(* STRUCTURAL_NETLIST = "yes" *)
module top
   (clk,
    reset,
    led);
  input clk;
  input reset;
  output [15:0]led;

  wire clk;
  wire clk_IBUF;
  wire clk_IBUF_BUFG;
  wire dut1_n_0;
  wire [15:0]led;
  wire [15:0]led_OBUF;
  wire reset;
  wire reset_IBUF;

  BUFG clk_IBUF_BUFG_inst
       (.I(clk_IBUF),
        .O(clk_IBUF_BUFG));
  IBUF clk_IBUF_inst
       (.I(clk),
        .O(clk_IBUF));
  clock_divider dut1
       (.clk_IBUF_BUFG(clk_IBUF_BUFG),
        .divided_clk_reg_0(dut1_n_0));
  test dut2
       (.\LED_PIPE_leds_a1_reg[15]_0 (dut1_n_0),
        .led_OBUF(led_OBUF),
        .reset_IBUF(reset_IBUF));
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
  IBUF reset_IBUF_inst
       (.I(reset),
        .O(reset_IBUF));
endmodule
