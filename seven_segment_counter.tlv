\m4_TLV_version 1d -p verilog --bestsv --noline: tl-x.org

\SV
   m4_include_lib(['https://raw.githubusercontent.com/BalaDhinesh/Virtual-FPGA-Lab/main/viz_libraries/artix7_board.tlv'])
                   
\SV
   m4_ifelse_block(M4_MAKERCHIP, 1,['
   m4_makerchip_module   
   '],['
   module top(input clk, input reset, output [3:0] digit, output [7:0] sseg);
      clock_divider #(.DIV_VALUE(24999999)) dut1 (clk, divided_clk);
      test dut2 (divided_clk, reset, digit, sseg);
   endmodule
   module test (input clk, input reset, output [3:0] digit, output [7:0] sseg);
   ']
   )

\TLV
   
   |sseg_pipe
      @0   
         $reset = *reset;
         $digit[3:0] = $reset ? 0 : >>1$digit-1;
         $sseg[7:0] = 8'b00000001;
         m4_ifelse_block(M4_MAKERCHIP, 1,['
         $reset = *reset;
         *passed = *cyc_cnt > 400;
         *failed = 1'b0;   
         '],['
         *digit = $digit;
         *sseg = $sseg;
         ']
         )
   m4_ifelse_block(M4_MAKERCHIP, 1,['      
   m4+artix7_init(|top_pipe, @0)
   m4+artix7_sseg(|sseg_pipe, @0, $digit, $sseg)
   '],['
   ']
   )
\SV
   endmodule
