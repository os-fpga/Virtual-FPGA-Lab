\m4_TLV_version 1d: tl-x.org

\TLV artix7_init(|_pipe, @_stage)
   |_pipe
      @_stage
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
                           //global.canvas.sendToBack(logic_block);
                        },
                        {originX: "center",
                         originY: "center",
                         left: 0,
                         top: 10,
                         scaleX: 0.18,
                         scaleY: 0.18,
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
                  let seg = new fabric.Rect({
                     top: 60,
                     left: -244,
                     width: 140, 
                     height: 60, 
                     fill: "black",
                     opacity: 1
                  })
                return {objects :{logic_block, seg}};
                }
         /digit[3:0]
            /led[7:0]
               \viz_alpha
                  initEach() {
                     let sseg = (scopes.led.index == 7) ? new fabric.Circle({
                           top: 109,
                           left: (scopes.digit.index == 3) ? -122 : (scopes.digit.index == 0) ? -212 : (scopes.digit.index == 1) ? -182 : -152 ,
                           radius: 2,
                           opacity: 1,
                           fill: "grey"
                        }) 
                        :
                        new fabric.Rect({
                           top: 76 + ((scopes.led.index == 5) ? -4 : (scopes.led.index == 4) ? 16 : (scopes.led.index == 3) ? 31 : (scopes.led.index == 2) ? 16 : (scopes.led.index == 1) ? -4 : (scopes.led.index == 0) ? 11 : -8),
                           left: ((scopes.digit.index == 0) ? -224 : (scopes.digit.index == 1) ? -194 : (scopes.digit.index == 2) ? -164 : -134) + ((scopes.led.index == 5) ? 13 : (scopes.led.index == 4) ? 11 : (scopes.led.index == 3) ? -2 : (scopes.led.index == 2) ? -8 : (scopes.led.index == 1) ? -6 : -1),
                           width: ((this.getIndex() == 6) || (this.getIndex() == 3) || (this.getIndex() == 0)) ? 14 : 3,
                           height: ((this.getIndex() == 5) || (this.getIndex() == 4) || (this.getIndex() == 2) || (this.getIndex() == 1)) ? 14 : 3,
                           fill: "grey",
                           skewX: ((this.getIndex() == 5) || (this.getIndex() == 4) || (this.getIndex() == 2) || (this.getIndex() == 1)) ? -9 : 0,
                           opacity: 1
                        })
                     return{objects : {sseg}};
                  }
         
\TLV artix7_led(|_pipe, @_stage, $leds)
   |_pipe
      @_stage
         //$viz_leds[15:0] = {$L1,$P1,$N3,$P3,$U3,$W3,$V3,$V13,$V14,$U14,$U15,$W18,$V19,$U19,$E19,$U16};
         /led[15:0]
            \viz_alpha
               initEach() {
               debugger
                  let led = new fabric.Rect({
                        top: 150,
                        left: 218 - 27.5 * (this.getIndex() + 1),
                        width: 12, 
                        height: 12, 
                        fill: "red",
                        opacity: 0
                     })
                  /*let done_led = new fabric.Rect({
                        top: -108,
                        left: 191, 
                        width: 5, 
                        height: 8, 
                        fill: "green",
                        opacity: 1
                     }) */
                  return{objects : {led /*, done_led*/}}; 
               }, 
               renderEach() {
                     var mod = ((('/top|_pipe$leds'.asInt(-1) >> this.getScope("led").index) & 1) == 1);
                     this.getInitObject("led").set(mod ? {opacity: 1} : {opacity: 0});
                     //global.canvas.on('led:moving', function () {console.log('Event object:moving Triggered');});
                  }        
