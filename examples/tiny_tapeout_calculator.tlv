\m5_TLV_version 1d -p verilog --noline: tl-x.org
\m5
   use(m5-1.0)
\SV
   m4_include_lib(['https://raw.githubusercontent.com/os-fpga/Virtual-FPGA-Lab/main/tlv_lib/fpga_includes.tlv'])
   m4_include_lib(['https://raw.githubusercontent.com/stevehoover/RISC-V_MYTH_Workshop/master/tlv_lib/calculator_shell_lib.tlv'])
\SV
   m4_lab()


\TLV 7seg($val)
   *sseg_segment_n =
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

// Example using LEDs to display a binary counter.
\TLV fpga_calculator(/_fpga)
   |calc
      @0
         // Run artificially slow in the real FPGA. 
         m5+fpga_heartbeat($refresh, 1, 50000000) 
         $reset = *reset;
         *sseg_decimal_point_n = 1'b1;
         *sseg_digit_n[7:0] = 8'b11111110;
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

         
   m4+cal_viz(@2, /_fpga)

\TLV
   /board
   
      // Board selection:
      // 0 - 1st CLaaS on AWS F1
      // 1 - Zedboard
      // 2 - Artix-7
      // 3 - Basys3
      // 4 - Icebreaker
      // 5 - Nexys
      // 6 - CLEAR
      // 7 - Tiny Tapeout
      m5+board(/board, /fpga, 7, *, , fpga_calculator)   // 3rd arg selects the board.

\SV
   endmodule