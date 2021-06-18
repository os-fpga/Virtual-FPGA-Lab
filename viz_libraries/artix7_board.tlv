\m4_TLV_version 1d: tl-x.org

\TLV artix7_init()
   |top_pipe
      @0
         \viz_alpha
            initEach() {
                  let block_square = new fabric.Rect(
                     {originX: "center",
                      originY: "center",
                      width: 490,
                      height: 300,
                      fill: "white"
                     }
                  )
                  let logic_block = new fabric.Group([block_square],
                  {originX: "center",
                   originY: "center",
                   angle: 0,
                   width: 20,
                   height: 20
                  })
                  let fpga_img_url = "https://github.com/BalaDhinesh/Virtual-FPGA-Lab/blob/main/images/artix7.png?raw=true"
                  let fpga_img = new fabric.Image.fromURL(
                        fpga_img_url,
                        function (img) {
                           logic_block.add(img)
                           global.canvas.renderAll()
                        },
                        {originX: "center",
                         originY: "center",
                         left: 0,
                         top: 0,
                         scaleX: 0.2,
                         scaleY: 0.2,
                         angle: 0
                        }
                     )
                   let start_led = new fabric.Rect({
                        top: 200,
                        left: -195,
                        width: 5,
                        height: 8,
                        fill: "red",
                        opacity: 1
                     })
                return {objects :{logic_block}};
                },
                renderEach(){
                }
                
