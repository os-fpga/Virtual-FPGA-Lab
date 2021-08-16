\m4_TLV_version 1d -p verilog --bestsv --noline: tl-x.org
\SV
   m4_include_lib(['https://raw.githubusercontent.com/BalaDhinesh/Virtual-FPGA-Lab/main/viz_libraries/fpga_includes.tlv'])
\SV
   m4_ifelse_block(M4_MAKERCHIP, 1,['
   m4_makerchip_module   
   '],['
   module top(input clk, input reset, output [3:0] digit, output [6:0] sseg);
   '])
\TLV counter($_var, #_delay)
   m4_ifelse_block(M4_MAKERCHIP, 1, ['
   $_var = 1;
   '], ['
   $rst = *reset;
   $count[\$clog2(#_delay)-1:0] = $rst ? 1'b0 : ($RETAIN >= #_delay) ? 1'b0 : >>1$count + 1 ; 
   $counter = ($count == #_delay) ? 1'b1 : 1'b0 ;
   $_var = $counter;
   ']) 
\TLV
   |sseg_pipe
      @0   
         m4+counter($refresh, 50000000 - 1) 
         $reset = *reset;
         ?$refresh
            //All 4 digits can be enabled by sending logic ‘0’.
            //Each segment can be enabled by sending logic ‘0’
            $digit[3:0] = 4'b0000;
            $Led_bcd[3:0] <= $reset ? 4'h0 : $Led_bcd + 1;
            $sseg[6:0] = ($Led_bcd == 0) ? 7'b0000001 : // '0'
                         ($Led_bcd == 1) ? 7'b1001111 : // '1'
                         ($Led_bcd == 2) ? 7'b0010010 : // '2'
                         ($Led_bcd == 3) ? 7'b0000110 : // '3'
                         ($Led_bcd == 4) ? 7'b1001100 : // '4'
                         ($Led_bcd == 5) ? 7'b0100100 : // '5'
                         ($Led_bcd == 6) ? 7'b0100000 : // '6'
                         ($Led_bcd == 7) ? 7'b0001111 : // '7'
                         ($Led_bcd == 8) ? 7'b0000000 : // '8'
                         ($Led_bcd == 9) ? 7'b0000100 : // '9'
                         ($Led_bcd == 10) ? 7'b0000010 : // 'a'
                         ($Led_bcd == 11) ? 7'b1100000 : // 'b'
                         ($Led_bcd == 12) ? 7'b0110001 : // 'c'
                         ($Led_bcd == 13) ? 7'b1000010 : // 'd'
                         ($Led_bcd == 14) ? 7'b0010000 : // 'e'
                         ($Led_bcd == 15) ? 7'b0111000 : // 'f'
                         7'b1111111 ;                   // 'nothing'
            $dp = 1;                
         m4_ifelse_block(M4_MAKERCHIP, 1,[''],['
         *digit = $digit;
         *sseg = $sseg;
         *dp = $dp;
         '])
   m4_ifelse_block(M4_MAKERCHIP, 1, ['
   m4_define(M4_BOARD, 3)
   m4+fpga_init(|top_pipe, @0)
   m4+fpga_sseg(|sseg_pipe, @0, $digit, $sseg, $dp)
   *passed = *cyc_cnt > 400;
   *failed = 1'b0;   
   '])
\SV
   endmodule