\m5_TLV_version 1d -p verilog --noline: tl-x.org
\m5
   /**
   This template enables Tiny Tapeout modules to run in the Virtual FPGA Lab.
   It is specifically for Tiny Tapeout designs only.
   A different template should be used to develop Virtual FPGA Lab modules that are
   compatible with Tiny Tapeout (and all other boards supported by the Virtual FPGA Lab boards).
   **/
   use(m5-1.0)
\SV
   m4_include_lib(['https://raw.githubusercontent.com/os-fpga/Virtual-FPGA-Lab/main/tlv_lib/fpga_includes.tlv'])
   m4_include_lib(['https://raw.githubusercontent.com/stevehoover/RISC-V_MYTH_Workshop/master/tlv_lib/calculator_shell_lib.tlv'])

   ///m4_lab()


\TLV 7seg($val)
   *uo_out[6:0] =
        ($val == 0) ? 7'b1000000 : // '0'
        ($val == 1) ? 7'b1001111 : // '1'
        ($val == 2) ? 7'b0010010 : // '2'
        ($val == 3) ? 7'b0000110 : // '3'
        ($val == 4) ? 7'b0001101 : // '4'
        ($val == 5) ? 7'b0100100 : // '5'
        ($val == 6) ? 7'b0100000 : // '6'
        ($val == 7) ? 7'b1001110 : // '7'
        ($val == 8) ? 7'b0000000 : // '8'
        ($val == 9) ? 7'b0000100 : // '9'
        ($val == 10) ? 7'b0000010 : // 'a'
        ($val == 11) ? 7'b0100001 : // 'b'
        ($val == 12) ? 7'b1110000 : // 'c'
        ($val == 13) ? 7'b0000011 : // 'd'
        ($val == 14) ? 7'b0010000 : // 'e'
        ($val == 15) ? 7'b0111000 : // 'f'
        7'b1111111 ;                // 'nothing'
   *uo_out[7] = 1'b1;  // No decimal point.

// Example using LEDs to display a binary counter.
\TLV fpga_calculator(/_fpga)
   |calc
      @0
         // Run artificially slow in the real FPGA. 
         m5+fpga_heartbeat($refresh, 1, 50000000)
         $reset = *reset;
      @1
         $val1[31:0] = >>2$out;
         $val2[31:0] = $rand2[3:0];
         $valid = $reset ? 1'b0 : >>1$valid + 1'b1;
         $reset_or_valid = $valid || $reset;
      ?$reset_or_valid
         @1
            $sum[31:0] = $val1 + $val2;
            $diff[31:0] = $val1 - $val2;
            $prod[31:0] = $val1 * $val2;
            $quot[31:0] = $val1 / $val2;
         @2
            $mem[31:0] = $reset           ? 32'b0 :
                            ($op[2:0] == 3'b101) ? $val1 :
                                               >>2$mem;
            $out[31:0] = $reset           ? 32'b0 :
                         ($op == 3'b000) ? $sum  :
                         ($op == 3'b001) ? $diff :
                         ($op == 3'b010) ? $prod :
                         ($op == 3'b011) ? $quot :
                         ($op == 3'b100) ? >>2$mem : >>2$out;
      @2
         m5+7seg($out[3:0])

   \SV_plus
      m5_if_var_def(MAKERCHIP, ['logic [256:0] RW_rand_vect = top.RW_rand_vect;'])
      m5_if_var_def(MAKERCHIP, ['logic [31:0] cyc_cnt = top.cyc_cnt;'])
      m5_if_var_def(MAKERCIHP, ['logic [6:0] sseg_digit_n = top.sseg_digit_n;'])
      m5_if_var_def(MAKERCHIP, ['logic sseg_decimal_point_n = top.sseg_decimal_point_n;'])
      m5_if_var_def(MAKERCHIP, ['logic [7:0] sseg_segment_n = top.sseg_segment_n;'])
      m5_if_var_def(MAKERCHIP, ['logic [7:0] sseg_digit_n = top.sseg_digit_n;'])
      m5_if_var_def(MAKERCHIP, [''])
   m4+cal_viz(@2, /_fpga)

\SV_plus

`default_nettype none

// A simple Makerchip Verilog test bench driving random stimulus.
m4_makerchip_module
   logic [7:0] ui_in, uio_in, uo_out, uio_out, uio_oe;
   assign m4_rand(ui_in, 7, 0)
   assign m4_rand(uio_in, 7, 0)
   logic ena = 1'b0;
   logic rst_n = ! reset;
                   
   // Instantiate the Tiny Tapeout module.
   tt_um_template tt(.*);
   
   logic [15:0] led; logic [6:0] sseg_segment_n; logic sseg_decimal_point_n; logic [7:0] sseg_digit_n;
   logic [15:0] slideswitch;
   //logic [4:0] push;
   //logic [7:0] out;
   //logic lcd_reset;
   //logic lcd_enable;
   
   // Connect Tiny Tapeout I/Os to Virtual FPGA Lab.
   /*
   assign slideswitch[7:0] = ui_in;
   assign sseg_segment_n[6:0] = uo_out[6:0];
   assign sseg_decimal_point_n = uo_out[7];
   assign sseg_digit_n[7:0] = 8'b11111110;
   */
endmodule

module tt_um_template (
    input  wire [7:0] ui_in,    // Dedicated inputs - connected to the input switches
    output wire [7:0] uo_out,   // Dedicated outputs - connected to the 7 segment display
    input  wire [7:0] uio_in,   // IOs: Bidirectional Input path
    output wire [7:0] uio_out,  // IOs: Bidirectional Output path
    output wire [7:0] uio_oe,   // IOs: Bidirectional Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // will go high when the design is enabled
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);

   wire reset = ! rst_n;
\TLV
   /board
      // Connect Tiny Tapeout I/Os to Virtual FPGA Lab.
      $slideswitch[7:0] = *ui_in;
      $sseg_segment_n[6:0] = *uo_out[6:0];
      $sseg_decimal_point_n = *uo_out[7];
      $sseg_digit_n[7:0] = 8'b11111110;
      m5+board(/board, /fpga, 7, $, , fpga_calculator)   // 3rd arg selects the board.

\SV
   endmodule