\m5_TLV_version 1d: tl-x.org
\m5
   / A library for Tiny-Tapeout-specific projects.
   /use(m5-1.0)

   / A macro that declares the real Tiny Tapeout top-level module that debounces and synchronizes inputs for
   / the user's Tiny Tapeout module.
   macro(tt_top, ['
      // The Tiny Tapeout top-level module.
      // This simply debounces and synchronizes inputs.
      // Debouncing is based on a counter. A change to any input will only be recognized once ALL inputs
      // are stable for a certain duration. This approach uses a single counter vs. a counter for each
      // bit.
      module $1 (
          input  wire [7:0] ui_in,    // Dedicated inputs - connected to the input switches
          output wire [7:0] uo_out,   // Dedicated outputs - connected to the 7 segment display
          input  wire [7:0] uio_in,   // IOs: Bidirectional Input path
          output wire [7:0] uio_out,  // IOs: Bidirectional Output path
          output wire [7:0] uio_oe,   // IOs: Bidirectional Enable path (active high: 0=input, 1=output)
          input  wire       ena,      // will go high when the design is enabled
          input  wire       clk,      // clock
          input  wire       rst_n     // reset_n - low to reset
      );
          // Synchronize.
          logic [17:0] inputs_ff, inputs_sync;
          always @(posedge clk) begin
              inputs_ff <= {ui_in, uio_in, ena, rst_n};
              inputs_sync <= inputs_ff;
          end
          
          // Debounce.
          `define DEBOUNCE_MAX_CNT 8'hff
          logic [17:0] inputs_candidate, inputs_captured;
          logic sync_rst_n = inputs_sync[0];
          logic [7:0] cnt;
          always @(posedge clk) begin
              if (!sync_rst_n)
                 cnt <= `DEBOUNCE_MAX_CNT;
              else if (inputs_sync != inputs_candidate) begin
                 // Inputs changed before stablizing.
                 cnt <= `DEBOUNCE_MAX_CNT;
                 inputs_candidate <= inputs_sync;
              end
              else if (cnt > 0)
                 cnt <= cnt - 8'b1;
              else begin
                 // Cnt == 0. Capture candidate inputs.
                 inputs_captured <= inputs_candidate;
              end
          end
          logic [7:0] clean_ui_in, clean_uio_in;
          logic clean_ena, clean_rst_n;
          assign {clean_ui_in, clean_uio_in, clean_ena, clean_rst_n} = inputs_captured;
          
          my_design my_design (
              .ui_in(clean_ui_in),
              .uio_in(clean_uio_in),
              .ena(clean_ena),
              .rst_n(clean_rst_n),
              .*);
      endmodule
   '])
\SV
   m4_include_lib(['https://raw.githubusercontent.com/os-fpga/Virtual-FPGA-Lab/5d566e2f7089ec64f25e59683691c5f65dab5f36/tlv_lib/fpga_includes.tlv'])

// Map TT I/Os to Virtual Lab.
\TLV tt_connections()
   $slideswitch[7:0] = *ui_in;
   $sseg_segment_n[6:0] = *uo_out[6:0];
   $sseg_decimal_point_n = *uo_out[7];
   $sseg_digit_n[7:0] = 8'b11111110;

\TLV tt_input_labels_viz(_labels_js)
   /input_label[7:0]
      \viz_js
         box: {width: 40, height: 10, strokeWidth: 0, fill: "#ffffffa0", rx: 4, ry: 4},
         layout: {left: 0, top: -18},
         init() {
            let labels = [_labels_js]
            return {
               label: new fabric.Text(labels[this.getIndex()], {
                  top: 1,
                  left: 38,
                  fontSize: 6,
                  fontFamily: "Courier New",
                  fontWeight: 600,
                  originX: "right"
               })
            }
         },
         where: {left: 242, top: 148, scale: 1.05}
