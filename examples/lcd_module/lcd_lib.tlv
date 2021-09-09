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
\TLV fpga_lcd1($_out, $_lcd_enable, $_lcd_reset)
   //for viz part
   |fpga_lcd_macro
      @0
         m4_ifelse_block(M4_MAKERCHIP, 1, ['
         $reset = *reset;

         // copying SystemVerilog/TL-Verilog to TL-Verilog signal
         $out[\$size($_out)-1:0] = $_out;
         $lcd_enable = $_lcd_enable;
         $lcd_reset = $_lcd_reset;

         // This code supports only 8 bit mode (4 bit mode not supported)
         $one_or_two[1:0] = $reset ? 0 : $out == 8'h38 ? 2 : $out == 8'h30 ? 1 : >>1$one_or_two;    // 1-line mode or 2-line mode
         $line[1:0] = $reset ? 0 : $lcd_reset == 0 ? ($out == 8'h80 | $out == 8'h01 |$out == 8'h02) & !$one_or_two == 0 ? 1 : 
                      $out == 8'hC0 & $one_or_two == 2 ? 2 :
                      $RETAIN: 
                      $RETAIN;    // assign line number
         $inc_or_dec[1:0] = $reset ? 0 : $out == 8'h06 ? 1 : 
                            $out == 8'h04 ? 2 : 
                            >>1$inc_or_dec;    // increment or decrement cursor command
         $read_enable = $lcd_enable == 1 && >>1$lcd_enable == 0;

        // Each line in LCD display supports upto 40 characters. You can get access by shifting the data. If data exceeds 40, it automatically moves to the next line
         $shift_left[5:0] = $reset | >>1$shift_left == 40 ? 0 : 
                            ($out == 8'h18 & !$lcd_reset & $read_enable ? >>1$shift_left + 1 : 
                            $RETAIN);          // no of shift lefts
         $shift_right[5:0] = $reset | >>1$shift_right == 40 ? 0 : 
                             ($out == 8'h1C & $lcd_reset == 0 & $read_enable ? >>1$shift_right + 1 : 
                             $RETAIN);         // no of shift rights
         $wr_index1[6:0] = (($reset | $out == 8'h01 | $out == 8'h80) & $lcd_reset == 0) ? 0 : 
                             $read_enable && $line == 1 && $lcd_reset == 0 ? ($out == 8'h14 ? >>1$wr_index1 + 1 : 
                            ($out == 8'h10 ? >>1$wr_index1 - 1 : $RETAIN)) : 
                             $read_enable && $line == 1 && $lcd_reset == 1 ? ($inc_or_dec == 1 ? >>1$wr_index1 + 1 : 
                             $inc_or_dec == 2 ? >>1$wr_index1 - 1 : >>1$wr_index1) : 
                             >>1$wr_index1;    // cursor index if line 1
         $wr_index2[5:0] = (($reset | $out == 8'h01 | $out == 8'hC0) & $lcd_reset == 0) ? 0 : 
                             $read_enable && $line == 2 && $lcd_reset == 0 ? ($out == 8'h14 ? >>1$wr_index2 + 1 : 
                            ($out == 8'h10 ? >>1$wr_index2 - 1 : $RETAIN)) : 
                             $read_enable && $line == 2 && $lcd_reset == 1 ? ($inc_or_dec == 1 ? >>1$wr_index2 + 1 : 
                             $inc_or_dec == 2 ? >>1$wr_index2 - 1 : >>1$wr_index2) : 
                             >>1$wr_index2;    // cursor index if line 2

         /chars1[40-1:0]
            $char1[7:0] = |fpga_lcd_macro$out == 8'h01 & |fpga_lcd_macro$lcd_reset == 0 ? 8'h20 : 
                          |fpga_lcd_macro>>1$wr_index1 == #chars1 && |fpga_lcd_macro$line == 1 && |fpga_lcd_macro$read_enable && |fpga_lcd_macro$lcd_reset == 1 ? |fpga_lcd_macro$out : 
                          $RETAIN;
        // text to display in line 2
         /chars2[40-1:0]
            $char2[7:0] = |fpga_lcd_macro$out == 8'h01 & |fpga_lcd_macro$lcd_reset == 0 ? 8'h20 : 
                          ((|fpga_lcd_macro>>1$wr_index2 == #chars2 && |fpga_lcd_macro$line == 2) | (|fpga_lcd_macro>>1$wr_index1 - 40 == #chars2 && |fpga_lcd_macro$line == 1)) && |fpga_lcd_macro$read_enable && |fpga_lcd_macro$lcd_reset == 1 ? |fpga_lcd_macro$out : 
                          $RETAIN;

        // text to display in line 1 and line 2 after left and right shifts if any
         $str1[8*16-1:0] = (/chars1[*]$char1 >> 8*$shift_left) << 8*$shift_right;
         $str2[8*16-1:0] = (/chars2[*]$char2 >> 8*$shift_left) << 8*$shift_right;
         \viz_alpha
            initEach() {
                // Add LCD 16x2 image
                  let lcd_img_url = "https://github.com/BalaDhinesh/Virtual-FPGA-Lab/blob/main/images/lcd_module.png?raw=true"
                  let lcd_img = new fabric.Image.fromURL(
                        lcd_img_url,
                        function (img) {
                           global.canvas.add(img)
                           global.canvas.sendToBack(img)
                           global.canvas.renderAll()
                        },
                        {originX: "center",
                         originY: "center",
                         left: -35,
                         top: 320,
                         scaleX: 0.2,
                         scaleY: 0.2,
                         angle: 0.4
                        }
                     )
                     
                    // Just making the LCD background yellow
                    let lcd = new fabric.Rect({
                        top: 280,
                        left: -165,
                        width: 295,
                        height: 80,
                        fill: "#FDFF32",
                        opacity: 1
                     })
                     // text to display for line 1
                     let line1 = new fabric.Text("", {
                       left: -160,
                       top: 290,
                       fontSize: 30,
                       fontFamily: "Courier New",
                     })
                     // text to display for line 2
                     let line2 = new fabric.Text("", {
                       left: -160,
                       top: 320,
                       fontSize: 30,
                       fontFamily: "Courier New",
                     })
                return {objects :{lcd, line1, line2}};
                },
             renderEach(){
                 // Get the TL-V values of $str1 and $str2 and display in lines 1 and 2 respectively
                 let str1 = '/top|fpga_lcd_macro$str1'.asString().split("").reverse().join("")
                 let str2 = '/top|fpga_lcd_macro$str2'.asString().split("").reverse().join("")
                 this.getInitObjects().line1.setText(str1)
                 this.getInitObjects().line2.setText(str2)
             }
         '])
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
         m4+fpga_refresh($refresh, m4_ifelse(M4_MAKERCHIP, 1, 1, 500000))
         
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
            $lcd_enable = $reset ? 0 : ($Ii <= 2) ?  1 : ($Ii > 2 & $Ii < 4) ? 0 : >>1$lcd_enable;
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
   m4+fpga_lcd1(*data, *lcd_e, *lcd_rs) 
\SV
   endmodule
   