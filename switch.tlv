\m4_TLV_version 1d -p verilog --bestsv --noline: tl-x.org
\SV
   m4_include_lib(['https://raw.githubusercontent.com/BalaDhinesh/Virtual-FPGA-Lab/main/viz_libraries/includes1.tlv'])                   
\SV
   m4_ifelse_block(M4_MAKERCHIP, 1,['
   m4_makerchip_module   
   '],['
   module top(input clk, input reset, input [15:0] sw, output [15:0] led);
   ']
   )  
\TLV
   |switch_pipe
      @0
         $reset = *reset;
         
         // Only for slideswitch VIZ
         m4_ifelse_block(M4_MAKERCHIP, 1, ['
         $sw[15:0] = $reset ? 0 : >>1$sw + 1;
         '],['
         $sw[15:0] = *sw;
         '])
         
   |led_pipe
      @0
         $reset = *reset;
         $leds[15:0] = /top|switch_pipe$sw;
         m4_ifelse_block(M4_MAKERCHIP, 1, [''],['
         *led = $leds;
         '])
   
   m4_define(M4_BOARD, 2)
   m4+init(|top_pipe, @0)
   m4+led(|led_pipe, @0, $leds)
   m4+switch(|switch_pipe, @0, $sw)
   
   m4_ifelse_block(M4_MAKERCHIP, 1, ['
   *passed = *cyc_cnt > 400;
   *failed = 1'b0;   
   '])
   
   
\SV
   endmodule
