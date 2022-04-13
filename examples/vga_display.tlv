\m4_TLV_version 1d -p verilog --bestsv --noline: tl-x.org

\SV
   m4_include_lib(['https://raw.githubusercontent.com/os-fpga/Virtual-FPGA-Lab/bala_cleanup/tlv_lib/fpga_includes.tlv'])    
   
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
         |vga
            @0
               m4+init_monitor()
               m4+init_cursor($reset, $hsync, $vsync, M4_COUNTER) 
               m4+fpga_refresh($refresh, m4_ifelse(M4_MAKERCHIP, 1, 1, 4))
               $reset = *reset; 
               ?$refresh
                  $de = (*sx < M4_HA_END && *sy < M4_VA_END);
                  $qq_draw = (*sx < 64 && *sy < 64);
                  $vga_hsync = $reset ? 0 : >>1$hsync;
                  $vga_vsync = $reset ? 0 : >>1$vsync;
                  $vga_r[3:0] = $reset ? 0 : !$de ? 4'h0 : ($qq_draw ? 4'hF : 4'h0);
                  $vga_g[3:0] = $reset ? 0 : !$de ? 4'h0 : ($qq_draw ? 4'h8 : 4'h8);
                  $vga_b[3:0] = $reset ? 0 : !$de ? 4'h0 : ($qq_draw ? 4'h0 : 4'hF);
               *vga_hsync = $vga_hsync;
               *vga_vsync = $vga_vsync;
               *vga_r = $vga_r;
               *vga_g = $vga_g;
               *vga_b = $vga_b;
         
      m4+board(/board, /fpga, 3, *)   // 3rd arg selects the board.
   m4+fpga_vga()
\SV
   endmodule