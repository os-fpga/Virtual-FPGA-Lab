\m4_TLV_version 1d: tl-x.org

\SV
   m4_include_lib(['https://raw.githubusercontent.com/BalaDhinesh/Virtual-FPGA-Lab/main/viz_libraries/artix7_board.tlv'])
                   
\SV
   m4_ifelse_block(M4_MAKERCHIP, 1,['
   m4_makerchip_module   
   '],
   ['
   module top(input clk, input reset, output lcd_e, output lcd_rs, output [7:0] data);
      clock_divider dut1 (clk, divided_clk);
      test dut2 (clk, reset, lcd_e, lcd_rs, data);
   endmodule
   module test (input divided_clk, input reset, output lcd_e, output lcd_rs, output [7:0] data);
   ']
   )

\TLV
   |top_pipe
      @0
         $reset = *reset;
         $datas[25*8-1:0] = {8'h18, 8'h2D, 8'h2D, 8'hC0, 8'h21, 8'h21, 8'h21, 8'h6E, 8'h75, 8'h66, 8'h20, 8'h65, 8'h72, 8'h61,
                        8'h20, 8'h73, 8'h41, 8'h47, 8'h50, 8'h46, 8'h80, 8'h01, 8'h06, 8'h0C, 8'h38};
         $out[7:0] = $reset ? 0 : ($ii <= 2) ? $datas >> 8*$jj : >>1$out;
         $ii[3:0] = $reset ? 5'b11111 : (>>1$ii < 4) ? >>1$ii + 1 : 0;
         $jj[4:0] = $reset ? 0 : ($ii == 4) ? >>1$jj + 1 : (>>1$jj == 25) ? 4 : >>1$jj;
         $lcd_enable = $reset ? 0 : ($ii <= 2) ?  1 : ($ii > 2 & $ii < 4) ? 0 : >>1$lcd_enable;;
         $lcd_reset = ($jj > 4 & $jj != 21 & $jj != 24) ? 1 : 0;
         m4_ifelse_block(M4_MAKERCHIP, 1, ['
         '],
         ['
         *data = $out;
         *lcd_e = $lcd_enable;
         *lcd_rs = $lcd_reset;
         ']
         )
         
   m4+artix7_init(|top_pipe, @0)
   m4+artix7_lcd(|top_pipe, @0, $datas, $out, $ii, $jj, $lcd_enable, $lcd_reset)
\SV
   endmodule
