m4_ifelse_block(M4_MAKERCHIP, 1,['
   m4_makerchip_module   
   '],['
   module top(
    input clk, vauxp7, vauxn7, vauxp15, vauxn15,
    output lcd_e, lcd_rs,
    output [7:0] data
	);
   wire [15:0] data_adc;
   reg [6:0] addr_in;
   wire enable, ready;
   xadc_wiz_0 ADC1
		(
          .daddr_in(addr_in),            // Address bus for the dynamic reconfiguration port
          .dclk_in(clk),             // Clock input for the dynamic reconfiguration port
          .den_in(1),              // Enable Signal for the dynamic reconfiguration port
          .di_in(0),               // Input data bus for the dynamic reconfiguration port
          .dwe_in(0),              // Write Enable for the dynamic reconfiguration port
          .vauxp6(),              // Auxiliary channel 6
          .vauxn6(),
          .vauxp7(vauxp7),              // Auxiliary channel 7
          .vauxn7(vauxn7),
          .vauxp14(),             // Auxiliary channel 14
          .vauxn14(),
          .vauxp15(vauxp15),             // Auxiliary channel 15
          .vauxn15(vauxn15),
          .busy_out(),            // ADC Busy signal
          .channel_out(),         // Channel Selection Outputs
          .do_out(data_adc),              // Output data bus for dynamic reconfiguration port
          .drdy_out(ready),            // Data ready signal for the dynamic reconfiguration port
          .eoc_out(enable),             // End of Conversion Signal
          .eos_out(),             // End of Sequence Signal
          .alarm_out(),           // OR'ed output of all the Alarms    
          .vp_in(0),               // Dedicated Analog Input Pair
          .vn_in(0)
		);
   module test (input clk, input data_adc, input ready, output addr_in);
   ']
   )  
\TLV init(|_pipe, @_stage)
   |_pipe
      @_stage
         m4_ifelse_block(M4_MAKERCHIP, 1, ['
         m4_ifelse_block(M4_BOARD, 1,['
         \viz_alpha
            initEach() {
                  let fpga_img_url = "https://github.com/BalaDhinesh/Virtual-FPGA-Lab/blob/main/images/Zedboard.png?raw=true"
                  let fpga_img = new fabric.Image.fromURL(
                        fpga_img_url,
                        function (img) {
                           global.canvas.add(img)
                           global.canvas.sendToBack(img);
                        },
                        {originX: "center",
                         originY: "center",
                         left: 0,
                         top: 10,
                         scaleX: 0.3,
                         scaleY: 0.3,
                         angle: 0
                        }
                     )
                }
         '],['
         m4_ifelse_block(M4_BOARD, 2,['
         \viz_alpha
            initEach() {
                  let fpga_img_url = "https://github.com/BalaDhinesh/Virtual-FPGA-Lab/blob/main/images/artix7.png?raw=true"
                  let fpga_img = new fabric.Image.fromURL(
                        fpga_img_url,
                        function (img) {
                           global.canvas.add(img)
                           global.canvas.sendToBack(img);
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
                  let seg = new fabric.Rect({
                     top: 60,
                     left: -244,
                     width: 140, 
                     height: 60, 
                     fill: "black",
                     opacity: 1
                  })
                return {objects :{seg}};
                
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
                           top: 76 + ((scopes.led.index == 1) ? -4 : (scopes.led.index == 2) ? 16 : (scopes.led.index == 3) ? 31 : (scopes.led.index == 4) ? 16 : (scopes.led.index == 5) ? -4 : (scopes.led.index == 6) ? 11 : -8),
                           left: ((scopes.digit.index == 0) ? -224 : (scopes.digit.index == 1) ? -194 : (scopes.digit.index == 2) ? -164 : -134) + ((scopes.led.index == 5) ? 13 : (scopes.led.index == 4) ? 11 : (scopes.led.index == 3) ? -2 : (scopes.led.index == 2) ? -8 : (scopes.led.index == 1) ? -6 : -1),
                           width: ((this.getIndex() == 6) || (this.getIndex() == 3) || (this.getIndex() == 0)) ? 14 : 3,
                           height: ((this.getIndex() == 5) || (this.getIndex() == 4) || (this.getIndex() == 2) || (this.getIndex() == 1)) ? 14 : 3,
                           fill: "grey",
                           skewX: ((this.getIndex() == 5) || (this.getIndex() == 4) || (this.getIndex() == 2) || (this.getIndex() == 1)) ? -9 : 0,
                           opacity: 1
                        })
                     return{objects : {sseg}};
                  }
         '],['
         m4_ifelse_block(M4_BOARD, 3,['
         \viz_alpha
            initEach() {
                  let fpga_img_url = "https://github.com/BalaDhinesh/Virtual-FPGA-Lab/blob/main/images/basys3.png?raw=true"
                  let fpga_img = new fabric.Image.fromURL(
                        fpga_img_url,
                        function (img) {
                           global.canvas.add(img)
                           global.canvas.sendToBack(img);
                        },
                        {originX: "center",
                         originY: "center",
                         left: 0,
                         top: 10,
                         scaleX: 0.09,
                         scaleY: 0.09,
                         angle: 0
                        }
                     )
                  let seg = new fabric.Rect({
                           top: 50,
                           left: -182,
                           width: 124, 
                           height: 39, 
                           fill: "black",
                           opacity: 1
                        })
                return {objects :{seg}};
                }
         /digit[3:0]
            /led[7:0]
               \viz_alpha
                  initEach() {
                     let sseg = (scopes.led.index == 7) ? new fabric.Circle({
                           top: 79,
                           left: (scopes.digit.index == 0) ? -157 : (scopes.digit.index == 1) ? -127 : (scopes.digit.index == 2) ? -97 : -67 ,
                           radius: 2,
                           opacity: 1,
                           fill: "grey"
                        }) 
                        :
                        new fabric.Rect({
                           top: 56 + ((scopes.led.index == 5) ? 1 : (scopes.led.index == 4) ? 13 : (scopes.led.index == 3) ? 23 : (scopes.led.index == 2) ? 13 : (scopes.led.index == 1) ? 1 : (scopes.led.index == 0) ? 11 : 0),
                           left: ((scopes.digit.index == 0) ? -169 : (scopes.digit.index == 1) ? -139 : (scopes.digit.index == 2) ? -109 : -79) + ((scopes.led.index == 5) ? 10 : (scopes.led.index == 4) ? 8 : (scopes.led.index == 3) ? -2 : (scopes.led.index == 2) ? -6 : (scopes.led.index == 1) ? -4 : 0),
                           width: ((this.getIndex() == 6) || (this.getIndex() == 3) || (this.getIndex() == 0)) ? 11 : 3,
                           height: ((this.getIndex() == 5) || (this.getIndex() == 4) || (this.getIndex() == 2) || (this.getIndex() == 1)) ? 11 : 3,
                           fill: "grey",
                           skewX: ((this.getIndex() == 5) || (this.getIndex() == 4) || (this.getIndex() == 2) || (this.getIndex() == 1)) ? -9 : 0,
                           opacity: 1
                        })
                     return{objects : {sseg }};
                  }
         '],['
         m4_ifelse_block(M4_BOARD, 4,['
         \viz_alpha
            initEach() {
                  let fpga_img_url = "https://github.com/BalaDhinesh/Virtual-FPGA-Lab/blob/main/images/iceBreaker.png?raw=true"
                  let fpga_img = new fabric.Image.fromURL(
                        fpga_img_url,
                        function (img) {
                           global.canvas.add(img)
                           global.canvas.sendToBack(img);
                        },
                        {originX: "center",
                         originY: "center",
                         left: -100,
                         top: 10,
                         scaleX: 0.5,
                         scaleY: 0.5,
                         angle: 180
                        }
                     )
                }
         '],['
         m4_ifelse_block(M4_BOARD, 5,['
         \viz_alpha
            initEach() {
                  let fpga_img_url = "https://github.com/BalaDhinesh/Virtual-FPGA-Lab/blob/main/images/NEXYS_A7.png?raw=true"
                  let fpga_img = new fabric.Image.fromURL(
                        fpga_img_url,
                        function (img) {
                           global.canvas.add(img)
                           global.canvas.sendToBack(img);
                        },
                        {originX: "center",
                         originY: "center",
                         scaleX: 1,
                         scaleY: 1,
                        }
                     )
                let seg = new fabric.Rect({
                     top: 90,
                     left: -126,
                     width: 218, 
                     height: 35, 
                     fill: "black",
                     opacity: 1
                  })
                
                return {objects :{seg}};
             }
         /digit[7:0]
            /led[7:0]
               \viz_alpha
                  initEach() {
                     let sseg = (scopes.led.index == 7) ? new fabric.Circle({
                           top: 119,
                           //left: (scopes.digit.index == 3) ? -122 : (scopes.digit.index == 0) ? -212 : (scopes.digit.index == 1) ? -182 : -152 ,
                           left : ((scopes.digit.index == 7) ? -104 : (scopes.digit.index == 6) ? -79 : (scopes.digit.index == 5) ? -54 : (scopes.digit.index == 4) ? -29 : (scopes.digit.index == 3) ? 6 : (scopes.digit.index == 2) ? 31 : (scopes.digit.index == 1) ? 56 : 81),
                           radius: 2,
                           opacity: 1,
                           fill: "grey"
                        }) 
                        :
                        new fabric.Rect({
                           top: 76 + ((scopes.led.index == 5) ? 19 : (scopes.led.index == 4) ? 32 : (scopes.led.index == 3) ? 43 : (scopes.led.index == 2) ? 32 : (scopes.led.index == 1) ? 19 : (scopes.led.index == 0) ? 30 : 18),
                           left: ((scopes.digit.index == 7) ? -114 : (scopes.digit.index == 6) ? -89 : (scopes.digit.index == 5) ? -64 : (scopes.digit.index == 4) ? -39 : (scopes.digit.index == 3) ? -4 : (scopes.digit.index == 2) ? 21 : (scopes.digit.index == 1) ? 46 : 71) + ((scopes.led.index == 5) ? 10 : (scopes.led.index == 4) ? 8 : (scopes.led.index == 3) ? -4 : (scopes.led.index == 2) ? -8 : (scopes.led.index == 1) ? -6 : (scopes.led.index == 0) ? -2 : -1),
                           width: ((this.getIndex() == 6) || (this.getIndex() == 3) || (this.getIndex() == 0)) ? 12 : 3,
                           height: ((this.getIndex() == 5) || (this.getIndex() == 4) || (this.getIndex() == 2) || (this.getIndex() == 1)) ? 11 : 3,
                           fill: "grey",
                           skewX: ((this.getIndex() == 5) || (this.getIndex() == 4) || (this.getIndex() == 2) || (this.getIndex() == 1)) ? -9 : 0,
                           opacity: 1
                        })
                     return{objects : {sseg}};
                  },
         '])
         '])
         '])
         '])
         '])
         '])
\TLV led(|_pipe, @_stage, $_leds)
   |_pipe
      @_stage
         m4_ifelse_block(M4_MAKERCHIP, 1, ['
         m4_ifelse_block(M4_BOARD, 1,['
         /led[7:0]
            \viz_alpha
               initEach() {
                  let led = new fabric.Rect({
                        top: 233,
                        left: 151 - 32 * (this.getIndex() + 1),
                        width: 6, 
                        height: 11, 
                        fill: "red",
                        opacity: 0
                     })
                  return{objects : {led}}; 
               }, 
               renderEach() {
                     var mod = ((('/top|_pipe$_leds'.asInt(-1) >> this.getScope("led").index) & 1) == 1);
                     this.getInitObject("led").set(mod ? {opacity: 1} : {opacity: 0});
                  }
         '],['
         m4_ifelse_block(M4_BOARD, 2,['
         /led[15:0]
            \viz_alpha
               initEach() {
                  let led = new fabric.Rect({
                        top: 150,
                        left: 218 - 27.5 * (this.getIndex() + 1),
                        width: 12, 
                        height: 12, 
                        fill: "red",
                        opacity: 0
                     })
                  return{objects : {led}}; 
               }, 
               renderEach() {
                     var mod = ((('/top|_pipe$_leds'.asInt(-1) >> this.getScope("led").index) & 1) == 1);
                     this.getInitObject("led").set(mod ? {opacity: 1} : {opacity: 0});
                  } 
         '],['
         m4_ifelse_block(M4_BOARD, 3,['
         /led[15:0]
            \viz_alpha
               initEach() {
                  let led = new fabric.Rect({
                        top: 92,
                        left: 195 - 25 * (this.getIndex() + 1),
                        width: 6, 
                        height: 10, 
                        fill: "red",
                        opacity: 0
                     })
                  return{objects : {led}}; 
               }, 
               renderEach() {
                     var mod = ((('/top|_pipe$_leds'.asInt(-1) >> this.getScope("led").index) & 1) == 1);
                     this.getInitObject("led").set(mod ? {opacity: 1} : {opacity: 0});
                  }  
         '],['
         m4_ifelse_block(M4_BOARD, 4,['

         
         '],['
         m4_ifelse_block(M4_BOARD, 5,['
         /led[15:0]
            \viz_alpha
               initEach() {
                  let led = new fabric.Rect({
                        top: 128,
                        left: 185 - 21.2 * (this.getIndex() + 1),
                        width: 8, 
                        height: 8, 
                        fill: "red",
                        opacity: 0
                     })
                  return{objects : {led}}; 
               }, 
               renderEach() {
                     var mod = ((('/top|_pipe$_leds'.asInt(-1) >> this.getScope("led").index) & 1) == 1);
                     this.getInitObject("led").set(mod ? {opacity: 1} : {opacity: 0});
               } 
         '])
         '])
         '])
         '])
         '])
         '])
         
\TLV template(|_pipe, @_stage, $leds)
   |_pipe
      @_stage
         m4_ifelse_block(M4_MAKERCHIP, 1, ['
         m4_ifelse_block(M4_BOARD, 1,['
         '],['
         m4_ifelse_block(M4_BOARD, 2,['
         '],['
         m4_ifelse_block(M4_BOARD, 3,['
         '],['
         m4_ifelse_block(M4_BOARD, 4,['
         '],['
         m4_ifelse_block(M4_BOARD, 5,['
         '])
         '])
         '])
         '])
         '])
         '])
         
\TLV sseg(|_pipe, @_stage, $_digit, $_sseg, $_dp)
   |_pipe
      @_stage
         m4_ifelse_block(M4_MAKERCHIP, 1, ['
         m4_ifelse_block(M4_BOARD, 1,['
         '],['
         m4_ifelse_block(M4_BOARD, 2,['
         /digit[3:0]
            /led[7:0]
               \viz_alpha
                  initEach() {
                     let sseg = (scopes.led.index == 7) ? new fabric.Circle({
                           top: 109,
                           left: (scopes.digit.index == 0) ? -122 : (scopes.digit.index == 3) ? -212 : (scopes.digit.index == 2) ? -182 : -152 ,
                           radius: 2,
                           opacity: 1,
                           fill: "grey"
                        }) 
                        :
                        new fabric.Rect({
                           top: 76 + ((scopes.led.index == 5) ? -4 : (scopes.led.index == 4) ? 16 : (scopes.led.index == 3) ? 31 : (scopes.led.index == 2) ? 16 : (scopes.led.index == 1) ? -4 : (scopes.led.index == 0) ? 11 : -8),
                           left: ((scopes.digit.index == 3) ? -224 : (scopes.digit.index == 2) ? -194 : (scopes.digit.index == 1) ? -164 : -134) + ((scopes.led.index == 5) ? 13 : (scopes.led.index == 4) ? 11 : (scopes.led.index == 3) ? -2 : (scopes.led.index == 2) ? -8 : (scopes.led.index == 1) ? -6 : -1),
                           width: ((this.getIndex() == 6) || (this.getIndex() == 3) || (this.getIndex() == 0)) ? 14 : 3,
                           height: ((this.getIndex() == 5) || (this.getIndex() == 4) || (this.getIndex() == 2) || (this.getIndex() == 1)) ? 14 : 3,
                           fill: "grey",
                           skewX: ((this.getIndex() == 5) || (this.getIndex() == 4) || (this.getIndex() == 2) || (this.getIndex() == 1)) ? -9 : 0,
                           opacity: 1
                        })
                     return{objects : {sseg}};
                  },
                  renderEach() {
                     var enable = ('/top|_pipe$_digit'.asBinaryStr().split("").reverse().join(""));
                     this.getInitObject("sseg").bringToFront()
                     var fp_valid = '/top|_pipe$_dp'.asBool() == 1
                     if(scopes.led.index == 7)
                     {
                        this.getInitObject("sseg").set(enable[scopes.digit.index] == 1 && fp_valid ? {fill: "red"} : {fill: "grey"})
                     }
                     else {
                        var hamm = ((('/top|_pipe$_sseg'.asInt(-1) >> scopes.led.index) & 1) == 0);
                        this.getInitObject("sseg").set(hamm && enable[scopes.digit.index] == 1 ? {fill: "red"} : {fill: "grey"});
                     }
                  }
         '],['
         m4_ifelse_block(M4_BOARD, 3,['
         /digit[3:0]
            /led[7:0]
               \viz_alpha
                  initEach() {
                     let sseg = (scopes.led.index == 7) ? new fabric.Circle({
                           top: 79,
                           left: (scopes.digit.index == 3) ? -157 : (scopes.digit.index == 2) ? -127 : (scopes.digit.index == 1) ? -97 : -67 ,
                           radius: 2,
                           opacity: 1,
                           fill: "grey"
                        }) 
                        :
                        new fabric.Rect({
                           top: 56 + ((scopes.led.index == 5) ? 1 : (scopes.led.index == 4) ? 13 : (scopes.led.index == 3) ? 23 : (scopes.led.index == 2) ? 13 : (scopes.led.index == 1) ? 1 : (scopes.led.index == 0) ? 11 : 0),
                           left: ((scopes.digit.index == 3) ? -169 : (scopes.digit.index == 2) ? -139 : (scopes.digit.index == 1) ? -109 : -79) + ((scopes.led.index == 5) ? 10 : (scopes.led.index == 4) ? 8 : (scopes.led.index == 3) ? -2 : (scopes.led.index == 2) ? -6 : (scopes.led.index == 1) ? -4 : 0),
                           width: ((this.getIndex() == 6) || (this.getIndex() == 3) || (this.getIndex() == 0)) ? 11 : 3,
                           height: ((this.getIndex() == 5) || (this.getIndex() == 4) || (this.getIndex() == 2) || (this.getIndex() == 1)) ? 11 : 3,
                           fill: "grey",
                           skewX: ((this.getIndex() == 5) || (this.getIndex() == 4) || (this.getIndex() == 2) || (this.getIndex() == 1)) ? -9 : 0,
                           opacity: 1
                        })
                     return{objects : {sseg }};
                  },
                  renderEach() {
                     var enable = ('/top|_pipe$_digit'.asBinaryStr().split("").reverse().join(""));
                     this.getInitObject("sseg").bringToFront()
                     var fp_valid = '/top|_pipe$_dp'.asBool() == 0
                     if(scopes.led.index == 7)
                     {
                        this.getInitObject("sseg").set(enable[scopes.digit.index] == 0 && fp_valid ? {fill: "red"} : {fill: "grey"})
                     }
                     else {
                        var hamm = ((('/top|_pipe$_sseg'.asInt(-1) >> scopes.led.index) & 1) == 0);
                        this.getInitObject("sseg").set(hamm && enable[scopes.digit.index] == 0 ? {fill: "red"} : {fill: "grey"});
                     }
                  }
         '],['
         m4_ifelse_block(M4_BOARD, 4,['
         \viz_alpha
            initEach() {
                  
                  let sseg_img_url = "https://github.com/BalaDhinesh/Virtual-FPGA-Lab/blob/main/images/ice_sseg.png?raw=true"
                  let sseg_img = new fabric.Image.fromURL(
                        sseg_img_url,
                        function (img) {
                           global.canvas.add(img)
                           global.canvas.sendToBack(img);
                        },
                        {originX: "center",
                         originY: "center",
                         left: 177,
                         top: 10,
                         scaleX: 0.3,
                         scaleY: 0.3,
                        }
                     )
                   let sseg_img2 = new fabric.Image.fromURL(
                        sseg_img_url,
                        function (img) {
                           global.canvas.add(img)
                           global.canvas.sendToBack(img);
                        },
                        {originX: "center",
                         originY: "center",
                         left: 177,
                         top: -145,
                         scaleX: 0.3,
                         scaleY: 0.3,
                        }
                     )
                   let seg = new fabric.Rect({
                     top: -60,
                     left: 130,
                     width: 176, 
                     height: 140, 
                     fill: "black",
                     opacity: 1
                  })
                  let seg1 = new fabric.Rect({
                     top: -215,
                     left: 130,
                     width: 176, 
                     height: 140, 
                     fill: "black",
                     opacity: 1
                  })
                return {objects :{seg, seg1}};
                }
         /digit[3:0]
            /led[7:0]
               \viz_alpha
                  initEach() {
                     let sseg = (scopes.led.index == 7) ? new fabric.Circle({
                           top: (scopes.digit.index == 2) || (scopes.digit.index == 3) ? -110 : 42,
                           left: (scopes.digit.index == 0 | scopes.digit.index == 2) ? 270 : 195 ,
                           radius: 4,
                           opacity: 1,
                           fill: "grey"
                        }) 
                        :
                        new fabric.Rect({
                           top: (((scopes.digit.index == 2) || (scopes.digit.index == 3)) ? -160 : -10) + ((scopes.led.index == 5) ? -28 : (scopes.led.index == 4) ? 16 : (scopes.led.index == 3) ? 54 : (scopes.led.index == 2) ? 16 : (scopes.led.index == 1) ? -28 : (scopes.led.index == 0) ? 10 : -30),
                           left: ((scopes.digit.index == 0) || (scopes.digit.index == 2) ? 240 : 165) + ((scopes.led.index == 5) ? 26 : (scopes.led.index == 4) ? 19 : (scopes.led.index == 3) ? -12 : (scopes.led.index == 2) ? -20 : (scopes.led.index == 1) ? -13 : (scopes.led.index == 6) ? 1 : -5),
                           width: ((this.getIndex() == 6) || (this.getIndex() == 3) || (this.getIndex() == 0)) ? 30 : 6,
                           height: ((this.getIndex() == 5) || (this.getIndex() == 4) || (this.getIndex() == 2) || (this.getIndex() == 1)) ? 40 : 6,
                           fill: "grey",
                           skewX: ((this.getIndex() == 5) || (this.getIndex() == 4) || (this.getIndex() == 2) || (this.getIndex() == 1)) ? -9 : 0,
                           opacity: 1
                        })
                     return{objects : {sseg}};
                  },
                  renderEach() {
                     var enable = ('/top|_pipe$_digit'.asBinaryStr().split("").reverse().join(""));
                     var dp = ('/top|_pipe$_dp'.asBinaryStr());
                     this.getInitObject("sseg").bringToFront()
                     var fp_valid = dp == 0
                     if(scopes.led.index == 7)
                     {
                        this.getInitObject("sseg").set(enable[scopes.digit.index] == 0 && fp_valid ? {fill: "red"} : {fill: "grey"})
                     }
                     else {
                        var hamm = ((('/top|_pipe$_sseg'.asInt(-1) >> scopes.led.index) & 1) == 0);
                        this.getInitObject("sseg").set(hamm && (enable[scopes.digit.index] == 0) ? {fill: "red"} : {fill: "grey"});
                     }
                  }
         '],['
         m4_ifelse_block(M4_BOARD, 5,['
         /digit[7:0]
            /led[7:0]
               \viz_alpha
                  initEach() {
                     let sseg = (scopes.led.index == 7) ? new fabric.Circle({
                           top: 119,
                           //left: (scopes.digit.index == 3) ? -122 : (scopes.digit.index == 0) ? -212 : (scopes.digit.index == 1) ? -182 : -152 ,
                           left : ((scopes.digit.index == 7) ? -104 : (scopes.digit.index == 6) ? -79 : (scopes.digit.index == 5) ? -54 : (scopes.digit.index == 4) ? -29 : (scopes.digit.index == 3) ? 6 : (scopes.digit.index == 2) ? 31 : (scopes.digit.index == 1) ? 56 : 81),
                           radius: 2,
                           opacity: 1,
                           fill: "grey"
                        }) 
                        :
                        new fabric.Rect({
                           top: 76 + ((scopes.led.index == 5) ? 19 : (scopes.led.index == 4) ? 32 : (scopes.led.index == 3) ? 43 : (scopes.led.index == 2) ? 32 : (scopes.led.index == 1) ? 19 : (scopes.led.index == 0) ? 30 : 18),
                           left: ((scopes.digit.index == 7) ? -114 : (scopes.digit.index == 6) ? -89 : (scopes.digit.index == 5) ? -64 : (scopes.digit.index == 4) ? -39 : (scopes.digit.index == 3) ? -4 : (scopes.digit.index == 2) ? 21 : (scopes.digit.index == 1) ? 46 : 71) + ((scopes.led.index == 5) ? 10 : (scopes.led.index == 4) ? 8 : (scopes.led.index == 3) ? -4 : (scopes.led.index == 2) ? -8 : (scopes.led.index == 1) ? -6 : (scopes.led.index == 0) ? -2 : -1),
                           width: ((this.getIndex() == 6) || (this.getIndex() == 3) || (this.getIndex() == 0)) ? 12 : 3,
                           height: ((this.getIndex() == 5) || (this.getIndex() == 4) || (this.getIndex() == 2) || (this.getIndex() == 1)) ? 11 : 3,
                           fill: "grey",
                           skewX: ((this.getIndex() == 5) || (this.getIndex() == 4) || (this.getIndex() == 2) || (this.getIndex() == 1)) ? -9 : 0,
                           opacity: 1
                        })
                     return{objects : {sseg}};
                  },
                  renderEach() {
                     var enable = ('/top|_pipe$_digit'.asBinaryStr().split("").reverse().join(""));
                     this.getInitObject("sseg").bringToFront()
                     var fp_valid = '/top|_pipe$_dp'.asBool() == 0
                     if(scopes.led.index == 7)
                     {
                        this.getInitObject("sseg").set(enable[scopes.digit.index] == 0 && fp_valid ? {fill: "red"} : {fill: "grey"})
                     }
                     else {
                        var hamm = ((('/top|_pipe$_sseg'.asInt(-1) >> scopes.led.index) & 1) == 0);
                        this.getInitObject("sseg").set(hamm && enable[scopes.digit.index] == 0 ? {fill: "red"} : {fill: "grey"});
                     }
                  }
         '])
         '])
         '])
         '])
         '])
         
\TLV switch(|_pipe, @_stage, $_sw)
   |_pipe
      @_stage
         m4_ifelse_block(M4_MAKERCHIP, 1, ['
         m4_ifelse_block(M4_BOARD, 1,['
         /led[7:0]
            \viz_alpha
               initEach() {
                    //215
                    //172
                  let sw_1 = new fabric.Rect({
                        top: 260,
                        left: 145 - 32 * (this.getIndex() + 1),
                        width: 22, 
                        height: 50, 
                        fill: "#7F8B52",
                        rx:2,
                        ry:2,
                        opacity: 1
                     })
                  let sw_2 = new fabric.Rect({
                        top: 270,
                        left: 150 - 32 * (this.getIndex() + 1),
                        width: 12, 
                        height: 30, 
                        fill: "#EEEEEE",
                        rx:2,
                        ry:2,
                        opacity: 1
                     })
                    //182 for top
                    //197 for off
                   let sw = new fabric.Rect({
                        top: 285,
                        left: 148 - 32 * (this.getIndex() + 1),
                        width: 17, 
                        height: 15, 
                        fill: "#423F3E",
                        rx:2,
                        ry:2,
                        opacity: 1
                     })
                  /*let done_led = new fabric.Rect({
                        top: -108,
                        left: 191, 
                        width: 5, 
                        height: 8, 
                        fill: "green",
                        opacity: 1
                     }) */
                  return{objects : {sw_1, sw_2, sw/*, done_led*/}}; 
               },
               renderEach(){
                  var mod = ((('/top|_pipe$_sw'.asInt(-1) >> this.getScope("led").index) & 1) == 1);
                  this.getInitObject("sw").set(mod ? {top: 270} : {top: 285});
               }
         '],['
         m4_ifelse_block(M4_BOARD, 2,['
         /led[15:0]
            \viz_alpha
               initEach() {
                    
                  let sw_1 = new fabric.Rect({
                        top: 172,
                        left: 215 - 28 * (this.getIndex() + 1),
                        width: 22, 
                        height: 50, 
                        fill: "#7F8B52",
                        rx:2,
                        ry:2,
                        opacity: 1
                     })
                  let sw_2 = new fabric.Rect({
                        top: 182,
                        left: 220 - 28 * (this.getIndex() + 1),
                        width: 12, 
                        height: 30, 
                        fill: "#EEEEEE",
                        rx:2,
                        ry:2,
                        opacity: 1
                     })
                    //182 for top
                    //197 for off
                   let sw = new fabric.Rect({
                        top: 197,
                        left: 218 - 28 * (this.getIndex() + 1),
                        width: 17, 
                        height: 15, 
                        fill: "#423F3E",
                        rx:2,
                        ry:2,
                        opacity: 1
                     })
                  /*let done_led = new fabric.Rect({
                        top: -108,
                        left: 191, 
                        width: 5, 
                        height: 8, 
                        fill: "green",
                        opacity: 1
                     }) */
                  return{objects : {sw_1, sw_2, sw/*, done_led*/}}; 
               },
               renderEach(){
                  var mod = ((('/top|_pipe$_sw'.asInt(-1) >> this.getScope("led").index) & 1) == 1);
                  this.getInitObject("sw").set(mod ? {top: 182} : {top: 197});
               }
         '],['
         m4_ifelse_block(M4_BOARD, 3,['
         /led[15:0]
            \viz_alpha
               initEach() {
                     //172
                  let sw_1 = new fabric.Rect({
                        top: 120,
                        left: 200 - 25.8 * (this.getIndex() + 1),
                        width: 22, 
                        height: 37, 
                        fill: "#7F8B52",
                        rx:2,
                        ry:2,
                        opacity: 1
                     })
                  let sw_2 = new fabric.Rect({
                        top: 125,
                        left: 205 - 25.8 * (this.getIndex() + 1),
                        width: 12, 
                        height: 26, 
                        fill: "#EEEEEE",
                        rx:2,
                        ry:2,
                        opacity: 1
                     })
                    //182 for top
                    //197 for off
                   let sw = new fabric.Rect({
                        top: 140,
                        left: 203 - 25.8 * (this.getIndex() + 1),
                        width: 17, 
                        height: 15, 
                        fill: "#423F3E",
                        rx:2,
                        ry:2,
                        opacity: 1
                     })
                  /*let done_led = new fabric.Rect({
                        top: -108,
                        left: 191, 
                        width: 5, 
                        height: 8, 
                        fill: "green",
                        opacity: 1
                     }) */
                  return{objects : {sw_1, sw_2, sw/*, done_led*/}}; 
               },
               renderEach(){
                  var mod = ((('/top|_pipe$_sw'.asInt(-1) >> this.getScope("led").index) & 1) == 1);
                  this.getInitObject("sw").set(mod ? {top: 125} : {top: 140});
               }
         '],['
         m4_ifelse_block(M4_BOARD, 4,['
         '],['
         m4_ifelse_block(M4_BOARD, 5,['
         /led[15:0]
            \viz_alpha
               initEach() {
                     //15
                  let sw_1 = new fabric.Rect({
                        top: 150,
                        left: 185 - 22 * (this.getIndex() + 1),
                        width: 22, 
                        height: 37, 
                        fill: "#7F8B52",
                        rx:2,
                        ry:2,
                        opacity: 1
                     })
                  let sw_2 = new fabric.Rect({
                        top: 155,
                        left: 190 - 22 * (this.getIndex() + 1),
                        width: 12, 
                        height: 26, 
                        fill: "#EEEEEE",
                        rx:2,
                        ry:2,
                        opacity: 1
                     })
                    //182 for top
                    //197 for off
                   let sw = new fabric.Rect({
                        top: 170,
                        left: 188 - 22 * (this.getIndex() + 1),
                        width: 17, 
                        height: 15, 
                        fill: "#423F3E",
                        rx:2,
                        ry:2,
                        opacity: 1
                     })
                  /*let done_led = new fabric.Rect({
                        top: -108,
                        left: 191, 
                        width: 5, 
                        height: 8, 
                        fill: "green",
                        opacity: 1
                     }) */
                  return{objects : {sw_1, sw_2, sw/*, done_led*/}}; 
               },
               renderEach(){
                  var mod = ((('/top|_pipe$_sw'.asInt(-1) >> this.getScope("led").index) & 1) == 1);
                  this.getInitObject("sw").set(mod ? {top: 155} : {top: 170});
               }
         '])
         '])
         '])
         '])
         '])
         '])
\TLV push(|_pipe, @_stage, $_pb)
   |_pipe
      @_stage
         m4_ifelse_block(M4_MAKERCHIP, 1, ['
         m4_ifelse_block(M4_BOARD, 1,['
         /pb[4:0]
            \viz_alpha
               initEach(){
                  let push = new fabric.Circle({
                           originX: "center",
                           originY: "center",
                           top: scopes.pb.index == 0 ? 218 : scopes.pb.index == 1 ? 292 : 254,
                           left: scopes.pb.index == 2 ? 211 : scopes.pb.index == 3 ? 307 : 259,
                           radius: 10,
                           opacity: 1,
                           fill: "red"
                        }) 
                  return {objects:{push}}
               },
               renderEach(){
                  var mod = ((('/top|_pipe$_pb'.asInt(-1) >> this.getScope("pb").index) & 1) == 1);
                  if(mod){
                     this.getInitObjects().push.set({fill: "red"})
                  }else{
                     this.getInitObjects().push.set({fill: "black"})
                  }
               }
         '],['
         m4_ifelse_block(M4_BOARD, 2,['
         /pb[4:0]
            \viz_alpha
               initEach(){
                  let push = new fabric.Circle({
                           originX: "center",
                           originY: "center",
                           top: scopes.pb.index == 0 ? 40 : scopes.pb.index == 1 ? 121 : 79,
                           left: scopes.pb.index == 2 ? 113 : scopes.pb.index == 3 ? 203 : 155,
                           radius: 10,
                           opacity: 1,
                           fill: "red"
                        }) 
                  return {objects:{push}}
               },
               renderEach(){
                  var mod = ((('/top|_pipe$_pb'.asInt(-1) >> this.getScope("pb").index) & 1) == 1);
                  if(mod){
                     this.getInitObjects().push.set({fill: "red"})
                  }else{
                     this.getInitObjects().push.set({fill: "black"})
                  }
               }
         '],['
         m4_ifelse_block(M4_BOARD, 3,['
         /pb[4:0]
            \viz_alpha
               initEach(){
                  let push = new fabric.Circle({
                           originX: "center",
                           originY: "center",
                           top: scopes.pb.index == 0 ? 27 : scopes.pb.index == 1 ? 81 : 54,
                           left: scopes.pb.index == 2 ? 65 : scopes.pb.index == 3 ? 130 : 98,
                           radius: 7,
                           opacity: 1,
                           fill: "red"
                        }) 
                  return {objects:{push}}
               },
               renderEach(){
                  var mod = ((('/top|_pipe$_pb'.asInt(-1) >> this.getScope("pb").index) & 1) == 1);
                  if(mod){
                     this.getInitObjects().push.set({fill: "red"})
                  }else{
                     this.getInitObjects().push.set({fill: "black"})
                  }
               }
         '],['
         m4_ifelse_block(M4_BOARD, 4,['
         /pb[2:0]
            \viz_alpha
               initEach(){
                  let push = new fabric.Circle({
                           originX: "center",
                           originY: "center",
                           top: 240,
                           left: scopes.pb.index == 2 ? -175 : scopes.pb.index == 1 ? -128 : -80,
                           radius: 10,
                           opacity: 1,
                           fill: "red"
                        }) 
                  return {objects:{push}}
               },
               renderEach(){
                  var mod = ((('/top|_pipe$_pb'.asInt(-1) >> this.getScope("pb").index) & 1) == 1);
                  if(mod){
                     this.getInitObjects().push.set({fill: "red"})
                  }else{
                     this.getInitObjects().push.set({fill: "black"})
                  }
               }
         '],['
         m4_ifelse_block(M4_BOARD, 5,['
         /pb[4:0]
            \viz_alpha
               initEach(){
                  let push = new fabric.Circle({
                           originX: "center",
                           originY: "center",
                           top: scopes.pb.index == 0 ? 24 : scopes.pb.index == 1 ? 84 : 54,
                           left: scopes.pb.index == 2 ? 89 : scopes.pb.index == 3 ? 150 : 120,
                           radius: 5,
                           opacity: 1,
                           fill: "red"
                        }) 
                  return {objects:{push}}
               },
               renderEach(){
                  var mod = ((('/top|_pipe$_pb'.asInt(-1) >> this.getScope("pb").index) & 1) == 1);
                  if(mod){
                     this.getInitObjects().push.set({fill: "red"})
                  }else{
                     this.getInitObjects().push.set({fill: "black"})
                  }
               }
         '])
         '])
         '])
         '])
         '])
         '])
         '])
