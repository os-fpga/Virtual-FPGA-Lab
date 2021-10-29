/*
Copyright (c) 2015, Steven F. Hoover

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


`include "rw_lib.vh"

// A simple implementation of a FIFO with bypass.
// Head is stored outside of the FIFO array.
// When the FIFO is empty, input goes straight through mux to output.
module simple_bypass_fifo(
   input logic clk,
   input logic reset,
   input logic push,
   input logic [WIDTH-1:0] data_in,        // Timed with push.
   input logic pop,                        // May pop in same cycle as push to empty FIFO.
   output logic [WIDTH-1:0] data_out,      // Same cycle as pop.
   output logic [$clog2(DEPTH+1)-1:0] cnt  // Reflecting push/pop last cycle.  0..DEPTH.
);
   parameter WIDTH = 8;
   parameter DEPTH = 8;

   logic [$clog2(DEPTH)-1:0] next_head, tail;
   logic [WIDTH-1:0] arr [DEPTH-1:0], arr_out, head_data;
   logic cnt_zero_or_one, cnt_zero, cnt_one;
   logic push_arr, push_head, pop_from_arr, popped_from_arr;

   always_ff @(posedge clk) begin
      if (reset) begin
         tail <= {$clog2(DEPTH){1'b0}};
         next_head <= {$clog2(DEPTH){1'b0}};
         cnt <= {$clog2(DEPTH+1){1'b0}};
      end else begin
         if (push_arr
            ) begin
            arr[tail] <= data_in;
            tail <= tail + {{$clog2(DEPTH)-1{1'b0}}, 1'b1};
         end
         if (pop) begin
            arr_out <= arr[next_head];
            next_head <= next_head + {{$clog2(DEPTH)-1{1'b0}}, 1'b1};
         end
         if (push ^ pop) begin
            cnt <= cnt + (push ? {{$clog2(DEPTH+1)-1{1'b0}}, 1'b1} /* 1 */ : {$clog2(DEPTH+1){1'b1}} /* -1 */);
         end
      end
   end
   always_comb begin
      // Control signals

      // These are timed with cnt (cycle after push/pop)
      cnt_zero_or_one = (cnt >> 1) == {$clog2(DEPTH+1){1'b0}};
      cnt_zero = cnt_zero_or_one && ~cnt[0];
      cnt_one = cnt_zero_or_one && cnt[0];

      // These are timed with push/pop
      // Cases in which a push would not got into array.
      push_arr = push && !(cnt_zero || (cnt_zero_or_one && pop));
      push_head = push && (pop ? cnt_one : cnt_zero);
      pop_from_arr = pop && !cnt_zero_or_one;

      // Output data
      data_out = cnt_zero ? data_in : head_data;
   end

   // Head
   always_ff @(posedge clk) begin
      popped_from_arr <= pop_from_arr;
      if (push_head) begin
         head_data <= data_in;
      end else if (popped_from_arr) begin
         head_data <= arr_out;
      end
   end
endmodule
