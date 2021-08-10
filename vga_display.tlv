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
	 module top_square (
    input  clk,     // 50 MHz clock
    input  btn_rst,      // reset button (active low)
    output reg vga_hsync,    // horizontal sync
    output reg vga_vsync,    // vertical sync
    output reg [3:0] vga_r,  // 4-bit VGA red
    output reg [3:0] vga_g,  // 4-bit VGA green
    output reg [3:0] vga_b   // 4-bit VGA blue
    );   
       wire clk_pix;  //25MHz
       clock_divider #(.DIV_VALUE(0)) dut(clk, clk_pix);
       test dut2 (clk_pix, btn_rst, vga_hsync, vga_vsync, vga_r, vga_g, vga_b);
   endmodule
   module test (input clk, input reset, output reg vga_hsync, output reg vga_vsync, output reg [3:0] vga_r, output reg [3:0] vga_g, output reg [3:0] vga_b);
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

\TLV init_cursor(|_pipe, @_stage, $_reset, $hsync, $vsync, M4_COUNTER, $_sx , $_sy)
   |_pipe
      @_stage
         $hsync = ~($_sx >= M4_HS_STA && $_sx < M4_HS_END);
         $vsync = ~($_sy >= M4_VS_STA && $_sy < M4_VS_END);
         $_sx[9:0] = $_reset ? 10'b1111111111 : >>1$_sx >= M4_LINE ? 0 : >>1$_sx + M4_COUNTER;
         $_sy[9:0] = $_reset ? 10'b1111111111 : (>>1$_sx >= M4_LINE ? (>>1$_sy >= M4_SCREEN ? 0 : >>1$_sy + M4_COUNTER) : $RETAIN);

         
\TLV
   m4+init_monitor(|vga_pipe, @0)
   m4+init_cursor(|vga_pipe, @0, $reset, $hsync, $vsync, M4_COUNTER, $sx, $sy) 
   m4_define(M4_BOARD, 4)
   m4+init(|top_pipe, @0)
   |vga_pipe
      @0
         $reset = *reset; 
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

