\m4_TLV_version 1d -p verilog --bestsv --noline: tl-x.org

\SV
   m4_include_lib(['https://raw.githubusercontent.com/os-fpga/Virtual-FPGA-Lab/main/tlv_lib/fpga_includes.tlv'])    
   
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
                  m5+sseg_decoder($sseg)
                  $dp = 1;                
               *sseg_digit_n = $digit;
               *sseg_segment_n = $sseg;
               *sseg_decimal_point_n = $dp;
      m4+board(/board, /fpga, 3, *, ['top: 0, left: -1500, width: 7000, height: 7000'])   // 3rd arg selects the board.

\SV
   endmodule