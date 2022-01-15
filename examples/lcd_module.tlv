\m4_TLV_version 1d -p verilog --bestsv --noline: tl-x.org
\SV
   m4_include_lib(['https://raw.githubusercontent.com/BalaDhinesh/Virtual-FPGA-Lab/main/tlv_lib/fpga_includes.tlv'])
\SV
   m4_ifelse_block(M4_MAKERCHIP, 1,['
   m4_makerchip_module   
   '],['
   module top(input clk, input reset, output lcd_e, output lcd_rs, output [7:0] data);
   '])
      logic [7:0] data;
      logic lcd_rs;
      logic lcd_e;
\TLV
   |lcd_pipe
      @0
         // This program prints the following in the LCD 16x2 display
         // Line 1: FPGAs are fun!!!
         // Line 2: --
         // And left shift line1 and line2 once completed
         // NOTE: This visualization supports only 8 bit data/command mode
         // LCD commands supported:
         // 8'h38 - Function Set: 8-bit, 2 Line, 5x7 Dots
         // 8'h30 - Function Set: 8-bit, 1 Line, 5x7 Dots
         // 8'h0C - Display on Cursor off
         // 8'h06 - Entry Mode: Increment, entire shift off
         // 8'h04 - Entry Mode: Decrement, entire shift off
         // 8'h01 - Clear display
         // 8'h02 - Return home
         // 8'h80 - force cursor to begin at first line
         // 8'hC0 - force cursor to begin at second line
         // 8'h18 - Shift entire display to the left
         // 8'h1C - Shift entire display to the right
         // 8'h10 - Shift cursor left 
         // 8'h14 - Shift cursor right
         
         // Assumed clock frequency is 50MHz, so code runs for every 100Hz
         // i.e (50MHz) / (100Hz) = 500000 cycles after refresh
         m4+fpga_heartbeat($refresh, 1, 500000)
         $reset = *reset;
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
         *data = $out;
         *lcd_e = $lcd_enable;
         *lcd_rs = $lcd_reset;
   // M4_BOARD numbering
   // 1 - Zedboard
   // 2 - Artix-7
   // 3 - Basys3
   // 4 - Icebreaker
   // 5 - Nexys
   m4_define(M4_BOARD, 2)
   m4+fpga_init()
   m4+fpga_lcd(*data, *lcd_e, *lcd_rs) 
\SV
   endmodule