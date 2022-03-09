\m4_TLV_version 1d -p verilog --bestsv --noline: tl-x.org

\SV
   m4_include_lib(['https://raw.githubusercontent.com/BalaDhinesh/Virtual-FPGA-Lab/main/tlv_lib/fpga_includes_v2.tlv'])    
   
\SV
   m4_lab()
   logic [9:0] sx;
   logic [9:0] sy;
   m4_ifelse_block(M4_MAKERCHIP, 1,['
   m4_define(M4_COUNTER, 32) // required for VIZ
   m4_define(M4_FRAMES, 2)  // required for VIZ
   '],['
    m4_define(['M4_COUNTER'], 1)
   ']
   )
    
\TLV init_monitor()
   m4_define(M4_HA_END, 639)
   m4_define(M4_HS_STA, M4_HA_END + 16)
   m4_define(M4_HS_END, M4_HS_STA + 96)
   m4_define(M4_LINE, 799)
   m4_define(M4_VA_END, 479)
   m4_define(M4_VS_STA, M4_VA_END + 10)
   m4_define(M4_VS_END, M4_VS_STA + 2)
   m4_define(M4_SCREEN, 524)

\TLV init_cursor($_reset, $hsync, $vsync, M4_COUNTER)
   m4+fpga_refresh($sync, m4_ifelse(M4_MAKERCHIP, 1, 1, 4))
   ?$sync
      $hsync = ~($Sx >= M4_HS_STA && $Sx < M4_HS_END);
      $vsync = ~($Sy >= M4_VS_STA && $Sy < M4_VS_END);
      $Sx[9:0] <= $_reset ? 10'b0 : $Sx >= M4_LINE ? 0 : $Sx + M4_COUNTER;
      $Sy[9:0] <= $_reset ? 10'b0 : ($Sx >= M4_LINE ? ($Sy >= M4_SCREEN ? 0 : $Sy + M4_COUNTER) : $RETAIN);
      *sx = $Sx;
      *sy = $Sy;
      
\TLV
   /board
      /fpga
         |led
            @0
               m4+fpga_refresh($refresh, m4_ifelse(M4_MAKERCHIP, 1, 1, 50000000)) 
               $reset = *reset;
               ?$refresh
                  $Leds[15:0] <= $reset ? 1 : $Leds + 1;
               *led = 16'hFFFF;
               
         |seven_segment
            @0
               *sseg_segment_n = 8'hFF;
               *sseg_digit_n = 4'b1100;
               
         |switch
            @0
               *switch = 16'h00FF;
               
         |push
            @0
               *push = 5'hF;
               
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
               
         |vga
            @0
               m4+init_monitor()
               m4+init_cursor($reset, $hsync, $vsync, M4_COUNTER) 
               m4+fpga_refresh($refresh, m4_ifelse(M4_MAKERCHIP, 1, 1, 4))
               $reset = *reset; 
               ?$refresh
                  $de = (*sx < M4_HA_END && *sy < M4_VA_END);
                  $q_draw = (*sx < 64 && *sy < 64);
                  $vga_hsync = $reset ? 0 : >>1$hsync;
                  $vga_vsync = $reset ? 0 : >>1$vsync;
                  $vga_r[3:0] = $reset ? 0 : !$de ? 4'h0 : ($q_draw ? 4'hF : 4'h0);
                  $vga_g[3:0] = $reset ? 0 : !$de ? 4'h0 : ($q_draw ? 4'h8 : 4'h8);
                  $vga_b[3:0] = $reset ? 0 : !$de ? 4'h0 : ($q_draw ? 4'h0 : 4'hF);
               *vga_hsync = $vga_hsync;
               *vga_vsync = $vga_vsync;
               *vga_r = $vga_r;
               *vga_g = $vga_g;
               *vga_b = $vga_b;
         
      m4+board(/board, /fpga, 2, *)   // 3rd arg selects the board.
\SV
   endmodule
