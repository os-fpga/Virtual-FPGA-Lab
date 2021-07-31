\m4_TLV_version 1d -p verilog --bestsv --noline: tl-x.org
\SV
   m4_include_lib(['https://raw.githubusercontent.com/BalaDhinesh/Virtual-FPGA-Lab/main/viz_libraries/includes.tlv'])
\SV
   m4_ifelse_block(M4_MAKERCHIP, 1,['
   m4_makerchip_module   
   '],['
   module top(input clk, input reset, output [3:0] digit, output [6:0] sseg);
      clock_divider #(.DIV_VALUE(24999999)) dut1 (clk, divided_clk);
      test dut2 (divided_clk, reset, digit, sseg);
   endmodule
   module test (input clk, input reset, output [3:0] digit, output [6:0] sseg);
   ']
   )
\TLV
   |sseg_pipe
      @0   
         $reset = *reset;
         $digit[3:0] = 4'b1100;
         $led_bcd[3:0] = $reset ? 4'h0 : >>1$led_bcd + 1;
         $sseg[6:0] = ($led_bcd == 0) ? 7'b0000001 : // '0'
                            ($led_bcd == 1) ? 7'b1001111 : // '1'
                            ($led_bcd == 2) ? 7'b0010010 : // '2'
                            ($led_bcd == 3) ? 7'b0000110 : // '3'
                            ($led_bcd == 4) ? 7'b1001100 : // '4'
                            ($led_bcd == 5) ? 7'b0100100 : // '5'
                            ($led_bcd == 6) ? 7'b0100000 : // '6'
                            ($led_bcd == 7) ? 7'b0001111 : // '7'
                            ($led_bcd == 8) ? 7'b0000000 : // '8'
                            ($led_bcd == 9) ? 7'b0000100 : // '9'
                            ($led_bcd == 10) ? 7'b0000010 : // 'a'
                            ($led_bcd == 11) ? 7'b1100000 : // 'b'
                            ($led_bcd == 12) ? 7'b0110001 : // 'c'
                            ($led_bcd == 13) ? 7'b1000010 : // 'd'
                            ($led_bcd == 14) ? 7'b0010000 : // 'e'
                            ($led_bcd == 15) ? 7'b0111000 : // 'f'
                            7'b1111111 ;                   // 'nothing'
         $dp = 0;
         m4_ifelse_block(M4_MAKERCHIP, 1,['
         *passed = *cyc_cnt > 400;
         *failed = 1'b0;   
         '],['
         *digit = $digit;
         *sseg = $sseg;
         ']
         )
   m4_ifelse_block(M4_MAKERCHIP, 1,['      
   m4+artix7_init(|top_pipe, @0)
   m4+artix7_sseg(|sseg_pipe, @0, $digit, $sseg, $dp)
   '],['
   ']
   )
\SV
   endmodule
