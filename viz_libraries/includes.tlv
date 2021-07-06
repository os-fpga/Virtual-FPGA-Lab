\m4_TLV_version 1d: tl-x.org


\TLV zedboard_init(|_pipe, @_stage)
   |_pipe
      @_stage
         m4_ifelse_block(M4_MAKERCHIP, 1, ['
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
                  let fpga_img_url = "https://github.com/BalaDhinesh/Virtual-FPGA-Lab/blob/main/images/Zedboard.png?raw=true"
                  let fpga_img = new fabric.Image.fromURL(
                        fpga_img_url,
                        function (img) {
                           logic_block.add(img)
                           global.canvas.renderAll()
                           global.canvas.sendToBack(logic_block);
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
                   let start_led = new fabric.Rect({
                        top: 200,
                        left: -195,
                        width: 5,
                        height: 8,
                        fill: "red",
                        opacity: 1
                     })
                return {objects :{logic_block}};
                }
         '],
         ['
         ']
         )
         
\TLV zedboard_led(|_pipe, @_stage, $leds)
   |_pipe
      @_stage
         m4_ifelse_block(M4_MAKERCHIP, 1, ['
         //$viz_leds[15:0] = {$L1,$P1,$N3,$P3,$U3,$W3,$V3,$V13,$V14,$U14,$U15,$W18,$V19,$U19,$E19,$U16};
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
                     console.log('/top|_pipe$leds'.asInt(-1))
                     this.getInitObject("led").set(mod ? {opacity: 1} : {opacity: 0});
                  }   
         '],
         ['
         ']
         )
