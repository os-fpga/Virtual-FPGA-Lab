\m4_TLV_version 1d -p verilog --bestsv --noline: tl-x.org

\SV
   m4_include_lib(['https://raw.githubusercontent.com/os-fpga/Virtual-FPGA-Lab/bala_cleanup/tlv_lib/fpga_includes.tlv'])    
   
\SV
   m4_lab()
   
\TLV
   /board
      /fpga
         |seven_segment
            @0
               m4+fpga_heartbeat($refresh, 1, 500000)
               $reset = *reset;
               ?$refresh
                  //All 4 digits can be enabled by sending logic ‘0’.
                  //Each segment can be enabled by sending logic ‘0’
                  $digit[3:0] = 4'b0000;
                  $LedBcd[3:0] <= $reset ? 4'h0 : $LedBcd + 1;
                  $sseg[6:0] = ($LedBcd == 0) ? 7'b1000000 : // '0'
                              ($LedBcd == 1) ? 7'b1001111 : // '1'
                              ($LedBcd == 2) ? 7'b0010010 : // '2'
                              ($LedBcd == 3) ? 7'b0000110 : // '3'
                              ($LedBcd == 4) ? 7'b0001101 : // '4'
                              ($LedBcd == 5) ? 7'b0100100 : // '5'
                              ($LedBcd == 6) ? 7'b0100000 : // '6'
                              ($LedBcd == 7) ? 7'b1001110 : // '7'
                              ($LedBcd == 8) ? 7'b0000000 : // '8'
                              ($LedBcd == 9) ? 7'b0000100 : // '9'
                              ($LedBcd == 10) ? 7'b0000010 : // 'a'
                              ($LedBcd == 11) ? 7'b0100001 : // 'b'
                              ($LedBcd == 12) ? 7'b1110000 : // 'c'
                              ($LedBcd == 13) ? 7'b0000011 : // 'd'
                              ($LedBcd == 14) ? 7'b0010000 : // 'e'
                              ($LedBcd == 15) ? 7'b0111000 : // 'f'
                              7'b1111111 ;                   // 'nothing'
                  $dp = 1;                
               *sseg_digit_n = $digit;
               *sseg_segment_n = $sseg;
               *sseg_decimal_point_n = $dp;
      m4+board(/board, /fpga, 3, *)   // 3rd arg selects the board.

\SV
   endmodule