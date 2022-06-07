\m4_TLV_version 1d -p verilog --bestsv --noline: tl-x.org

\SV
   m4_include_lib(['https://raw.githubusercontent.com/os-fpga/Virtual-FPGA-Lab/main/tlv_lib/fpga_includes.tlv'])    
   
\SV
   m4_lab()

\TLV
   /board
      /fpga
         |lcd
            @0
               $reset = *reset;
               m4+fpga_refresh($refresh, m4_ifelse(M4_MAKERCHIP, 1, 1, 50000000)) 
               ?$refresh          // clock gating
                  $Ii[3:0] <= $reset ? 5'b11111 : ($Ii < 4) ? $Ii + 1 : 0;
                  $Jj[4:0] <= $reset ? 5'b11111 : ($Ii == 4) ? $Jj + 1 : ($Jj == 24) ? 4 : $Jj;
                  // data and command instructions
                  $datas[25*8-1:0] = {8'h18, 8'h2D, 8'h2D, 8'hC0, 8'h21, 8'h21, 8'h21, 8'h6E, 8'h75, 8'h66, 8'h20, 8'h65, 8'h72, 8'h61,
                                 8'h20, 8'h73, 8'h41, 8'h47, 8'h50, 8'h46, 8'h80, 8'h01, 8'h06, 8'h0C, 8'h38};
                  // select the data
                  $out[7:0] = $reset ? 0 : ($Ii <= 2) ? $datas >> 8*$Jj : >>1$out;
                  // set wait time
                  $lcd_enable = $reset ? 0 : ($Ii <= 2) ?  1 : ($Ii > 2 & $Ii < 4) ? 0 : >>1$lcd_enable;;
                  // set command/data instruction
                  $lcd_reset = ($Jj > 4 & $Jj != 21 & $Jj != 24) ? 1 : 0;
               *out = $out;
               *lcd_enable = $lcd_enable;
               *lcd_reset = $lcd_reset;
         
      m4+board(/board, /fpga, 3, *, ['top: 0, left: -1500, width: 7000, height: 7000'])   // 3rd arg selects the board.
   m4+fpga_lcd()
   
\SV
   endmodule
