\m4_TLV_version 1d -p verilog --bestsv --noline: tl-x.org

\SV
   m4_include_lib(['https://raw.githubusercontent.com/BalaDhinesh/Virtual-FPGA-Lab/main/viz_libraries/includes1.tlv'])
                   
\SV
   m4_ifelse_block(M4_MAKERCHIP, 1,['
   m4_makerchip_module   
   m4_define(M4_COUNTER, 32) // required for VIZ
   m4_define(M4_FRAMES, 2)  // required for VIZ
   '],['
    m4_define(['M4_COUNTER'], 1)
	 module top (
    input  clk,     // 50 MHz clock
    input  reset,      // reset button (active low)
    output vga_hsync,    // horizontal sync
    output vga_vsync,    // vertical sync
    output [3:0] vga_r,  // 4-bit VGA red
    output [3:0] vga_g,  // 4-bit VGA green
    output [3:0] vga_b   // 4-bit VGA blue
    );   
   ']
    )
\TLV init_monitor(|_pipe, @_stage)
   |_pipe
      @_stage
         m4_define(M4_HA_END, 639)
         m4_define(M4_HS_STA, M4_HA_END + 16)
         m4_define(M4_HS_END, M4_HS_STA + 96)
         m4_define(M4_LINE, 799)
         m4_define(M4_VA_END, 479)
         m4_define(M4_VS_STA, M4_VA_END + 10)
         m4_define(M4_VS_END, M4_VS_STA + 2)
         m4_define(M4_SCREEN, 524)

\TLV init_cursor(|_pipe, @_stage, $_reset, $hsync, $vsync, M4_COUNTER, $sx , $sy)
   |_pipe
      @_stage
         m4+fpga_refresh($sync, m4_ifelse(M4_MAKERCHIP, 1, 1, 4))
         ?$sync
            $hsync = ~($Sx >= M4_HS_STA && $Sx < M4_HS_END);
            $vsync = ~($Sy >= M4_VS_STA && $Sy < M4_VS_END);
            $Sx[9:0] <= $_reset ? 10'b0 : $Sx >= M4_LINE ? 0 : $Sx + M4_COUNTER;
            $Sy[9:0] <= $_reset ? 10'b0 : ($Sx >= M4_LINE ? ($Sy >= M4_SCREEN ? 0 : $Sy + M4_COUNTER) : $RETAIN);
            $sx[9:0] = $Sx;
            $sy[9:0] = $Sy;
         
\TLV
   m4+init_monitor(|vga_pipe, @0)
   m4+init_cursor(|vga_pipe, @0, $reset, $hsync, $vsync, M4_COUNTER, $sx, $sy) 
   m4_define(M4_BOARD, 4)
   m4+init(|top_pipe, @0)
   |vga_pipe
      @0
         m4+fpga_refresh($refresh, m4_ifelse(M4_MAKERCHIP, 1, 1, 4))
         $reset = *reset; 
         ?$refresh
            $de = ($sx < M4_HA_END && $sy < M4_VA_END);
            $q_draw = ($sx < 64 && $sy < 64);
            $vga_hsync = $reset ? 0 : >>1$hsync;
            $vga_vsync = $reset ? 0 : >>1$vsync;
            $vga_r[3:0] = $reset ? 0 : !$de ? 4'h0 : ($q_draw ? 4'hF : 4'h0);
            $vga_g[3:0] = $reset ? 0 : !$de ? 4'h0 : ($q_draw ? 4'h8 : 4'h8);
            $vga_b[3:0] = $reset ? 0 : !$de ? 4'h0 : ($q_draw ? 4'h0 : 4'hF);
         m4_ifelse_block(M4_MAKERCHIP, 1,['
         '],['
         *vga_hsync = $vga_hsync;
         *vga_vsync = $vga_vsync;
         *vga_r = $vga_r;
         *vga_g = $vga_g;
         *vga_b = $vga_b;
         ']
         )
   m4+vga(|vga_pipe, @0, $vga_hsync, $vga_vsync, $vga_r, $vga_g, $vga_b)
\SV
   endmodule