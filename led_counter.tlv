\m4_TLV_version 1d -p verilog --bestsv --noline: tl-x.org

\SV
   m4_include_lib(['https://raw.githubusercontent.com/BalaDhinesh/Virtual-FPGA-Lab/main/viz_libraries/artix7_board.tlv'])
                   
\SV
   m4_ifelse_block(M4_MAKERCHIP, 1,['
   m4_makerchip_module   
   '],['
   module top(input clk, input reset, output [15:0] led);
      clock_divider dut1 (clk, divided_clk);
      test #(div_value = 24999999) dut2 (divided_clk, reset, led);
   endmodule
   module test (input clk, input reset, output [15:0] led);
   ']
   )

                  

\TLV
   m4_ifelse_block(M4_MAKERCHIP, 1,['
   $reset = *reset;
   *passed = *cyc_cnt > 400;
   *failed = 1'b0;   
   '],['
   ']
   )
   |led_pipe
      @0      
         $reset = *reset;
         $leds[15:0] = $reset ? 0 : >>1$leds+1;
         m4_ifelse_block(M4_MAKERCHIP, 1, ['
         '],
         ['
         *led = $leds;
         ']
         )
         
   m4+artix7_init(|top_pipe, @0)
   m4+artix7_led(|led_pipe, @0, $leds)
\SV
   endmodule
