\m4_TLV_version 1d -p verilog --bestsv --noline: tl-x.org
\SV
   m4_include_lib(['https://raw.githubusercontent.com/BalaDhinesh/Virtual-FPGA-Lab/main/tlv_lib/fpga_includes.tlv'])                   
\SV
   m4_ifelse_block(M4_MAKERCHIP, 1,['
   m4_makerchip_module   
   '],['
   module top(input clk, input reset, input [4:0] pb, output [4:0] led);
   ']
   )  
      logic [4:0] pb;
      logic [4:0] led;
\TLV
   |push_pipe
      @0
         $reset = *reset;
         
         // Only for slideswitch VIZ
         m4_ifelse_block(M4_MAKERCHIP, 1, ['
         // Since pushbutton is an input to the board, 
         // inorder to use in Makerchip visualization, 
         // we manually assign its values
         $pb[4:0] = $reset ? 0 : $RETAIN + 1;
         *pb = $pb;
         '],['
         $pb[4:0] = *pb;
         '])
   |led_pipe
      @0
         $reset = *reset;
         $leds[4:0] = /top|push_pipe$pb;
         *led = $leds;
   // M4_BOARD numbering
   // 1 - Zedboard
   // 2 - Artix-7
   // 3 - Basys3
   // 4 - Icebreaker
   // 5 - Nexys
   m4_define(M4_BOARD, 5)
   m4+fpga_init()
   m4+fpga_led(*led)
   m4+fpga_push(*pb)  
\SV
   endmodule