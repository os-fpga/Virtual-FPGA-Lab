\m4_TLV_version 1d -p verilog --bestsv --noline: tl-x.org

\SV
   m4_include_lib(['https://raw.githubusercontent.com/os-fpga/Virtual-FPGA-Lab/bala_cleanup/tlv_lib/fpga_includes.tlv'])    
   
\SV
   m4_lab()

\TLV
   /board
      /fpga
         |led
            @0
               m4+fpga_refresh($refresh, m4_ifelse(M4_MAKERCHIP, 1, 1, 50000000)) 
               $reset = *reset;
               ?$refresh
                  $Leds[15:0] <= $reset ? 1 : $Leds + 1;
               *led = $Leds;
         
      m4+board(/board, /fpga, 3, *)   // 3rd arg selects the board.
   
\SV
   endmodule