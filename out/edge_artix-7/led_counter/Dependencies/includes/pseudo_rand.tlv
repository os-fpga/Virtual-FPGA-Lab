\m4_TLV_version 1b: tl-x.org
\SV
/*
Copyright (c) 2014, Steven F. Hoover

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:

    * Redistributions of source code must retain the above copyright notice,
      this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.
    * The name of Steven F. Hoover
      may not be used to endorse or promote products derived from this software
      without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE
FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

module pseudo_rand
  #(parameter WIDTH=257)  // Random vector width, to a max of 257.
  (input  logic clk,
   input  logic reset,
   output logic [WIDTH-1:0] rand_vect
  );

// Currently, this implements a Galois LFSR.
// TODO: It should be XORed with something else so it doesn't just shift.
//       Using polynomials with maximal number of taps would have less regular shifting behavior.

// Bits are numbered in the reverse of the traditional order.  This puts the taps in the lower bit positions.

// Choose optimal parameters for given WIDTH.
localparam LFSR_WIDTH =
  (WIDTH <= 64)   ? 64   :
  (WIDTH <= 128)  ? 128  :
  (WIDTH <= 257)  ? 257  : 0;   // 257 enables a large non-power of two for replication on an irregular boundary.
// Polynomial source: http://www.eej.ulst.ac.uk/~ian/modules/EEE515/files/old_files/lfsr/lfsr_table.pdf
localparam [LFSR_WIDTH-1:0] LFSR_POLY = {{(LFSR_WIDTH-8){1'b0}},
  (LFSR_WIDTH == 64)   ? 8'b00011011 :
  (LFSR_WIDTH == 128)  ? 8'b10000111 :
  (LFSR_WIDTH == 257)  ? 8'b11000101 : 8'b0};

bit [256:0] SEED = 257'h0_7163e168_713d5431_6684e132_5cd84848_f3048b46_76874654_0c45f864_04e4684a;



\TLV
   |default
      @0
         $reset = reset;
      @1
         $lfsr[LFSR_WIDTH-1:0] = $reset ? *SEED : {$lfsr#+1[LFSR_WIDTH-2:0], 1'b0} ^ ({LFSR_WIDTH{$lfsr#+1[LFSR_WIDTH-1]}} & *LFSR_POLY);
      @2
         *rand_vect = $lfsr[WIDTH-1:0];

\SV

endmodule
