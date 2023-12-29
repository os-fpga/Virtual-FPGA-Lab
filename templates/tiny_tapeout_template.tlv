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
   m4_include_lib(['https://raw.githubusercontent.com/os-fpga/Virtual-FPGA-Lab/7335edd12fe1b39521e855e526cc337b853e035f/tlv_lib/fpga_includes.tlv'])

`default_nettype none

\SV_plus
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

\SV
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
   // Instantiate the Virtual FPGA Lab.
   m5+board(/top, /fpga, 7, $, , fpga_calculator)   // 3rd arg selects the board.
   
   
   // ===============================
   // Your TL-Verilog logic goes here
   // ===============================
   // ...
\SV
   // ============================
   // Your Verilog logic goes here
   // ============================
   // ...
   
   endmodule