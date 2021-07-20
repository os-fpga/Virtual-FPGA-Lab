\m4_TLV_version 1d -p verilog --bestsv --noline: tl-x.org
\SV
   m4_include_lib(['https://raw.githubusercontent.com/BalaDhinesh/Virtual-FPGA-Lab/main/viz_libraries/includes.tlv'])
\SV
   m4_ifelse_block(M4_MAKERCHIP, 1,['
   m4_makerchip_module   
   '],['
   module top(input clk, input reset, output [3:0] digit, output [7:0] sseg);
      clock_divider #(.DIV_VALUE(24999999)) dut1 (clk, divided_clk);
      test dut2 (divided_clk, reset, digit, sseg);
   endmodule
   module test (input clk, input reset, output [3:0] digit, output [7:0] sseg);
   ']
   )
\TLV
   |sseg_pipe
      @0   
         $reset = *reset;
         $digit[3:0] = 4'b0000;
         $led_bcd[3:0] = $reset ? 4'hF : >>1$led_bcd + 1;
         $sseg[7:0] = ($led_bcd == 0) ? 8'b11000000 : // '0'
                            ($led_bcd == 1) ? 8'b11001111 : // '1'
                            ($led_bcd == 2) ? 8'b10010010 : // '2'
                            ($led_bcd == 3) ? 8'b10000110 : // '3'
                            ($led_bcd == 4) ? 8'b10001101 : // '4'
                            ($led_bcd == 5) ? 8'b10100100 : // '5'
                            ($led_bcd == 6) ? 8'b10100000 : // '6'
                            ($led_bcd == 7) ? 8'b11001110 : // '7'
                            ($led_bcd == 8) ? 8'b10000000 : // '8'
                            ($led_bcd == 9) ? 8'b10000100 : // '9'
                            ($led_bcd == 10) ? 8'b10000010 : // 'a'
                            ($led_bcd == 11) ? 8'b10100001 : // 'b'
                            ($led_bcd == 12) ? 8'b11110000 : // 'c'
                            ($led_bcd == 13) ? 8'b10000011 : // 'd'
                            ($led_bcd == 14) ? 8'b10010000 : // 'e'
                            ($led_bcd == 15) ? 8'b10111000 : // 'f'
                            8'b11111111 ;                   // 'nothing'
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
   m4+artix7_sseg(|sseg_pipe, @0, $digit, $sseg)
   '],['
   ']
   )
\SV
   endmodule
