\m5_TLV_version 1d -p verilog --noline: tl-x.org
\m5
   /**
   This template enables Tiny Tapeout modules to run in the Virtual FPGA Lab.
   It is specifically for Tiny Tapeout designs only.
   A different template should be used to develop Virtual FPGA Lab modules that are
   compatible with Tiny Tapeout (and all other boards supported by the Virtual FPGA Lab boards).
   **/
   use(m5-1.0)
\SV
   m4_include_lib(['https://raw.githubusercontent.com/os-fpga/Virtual-FPGA-Lab/tt/tlv_lib/fpga_includes.tlv'])
   m4_include_lib(['https://raw.githubusercontent.com/stevehoover/RISC-V_MYTH_Workshop/master/tlv_lib/calculator_shell_lib.tlv'])

// Example using LEDs to display a binary counter.
\TLV fpga_calculator(/_fpga)
   |calc
      @0
         // Run artificially slow in the real FPGA. 
         m5+fpga_heartbeat($refresh, 1, 50000000)
         $reset = *reset;
      @1
         $val1[31:0] = >>2$out;
         $val2[31:0] = $rand2[3:0];
         $valid = $reset ? 1'b0 : >>1$valid + 1'b1;
         $reset_or_valid = $valid || $reset;
      ?$reset_or_valid
         @1
            $sum[31:0] = $val1 + $val2;
            $diff[31:0] = $val1 - $val2;
            $prod[31:0] = $val1 * $val2;
            $quot[31:0] = $val1 / $val2;
         @2
            $mem[31:0] = $reset           ? 32'b0 :
                            ($op[2:0] == 3'b101) ? $val1 :
                                               >>2$mem;
            $out[31:0] = $reset           ? 32'b0 :
                         ($op == 3'b000) ? $sum  :
                         ($op == 3'b001) ? $diff :
                         ($op == 3'b010) ? $prod :
                         ($op == 3'b011) ? $quot :
                         ($op == 3'b100) ? >>2$mem : >>2$out;
      @2
         m5+sseg_decoder(*uo_out, $out[3:0])
         *uo_out[7] = 1'b1;  // No decimal point.
   \SV_plus
      m5_if_var_def(MAKERCHIP, ['logic [256:0] RW_rand_vect = top.RW_rand_vect;'])
      m5_if_var_def(MAKERCHIP, ['logic [31:0] cyc_cnt = top.cyc_cnt;'])
   m4+cal_viz(@2, /_fpga)

\SV_plus

`default_nettype none

// A simple Makerchip Verilog test bench driving random stimulus.
m4_makerchip_module
   logic [7:0] ui_in, uio_in, uo_out, uio_out, uio_oe;
   assign m4_rand(ui_in, 7, 0)
   assign m4_rand(uio_in, 7, 0)
   logic ena = 1'b0;
   logic rst_n = ! reset;
                   
   // Instantiate the Tiny Tapeout module.
   tt_um_template tt(.*);
   
endmodule

module tt_um_template (
    input  wire [7:0] ui_in,    // Dedicated inputs - connected to the input switches
    output wire [7:0] uo_out,   // Dedicated outputs - connected to the 7 segment display
    input  wire [7:0] uio_in,   // IOs: Bidirectional Input path
    output wire [7:0] uio_out,  // IOs: Bidirectional Output path
    output wire [7:0] uio_oe,   // IOs: Bidirectional Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // will go high when the design is enabled
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);

   wire reset = ! rst_n;
\TLV
   // Connect Tiny Tapeout I/Os to Virtual FPGA Lab.
   m5+tt_connections()
   m5+board(/top, /fpga, 7, $, , fpga_calculator)   // 3rd arg selects the board.

\SV
   endmodule