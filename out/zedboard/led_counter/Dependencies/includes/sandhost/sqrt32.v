// A non-synthesizable Verilog-2005 sqrt function for tutorials.
`ifndef RW_NON_SYNTH_SQRT
`define RW_NON_SYNTH_SQRT

function [31:0] sqrt;
   input [31:0] a;
   
   /* verilator lint_off REALCVT */
   sqrt = $sqrt(a);
   /* verilator lint_on REALCVT */
endfunction

`endif
