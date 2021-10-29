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

// Project-independent SandPiper header file.

`ifndef SANDPIPER_VH
`define SANDPIPER_VH


// Note, these have no SP prefix, so collisions are possible.
     

`ifdef WHEN
   // Make sure user definition does not collide.
   !!!ERROR: WHEN macro already defined
`else
   `ifdef SP_PHYS
      // Phys compilation disabled X-injection.
      `define WHEN(valid_sig)
   `else
      // Inject X.
      `define WHEN(valid_sig) !valid_sig ? 'x :
   `endif
`endif


// SandPiper does not generate set/reset flops.  Reset is implemented as combinational
// logic, and it is up to synthesis to infer set/reset flops when possible.
//`ifdef RESET
//   // Make sure user definition does not collide.
//   !!!ERROR: RESET macro already defined
//`else
//   `define RESET(i, reset) ((reset) ? '0 : i)
//`endif
//
//`ifdef SET
//   // Make sure user definition does not collide.
//   !!!ERROR: SET macro already defined
//`else
//   `define SET(i, set) ((set) ? '1 : i)
//`endif

// Since SandPiper required use of all signals, this is useful to create a
// bogus use and keep SandPiper happy when a signal, by intent, has no uses.
`define BOGUS_USE(ignore)

`endif  // SANDPIPER_VH
