\m4_TLV_version 1d -p verilog --bestsv --noline: tl-x.org
\SV
   m4_include_lib(['https://raw.githubusercontent.com/BalaDhinesh/Virtual-FPGA-Lab/main/tlv_lib/fpga_includes.tlv'])
\SV
   m4_ifelse_block(M4_MAKERCHIP, 1,['
   m4_makerchip_module   
   '],['
   module top(input clk, input reset, output [3:0] digit, output [6:0] sseg);
   '])
      logic [3:0] digit;
      logic [6:0] sseg;
      logic  dp;
\TLV
   |sseg_pipe
      @0   
         m4+fpga_refresh($refresh, m4_ifelse(M4_MAKERCHIP, 1, 1, 50000000))
         $reset = *reset;
         ?$refresh
            //All 4 digits can be enabled by sending logic ‘0’.
            //Each segment can be enabled by sending logic ‘0’
            $digit[3:0] = 4'b0000;
            $LedBcd[3:0] <= $reset ? 4'h0 : $LedBcd + 1;
            $sseg[6:0] = ($LedBcd == 0) ? 7'b0000001 : // '0'
                         ($LedBcd == 1) ? 7'b1001111 : // '1'
                         ($LedBcd == 2) ? 7'b0010010 : // '2'
                         ($LedBcd == 3) ? 7'b0000110 : // '3'
                         ($LedBcd == 4) ? 7'b1001100 : // '4'
                         ($LedBcd == 5) ? 7'b0100100 : // '5'
                         ($LedBcd == 6) ? 7'b0100000 : // '6'
                         ($LedBcd == 7) ? 7'b0001111 : // '7'
                         ($LedBcd == 8) ? 7'b0000000 : // '8'
                         ($LedBcd == 9) ? 7'b0000100 : // '9'
                         ($LedBcd == 10) ? 7'b0000010 : // 'a'
                         ($LedBcd == 11) ? 7'b1100000 : // 'b'
                         ($LedBcd == 12) ? 7'b0110001 : // 'c'
                         ($LedBcd == 13) ? 7'b1000010 : // 'd'
                         ($LedBcd == 14) ? 7'b0010000 : // 'e'
                         ($LedBcd == 15) ? 7'b0111000 : // 'f'
                         7'b1111111 ;                   // 'nothing'
            $dp = 1;                
         *digit = $digit;
         *sseg = $sseg;
         *dp = $dp;
   // M4_BOARD numbering
   // 1 - Zedboard
   // 2 - Artix-7
   // 3 - Basys3
   // 4 - Icebreaker
   // 5 - Nexys
   m4_define(M4_BOARD, 3)
   m4+fpga_init()
   m4+fpga_sseg(*digit, *sseg, *dp)
\SV
   endmodule