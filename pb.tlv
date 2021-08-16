\m4_TLV_version 1d -p verilog --bestsv --noline: tl-x.org
\SV
   m4_include_lib(['https://raw.githubusercontent.com/BalaDhinesh/Virtual-FPGA-Lab/main/viz_libraries/includes1.tlv'])                   
\SV
   m4_ifelse_block(M4_MAKERCHIP, 1,['
   m4_makerchip_module   
   '],['
   module top(input clk, input reset, input [4:0] pb, output [4:0] led);
   ']
   )  
\TLV
   |push_pipe
      @0
         $reset = *reset;
         
         // Only for slideswitch VIZ
         m4_ifelse_block(M4_MAKERCHIP, 1, ['
         $pb[4:0] = 5'b11111;
         '],['
         $pb[4:0] = *pb;
         '])
         
   |led_pipe
      @0
         $reset = *reset;
         $leds[4:0] = /top|push_pipe$pb;
         m4_ifelse_block(M4_MAKERCHIP, 1, [''],['
         *led = $leds;
         '])
         
      
   m4_define(M4_BOARD, 5)
   m4+init(|top_pipe, @0)
   m4+led(|led_pipe, @0, $leds)
   m4+push(|push_pipe, @0, $pb)
   
   m4_ifelse_block(M4_MAKERCHIP, 1, ['
   *passed = *cyc_cnt > 400;
   *failed = 1'b0;   
   '])
   
\SV
   endmodule
