\m4_TLV_version 1d -p verilog --bestsv --noline: tl-x.org
\SV
   
   m4_include_lib(['https://raw.githubusercontent.com/BalaDhinesh/Virtual-FPGA-Lab/main/viz_libraries/includes1.tlv'])                   
\SV
   m4_ifelse_block(M4_MAKERCHIP, 1,['
   m4_makerchip_module   
   '],['
   module top(
    input clk, 
    output [4:0] led_r, 
    output [4:0] led_g,
    output [4:0] led_b
	);
   ']) 
\TLV rgb_pwm(|_pipe, @_stage, $led_r, $led_g, $led_b, #dutyr, #dutyg, #dutyb, #led_no)
   |_pipe
      @_stage
         m4_ifelse_block(M4_MAKERCHIP, 1,[' 
         '],['
         $rst = *reset;
         $cnt[7:0] = $rst ? 0 : >>1$cnt + 1;
         $led_r = ($cnt < #dutyr);
         $led_g = ($cnt < #dutyg);
         $led_b = ($cnt < #dutyb);
         ']) 
         \viz_alpha
            initEach() {
               let led = new fabric.Rect({
                     top: (#led_no == 1) ? 166 : (#led_no == 2) ? 208 : 188,
                     left: (#led_no == 3) ? -112 : (#led_no == 4) ?  -153 : -132,
                     width: 8, 
                     height: 7, 
                     fill: "transparent",
                     opacity: 1
                  })
               return{objects : {led}}; 
            }, 
            renderEach() {
                  let r = #dutyr
                  let g = #dutyg
                  let b = #dutyb
                  let value = "rgb(" + r + "," + g + "," + b + ")"
                  this.getInitObjects().led.set({fill: value})
               } 
\TLV
   /top 
      m4+rgb_pwm(|led0, @0, $ledr0, $ledg0, $ledb0, 10, 255, 255, 0)
      m4+rgb_pwm(|led1, @0, $ledr1, $ledg1, $ledb1, 10, 1, 1, 1)
      m4+rgb_pwm(|led2, @0, $ledr2, $ledg2, $ledb2, 10, 255, 255, 2)
      m4+rgb_pwm(|led3, @0, $ledr3, $ledg3, $ledb3, 10, 255, 255, 3)
      m4+rgb_pwm(|led4, @0, $ledr4, $ledg4, $ledb4, 10, 255, 255, 4)
      |led_rgb_pipe
         @0
            $led_r[4:0] = {/top|led4$ledr4, /top|led3$ledr3, /top|led2$ledr2, /top|led1$ledr1, /top|led0$ledr0};
            $led_g[4:0] = {/top|led4$ledg4, /top|led3$ledg3, /top|led2$ledg2, /top|led1$ledg1, /top|led0$ledg0};
            $led_b[4:0] = {/top|led4$ledb4, /top|led3$ledb3, /top|led2$ledb2, /top|led1$ledb1, /top|led0$ledb0};
            m4_ifelse_block(M4_MAKERCHIP, 1,['
            '],['
            *led_r = $led_r;
            *led_g = $led_g;
            *led_b = $led_b;
            ']) 
      m4_define(M4_BOARD, 4)
      m4+init(|top_pipe, @0)   
\SV
   endmodule

