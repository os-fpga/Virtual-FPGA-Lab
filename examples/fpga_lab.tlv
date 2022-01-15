\m4_TLV_version 1d -p verilog --bestsv --noline: tl-x.org
\SV
   m4_include_lib(['https://raw.githubusercontent.com/BalaDhinesh/Virtual-FPGA-Lab/499fd4b9a7aa5f08fff69303f0980d86ceb169e7/tlv_lib/fpga_includes.tlv'])
\SV
   m4_lab()

// Example using LEDs to display a binary counter.
\TLV example_fpga_logic(/_fpga)
   |led_pipe  // All TL-Verilog logic should be in a pipeline.
      @0   // Pipeline stage.
         // Run artificially slow in the real FPGA. 
         m4+fpga_heartbeat($refresh, 1, 50000000) 
         $reset = *reset;
         ?$refresh
            $Leds[15:0] <= $reset ? 1 : $Leds + 1;
         // Drive $Leds to the board's LEDs.
         *led = $Leds;
         // Visualize the count driven to LEDs.
         \viz_js
            box: {width: 100, height: 20, strokeWidth: 0},
            render() {
               return [new fabric.Text('$Leds'.asBinaryStr(), {left: 5, top: 5, fill: "yellow", fontSize: 10})]
            }

\TLV
   /board
   
      // Board selection:
      // 0 - 1st CLaaS on AWS F1
      // 1 - Zedboard
      // 2 - Artix-7
      // 3 - Basys3
      // 4 - Icebreaker
      // 5 - Nexys
      m4+board(/board, /fpga, 3, *, , example_fpga_logic)   // 3rd arg selects the board.

\SV
   endmodule
