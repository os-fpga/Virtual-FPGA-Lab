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
                  let fpga_img_url = "https://github.com/BalaDhinesh/Shaastra-FPGA-Workshop/blob/main/IMG_20210618_145611-removebg.png?raw=true"
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
