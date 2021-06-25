\m4_TLV_version 1d: tl-x.org
\TLV basys3_init(|_pipe, @_stage)
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
                  let fpga_img_url = "https://github.com/BalaDhinesh/Virtual-FPGA-Lab/blob/main/images/basys3.png?raw=true"
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
                         scaleX: 0.09,
                         scaleY: 0.09,
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
                           top: 50,
                           left: -182,
                           width: 124, 
                           height: 39, 
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
         
\TLV basys3_led(|_pipe, @_stage, $leds)
   |_pipe
      @_stage
         //$viz_leds[15:0] = {$L1,$P1,$N3,$P3,$U3,$W3,$V3,$V13,$V14,$U14,$U15,$W18,$V19,$U19,$E19,$U16};
         /led[15:0]
            \viz_alpha
               initEach() {
               debugger
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
                     var mod = ((('/top|_pipe$leds'.asInt(-1) >> this.getScope("led").index) & 1) == 1);
                     this.getInitObject("led").set(mod ? {opacity: 1} : {opacity: 0});
                  }  
\TLV basys3_sseg(|_pipe, @_stage, $enable, $sseg)
   |_pipe
      @_stage
         /sseg
            \viz_alpha
               initEach() {
                           let seg = new fabric.Rect({
                           top: 50,
                           left: -182,
                           width: 124, 
                           height: 39, 
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
