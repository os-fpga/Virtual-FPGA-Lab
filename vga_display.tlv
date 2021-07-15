\m4_TLV_version 1d -p verilog --bestsv --noline: tl-x.org

\SV
   //m4_include_lib(['https://raw.githubusercontent.com/BalaDhinesh/Virtual-FPGA-Lab/main/viz_libraries/includes.tlv'])
                   
\SV
   m4_ifelse_block(M4_MAKERCHIP, 1,['
   m4_makerchip_module   
   m4_define(M4_COUNTER, 32)
   m4_define(M4_FRAMES, 2)
   m4_define(M4_MAX_H, 640 / M4_COUNTER)
   m4_define(M4_MAX_V, 480 / M4_COUNTER)
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
      
\TLV display_timings_480p(|_pipe, @_stage, $_reset, $sx, $sy, $hsync, $vsync, $de, M4_COUNTER)
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
         
         $hsync = ~($sx >= M4_HS_STA && $sx < M4_HS_END);
         $vsync = ~($sy >= M4_VS_STA && $sy < M4_VS_END);
         $de = ($sx < M4_HA_END && $sy < M4_VA_END);
         
         $sx[9:0] = $_reset ? 10'b1111111111 : >>1$sx >= M4_LINE ? 0 : >>1$sx + M4_COUNTER;
         $sy[9:0] = $_reset ? 10'b1111111111 : (>>1$sx >= M4_LINE ? (>>1$sy >= M4_SCREEN ? 0 : >>1$sy + M4_COUNTER) : $RETAIN);
         
\TLV
   m4+display_timings_480p(|vga_module, @0, $reset, $sx, $sy, $hsync, $vsync, $de, M4_COUNTER)
   |vga_module
      @0
         $reset = *reset;  
         $ii[2:0] = $reset ? 0 : $vert_counter == 0 && !>>1$vert_counter == 0 ? >>1$ii + 1 : $RETAIN;
         $q_draw = $ii == 1 ? ($sx < 64 && $sy < 64) : $ii == 2 ? ($sx < 128 && $sy < 128) : 0;
         $vga_hsync = $reset ? 0 : >>1$hsync;
         $vga_vsync = $reset ? 0 : >>1$vsync;
         $vga_r[3:0] = $reset ? 0 : !$de ? 4'h0 : ($q_draw ? 4'hF : 4'h0);
         $vga_g[3:0] = $reset ? 0 : !$de ? 4'h0 : ($q_draw ? 4'h8 : 4'h8);
         $vga_b[3:0] = $reset ? 0 : !$de ? 4'h0 : ($q_draw ? 4'h0 : 4'hF);
         m4_ifelse_block(M4_MAKERCHIP, 1,['
         $hori_counter[9:0] = $reset ? 10'b1111111111 : >>1$sx >= M4_LINE ? 0 : >>1$hori_counter + 1;
         $vert_counter[9:0] = $reset ? 10'b1111111111 : $sy == 0 ? 0 : >>1$sx >=  M4_LINE ? >>1$vert_counter + 1 : $RETAIN;
         $width[9:0] = (800 % M4_COUNTER) > 0 ? 800 / M4_COUNTER + 2 : 800 / M4_COUNTER + 1;
         $height[9:0] = (525 % M4_COUNTER) > 0 ? 525 / M4_COUNTER + 2 : 525 / M4_COUNTER + 1;
         $tot_cyc[19:0] = $width * $height;
         *passed = !clk || *cyc_cnt > ($tot_cyc * M4_FRAMES) - 1;
         *failed = !clk || 1'b0;
         \viz_alpha
            initEach(){
               let frame = new fabric.Text("", {
                 left: -330,
                 top: -300,
                 fontSize: 20,
                 fontFamily: "Courier New",
               })
               let hsync = new fabric.Text("hsync:", {
                 left: -200,
                 top: -300,
                 fontSize: 20,
                 fontFamily: "Courier New",
               })
               let vsync = new fabric.Text("vsync:", {
                 left: -80,
                 top: -300,
                 fontSize: 20,
                 fontFamily: "Courier New",
               })
               let row_pointer = new fabric.Text("->", {
                     top: - 120,
                     left: -170,
                     fill: "black",
                     fontSize: 14,
                     fontFamily: "monospace"
                  })
               let column_pointer = new fabric.Text("->", {
                     top: - 140,
                     left: -130,
                     fill: "black",
                     angle: 90,
                     fontSize: 14,
                     fontFamily: "monospace"
                  })
               return {objects: {frame, hsync, vsync, row_pointer, column_pointer}}
            },
            renderEach(){
               let hori_cnt_now = '/top|vga_module$hori_counter'.asInt()
               let vert_cnt_now = '/top|vga_module$vert_counter'.asInt()
               let vga_hsync = '/top|vga_module$vga_hsync'.asInt()
               let vga_vsync = '/top|vga_module$vga_vsync'.asInt()
               let width = '/top|vga_module$width'.asInt()
               let height = '/top|vga_module$height'.asInt()
               let cycle = '/top|vga_module$hori_counter'.getCycle()
               let count = '/top|vga_module$tot_cyc'.asInt()
               let frame = parseInt(cycle / count)
               console.log(hori_cnt_now)
               this.getInitObjects().frame.setText("Frame: " + (frame + 1))
               this.getInitObjects().hsync.setText("hsync: " + vga_hsync)
               this.getInitObjects().vsync.setText("vsync: " + vga_vsync)
               if (vert_cnt_now < M4_MAX_V){
               this.getInitObjects().row_pointer.set({top:-120 + (20 * vert_cnt_now), opacity : 1})
               }else{
               this.getInitObjects().column_pointer.set({opacity : 0})
               }
               if (hori_cnt_now < M4_MAX_H){
               this.getInitObjects().column_pointer.set({left:-130 + (20 * hori_cnt_now), opacity: 1})
               }else{
               this.getInitObjects().column_pointer.set({opacity : 0})
               }
               for(j=0; j<M4_MAX_H; j++){
                   for(k=0; k<M4_MAX_V; k++){
                      let grid = new fabric.Rect({
                      top: (20 * k) - 120,
                      left: (20 * j)  - 150,
                      width: 20,
                      height: 20,
                      fill:"black"
                   })
                   i = k * width + j
                   if(frame){
                     let red = '/top|vga_module$vga_r'.goTo(((frame-1) * count)+i).asBinaryStr()
                     red = red.concat(red)
                     red = parseInt(red, 2);
                     let green = '/top|vga_module$vga_g'.goTo(((frame-1) * count)+i).asBinaryStr()
                     green = green.concat(green)
                     green = parseInt(green, 2);
                     let blue = '/top|vga_module$vga_b'.goTo(((frame-1) * count)+i).asBinaryStr()
                     blue = blue.concat(blue)
                     blue = parseInt(blue, 2);
                     let color = "rgb(" + red + "," + green + "," + blue + ")"
                     grid.set({fill:color, stroke:color, strokeWidth:1})
                   }
                     let red = '/top|vga_module$vga_r'.goTo(((frame) * count) + i).asBinaryStr()
                     red = red.concat(red)
                     red = parseInt(red, 2);
                     let green = '/top|vga_module$vga_g'.goTo(((frame) * count) + i).asBinaryStr()
                     green = green.concat(green)
                     green = parseInt(green, 2);
                     let blue = '/top|vga_module$vga_b'.goTo(((frame) * count) + i).asBinaryStr()
                     blue = blue.concat(blue)
                     blue = parseInt(blue, 2);
                     color = "rgb(" + red + "," + green + "," + blue + ")"
                   if(k<vert_cnt_now){
                     grid.set({fill:color, stroke:color, strokeWidth:1})
                   }else if(k==vert_cnt_now){
                      if(j<=hori_cnt_now){
                         grid.set({fill:color, stroke:color, strokeWidth:1})
                      }
                   }
                   global.canvas.add(grid)
                   }
                }
            }
         '],['
         *vga_hsync = $vga_hsync;
         *vga_vsync = $vga_vsync;
         *vga_r = $vga_r;
         *vga_g = $vga_g;
         *vga_b = $vga_b;
         ']
         )
         
\SV
   endmodule