\TLV artix7_lcd(|_pipe, @_stage, $datas, $out, $ii, $jj, $lcd_enable, $lcd_reset)
   //for viz part
   |_pipe
      @_stage
         m4_ifelse_block(M4_MAKERCHIP, 1, ['
         // VIZ supports only 8 bit mode (4 bit mode not supported)
         $one_or_two[1:0] = $reset ? 0 : $out == 8'h38 ? 2 : $out == 8'h30 ? 1 : >>1$one_or_two;    // 1-line mode or 2-line mode
         $line[1:0] = $reset ? 0 : $lcd_reset == 0 ? ($out == 8'h80 | $out == 8'h01 |$out == 8'h02) & !$one_or_two == 0 ? 1 : 
                      $out == 8'hC0 & $one_or_two == 2 ? 2 :
                      $RETAIN: 
                      $RETAIN;    // assign line number
         $inc_or_dec[1:0] = $reset ? 0 : $out == 8'h06 ? 1 : 
                            $out == 8'h04 ? 2 : 
                            >>1$inc_or_dec;    // increment or decrement cursor command
         $read_enable = $lcd_enable == 1 && >>1$lcd_enable == 0;
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
            $char1[7:0] = |top_pipe$out == 8'h01 & |top_pipe$lcd_reset == 0 ? 8'h20 : 
                          |top_pipe>>1$wr_index1 == #chars1 && |top_pipe$line == 1 && |top_pipe$read_enable && |top_pipe$lcd_reset == 1 ? |top_pipe$out : 
                          $RETAIN;
         /chars2[40-1:0]
            $char2[7:0] = |top_pipe$out == 8'h01 & |top_pipe$lcd_reset == 0 ? 8'h20 : 
                          ((|top_pipe>>1$wr_index2 == #chars2 && |top_pipe$line == 2) | (|top_pipe>>1$wr_index1 - 40 == #chars2 && |top_pipe$line == 1)) && |top_pipe$read_enable && |top_pipe$lcd_reset == 1 ? |top_pipe$out : 
                          $RETAIN;
         $str1[8*16-1:0] = (/chars1[*]$char1 >> 8*$shift_left) << 8*$shift_right;
         $str2[8*16-1:0] = (/chars2[*]$char2 >> 8*$shift_left) << 8*$shift_right;

         '],
         ['
         ']
         )

         \viz_alpha
            initEach() {
                  let block_square = new fabric.Rect(
                     {originX: "center",
                      originY: "center",
                      width: 490,
                      height: 300,
                      fill: "white"
                     }
                  )
                  let logic_block = new fabric.Group([block_square],
                  {originX: "center",
                   originY: "center",
                   angle: 0,
                   width: 20,
                   height: 20
                  })
                  let fpga_img_url = "https://github.com/BalaDhinesh/Virtual-FPGA-Lab/blob/main/images/artix7_lcd.png?raw=true"
                  let fpga_img = new fabric.Image.fromURL(
                        fpga_img_url,
                        function (img) {
                           logic_block.add(img)
                           global.canvas.renderAll()
                        },
                        {originX: "center",
                         originY: "center",
                         left: 0,
                         top: 0,
                         scaleX: 0.25,
                         scaleY: 0.25,
                         angle: -1.3
                        }
                     )
                   let start_led = new fabric.Rect({
                        top: -108,
                        left: -195,
                        width: 5,
                        height: 8,
                        fill: "red",
                        opacity: 1
                     })
                    let lcd = new fabric.Rect({
                        top: 270,
                        left: -120,
                        width: 350,
                        height: 90,
                        fill: "#FDFF32",
                        opacity: 1
                     })
                     let line1 = new fabric.Text("", {
                       left: -110,
                       top: 270,
                       fontSize: 35,
                       fontFamily: "Courier New",
                     })
                     let line2 = new fabric.Text("", {
                       left: -110,
                       top: 310,
                       fontSize: 35,
                       fontFamily: "Courier New",
                     })
                     let info = new fabric.Text("", {
                       left: -300,
                       top: -300,
                       fontSize: 15,
                       fontFamily: "Courier New",
                     })
                     let clock = new fabric.Text("Clock Frequency = 100Hz", {
                       left: 80,
                       top: -300,
                       fontSize: 15,
                       fontFamily: "Courier New",
                     })
                return {objects :{logic_block, lcd, line1, line2, info, clock}};
                },
             renderEach(){
                 let str1 = '|top_pipe$str1'.asString().split("").reverse().join("")
                 let str2 = '|top_pipe$str2'.asString().split("").reverse().join("")
                 let lcd_rst = '|top_pipe$lcd_reset'.asBool()
                 this.getInitObjects().line1.setText(str1)
                 this.getInitObjects().line2.setText(str2)
                 let value_bin = '|top_pipe$out'.asBinaryStr();
                 if(!lcd_rst){
                 if (value_bin == "00111000"){
                    //8'h38
                    //Function Set: 8-bit, 2 Line, 5x7 Dots
                    this.getInitObjects().info.setText("Function Set: 8-bit, 2 Line, 5x7 Dots")
                 }else if (value_bin == "00110000"){
                    //Function Set: 8-bit,  Line, 5x7 Dots
                    //8'h30
                    this.getInitObjects().info.setText("Function Set: 8-bit, 1 Line, 5x7 Dots")
                 }else if (value_bin == "00001100"){
                    //Display on Cursor off
                    //8'h0C
                    this.getInitObjects().info.setText("Display on Cursor off")
                 }else if (value_bin == "00000110"){
                    //Entry Mode
                    //8'h06
                    this.getInitObjects().info.setText("Entry Mode: Increment, entire shift off")
                 }else if (value_bin == "00000100"){
                    //Entry Mode
                    //8'h04
                    this.getInitObjects().info.setText("Entry Mode: Decrement, entire shift off")
                 }else if (value_bin == "00000001"){
                    //Clear Display
                    //8'h01
                    this.getInitObjects().info.setText("Clear Display")
                 }else if (value_bin == "00000010"){
                    //Return home
                    //8'h02
                    this.getInitObjects().info.setText("Return home")
                 }else if (value_bin == "10000000"){
                    //force cursor to begin at first line
                    //8'h80
                    this.getInitObjects().info.setText("force cursor to begin at first line")
                 }else if (value_bin == "11000000"){
                    //force cursor to begin at second line
                    //8'hC0
                    this.getInitObjects().info.setText("force cursor to begin at second line")
                 }else if (value_bin == "00011000"){
                    //Shift display left
                    //8'h18
                    this.getInitObjects().info.setText("Shift entire display to the left")
                 }else if (value_bin == "00011100"){
                    //Shift display right
                    //8'h1C
                    this.getInitObjects().info.setText("Shift entire display to the right")
                 }else if (value_bin == "00010000"){
                    //Shift cursor left 
                    //8'h10
                    this.getInitObjects().info.setText("Shift cursor to the left")
                 }else if (value_bin == "00010100"){
                    //Shift cursor right
                    //8'h14
                    this.getInitObjects().info.setText("Shift cursor to the right")
                 }
              }else {
                 this.getInitObjects().info.setText("data instruction")
              }
             }
