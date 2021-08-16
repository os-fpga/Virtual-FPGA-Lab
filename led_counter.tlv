\m4_TLV_version 1d -p verilog --bestsv --noline: tl-x.org
\SV
   m4_include_lib(['https://raw.githubusercontent.com/BalaDhinesh/Virtual-FPGA-Lab/main/viz_libraries/includes1.tlv'])                   
   
\SV
   m4_ifelse_block(M4_MAKERCHIP, 1,['
   m4_makerchip_module   
   '],['
   module top(input clk, input reset, output [15:0] led);
   '])    
\TLV counter($_var, #_delay)
   m4_ifelse_block(M4_MAKERCHIP, 1, ['
   $_var = 1;
   '], ['
   $rst = *reset;
   $count[\$clog2(#_delay)-1:0] = $rst ? 1'b0 : ($RETAIN >= #_delay) ? 1'b0 : >>1$count + 1 ; 
   $counter = ($count == #_delay) ? 1'b1 : 1'b0 ;
   $_var = $counter;
   '])     
\TLV
      
   |led_pipe
      @0  
         m4+counter($refresh, 100000000 - 1) 
         $reset = *reset;
         ?$refresh
            $Leds[15:0] <= $reset ? 1 : $Leds+1;
         m4_ifelse_block(M4_MAKERCHIP, 1, [''],['
         *led = $Leds;
         '])
   
   
   
   m4_ifelse_block(M4_MAKERCHIP, 1, ['
   m4_define(M4_BOARD, 1)
   m4+init(|top_pipe, @0)
   m4+led(|led_pipe, @0, $Leds)
   *passed = *cyc_cnt > 400;
   *failed = 1'b0;   
   '])
\SV
   endmodule