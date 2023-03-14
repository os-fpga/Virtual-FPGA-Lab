\m4_TLV_version 1d -p verilog --bestsv --noline: tl-x.org
\SV
   m4_include_lib(['https://raw.githubusercontent.com/os-fpga/Virtual-FPGA-Lab/3760a43f58573fbcf7b7893f13c8fa01da6260fc/tlv_lib/fpga_includes.tlv'])                   


   // Board Selection
   // ===============
   // Options:
   //   0 - 1st CLaaS on AWS F1
   //   1 - Zedboard
   //   2 - Artix-7
   //   3 - Basys3
   //   4 - Icebreaker
   //   5 - Nexys
   //   6 - CLEAR
   m4_def(m4_board, 3)  // Choose from above.


// Top-level module declaration and pin signal declarations.
m4+lab()


\TLV fpga(/_fpga)

   // ===== Your FPGA logic here =====
   
   // FPGA logic can drive the signals declared by m4+lab(), above, as seen in the NAV-TLV tab.
   // (Not all boards utilize all signals.)
   
   // For example:
   *led[15:0] = *cyc_cnt[15:0];
   *sseg_digit_n[7:0] = 8'b1 << *cyc_cnt[2:0];
   *sseg_segment_n[6:0] = 7'b1 << *cyc_cnt[2:0];
   *sseg_decimal_point_n = *cyc_cnt[2:0] == 3'b111;
   
   // ================================


// The workbench.
// Instantiate the board.
\TLV
   /board
      m4+board(/board, /fpga, m4_board, *, , fpga)
\SV
   endmodule
