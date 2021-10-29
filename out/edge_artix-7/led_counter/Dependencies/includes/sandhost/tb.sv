// Provides clk and reset to design.tlv.
// Instantiates design as design(.*) so additional inputs and outputs can be added.
// Ends simulation on max cycles argument below, or assertion of success signal.
// Additional testbench functionality can be added here, or within design using TLV.
// See: "top_module_tlv.m4" for definition.

// -------------------------------------------------------------------
// Expanded from instantiation: m4_top_module_inst(m4_name, m4_max_cycles)
//

module tb();

logic clk, reset;      // Generated in this module for DUT.
logic passed, failed;  // Returned from DUT to this module.  Passed must assert before
                       //   max cycles, without failed having asserted.  Failed can be undriven.
logic [15:0] cyc_cnt;


// Instantiate main module.
top top(.*);


// Clock
initial begin
   clk = 1'b1;
   forever #5 clk = ~clk;
end


// Run
initial begin

   //`ifdef DUMP_ON
      $dumpfile("top.vcd");
      $dumpvars(0, clk, reset, passed, failed, cyc_cnt, top.DEBUG_SIGS);
      $dumpon;
   //`endif

   reset = 1'b1;
   #55;
   reset = 1'b0;

   // Run

   cyc_cnt = '0;
   for (int cyc = 0; cyc < 100; cyc++) begin
      // Failed
      if (failed === 1'b1) begin
         FAILED: assert(1'b1) begin
            $display("Failed!!!  Error condition asserted.");
            $finish;
         end
      end

      // Success
      if (passed) begin
         SUCCESS: assert(1'b1) begin
            $display("Success!!!");
            $finish;
         end
      end

      #10;

      cyc_cnt++;
   end

   // Fail
   DIE: assert (1'b1) begin
      $error("Failed!!!  Test did not complete within m4_max_cycles time.");
      $finish;
   end

end

endmodule  // life_tb