\TLV artix7_sseg(|_pipe, @_stage, $enable, $sseg)
   |_pipe
      @_stage
         /sseg
            \viz_alpha
               initEach() {
                            let seg = new fabric.Rect({
                        top: 60,
                        left: -244,
                        width: 140, 
                        height: 60, 
                        fill: "black",
                        opacity: 1
                     })
                              return {objects : {seg}}; 
                         },
         /digit[3:0]
            /led[7:0]
               \viz_alpha
                  initEach() {
                     let sseg = (scopes.led.index == 7) ? new fabric.Circle({
                           top: 109,
                           left: (scopes.digit.index == 3) ? -122 : (scopes.digit.index == 0) ? -212 : (scopes.digit.index == 1) ? -182 : -152 ,
                           radius: 2,
                           opacity: 1,
                           fill: "grey"
                        }) 
                        :
                        new fabric.Rect({
                           top: 76 + ((scopes.led.index == 5) ? -4 : (scopes.led.index == 4) ? 16 : (scopes.led.index == 3) ? 31 : (scopes.led.index == 2) ? 16 : (scopes.led.index == 1) ? -4 : (scopes.led.index == 0) ? 11 : -8),
                           left: ((scopes.digit.index == 0) ? -224 : (scopes.digit.index == 1) ? -194 : (scopes.digit.index == 2) ? -164 : -134) + ((scopes.led.index == 5) ? 13 : (scopes.led.index == 4) ? 11 : (scopes.led.index == 3) ? -2 : (scopes.led.index == 2) ? -8 : (scopes.led.index == 1) ? -6 : -1),
                           width: ((this.getIndex() == 6) || (this.getIndex() == 3) || (this.getIndex() == 0)) ? 14 : 3,
                           height: ((this.getIndex() == 5) || (this.getIndex() == 4) || (this.getIndex() == 2) || (this.getIndex() == 1)) ? 14 : 3,
                           fill: "grey",
                           skewX: ((this.getIndex() == 5) || (this.getIndex() == 4) || (this.getIndex() == 2) || (this.getIndex() == 1)) ? -9 : 0,
                           opacity: 1
                        })
                     return{objects : {sseg}};
                  },
                  renderEach() {
                     var enable = ('/top|_pipe$enable'.asBinaryStr());
                     var sseg1 = ('/top|_pipe$sseg'.asBinaryStr());
                     var fp_valid = sseg1[0] == 0
                     if(scopes.led.index == 7)
                     {
                        console.log("scopes.digit.index:", scopes.digit.index)
                        this.getInitObject("sseg").set(enable[scopes.digit.index] == 0 && fp_valid ? {fill: "red"} : {fill: "grey"})
                     }
                     else {
                        var hamm = ((('/top|_pipe$sseg'.asInt(-1) >> scopes.led.index) & 1) == 0);
                        this.getInitObject("sseg").set(hamm && enable[scopes.digit.index] == 0 ? {fill: "red"} : {fill: "grey"});
                     }
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
            $char1[7:0] = |_pipe$out == 8'h01 & |_pipe$lcd_reset == 0 ? 8'h20 : 
                          |_pipe>>1$wr_index1 == #chars1 && |_pipe$line == 1 && |_pipe$read_enable && |_pipe$lcd_reset == 1 ? |_pipe$out : 
                          $RETAIN;
         /chars2[40-1:0]
            $char2[7:0] = |_pipe$out == 8'h01 & |_pipe$lcd_reset == 0 ? 8'h20 : 
                          ((|_pipe>>1$wr_index2 == #chars2 && |_pipe$line == 2) | (|_pipe>>1$wr_index1 - 40 == #chars2 && |_pipe$line == 1)) && |_pipe$read_enable && |_pipe$lcd_reset == 1 ? |_pipe$out : 
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
                      fill : "transparent"
                     }
                  )
                  let logic_block = new fabric.Group([block_square],
                  {originX: "center",
                   originY: "center",
                  })
                  let lcd_img_url = "https://github.com/BalaDhinesh/Virtual-FPGA-Lab/blob/main/images/lcd_module.png?raw=true"
                  let lcd_img = new fabric.Image.fromURL(
                        lcd_img_url,
                        function (img) {
                           logic_block.add(img)
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
                   let start_led = new fabric.Rect({
                        top: -108,
                        left: -195,
                        width: 5,
                        height: 8,
                        fill: "red",
                        opacity: 1
                     })
                    let lcd = new fabric.Rect({
                        top: 280,
                        left: -165,
                        width: 295,
                        height: 80,
                        fill: "#FDFF32",
                        opacity: 1
                     })
                     let line1 = new fabric.Text("", {
                       left: -160,
                       top: 290,
                       fontSize: 30,
                       fontFamily: "Courier New",
                     })
                     let line2 = new fabric.Text("", {
                       left: -160,
                       top: 320,
                       fontSize: 35,
                       fontFamily: "Courier New",
                     })
                     let info = new fabric.Text("", {
                       left: -300,
                       top: -250,
                       fontSize: 15,
                       fontFamily: "Courier New",
                     })
                     let clock = new fabric.Text("Clock Frequency = 100Hz", {
                       left: 80,
                       top: -250,
                       fontSize: 15,
                       fontFamily: "Courier New",
                     })
                
                return {objects :{logic_block, lcd, line1, line2, info, clock}};
                },
             renderEach(){
                 let str1 = '/top|_pipe$str1'.asString().split("").reverse().join("")
                 let str2 = '/top|_pipe$str2'.asString().split("").reverse().join("")
                 let lcd_rst = '/top|_pipe$lcd_reset'.asBool()
                 this.getInitObjects().line1.setText(str1)
                 this.getInitObjects().line2.setText(str2)
                 let value_bin = '/top|_pipe$out'.asBinaryStr();
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
