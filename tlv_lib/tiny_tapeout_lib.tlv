\m5_TLV_version 1d: tl-x.org
\m5
   / A library for Tiny-Tapeout-specific projects.
   /use(m5-1.0)

   default_var(target, FPGA)  /// Should be set externally. TODO: Currently named specifically for MEST course. Better to use tt_version or something.

   fn(if_fpga, fpga_body, ?asic_body, {
      ~if_eq(m5_target, FPGA, ['m5_fpga_body'], ['m5_asic_body'])
   })

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
          m5_if_fpga(['/']['*'])   // The FPGA is based on TinyTapeout 3 which has no bidirectional I/Os (vs. TT6 for the ASIC).
          input  wire [7:0] uio_in,   // IOs: Bidirectional Input path
          output wire [7:0] uio_out,  // IOs: Bidirectional Output path
          output wire [7:0] uio_oe,   // IOs: Bidirectional Enable path (active high: 0=input, 1=output)
          m5_if_fpga(['*']['/'])
          input  wire       ena,      // will go high when the design is enabled
          input  wire       clk,      // clock
          input  wire       rst_n     // reset_n - low to reset
      );
          m5_var(input_range, m5_if_fpga(['9:0'], ['17:0']))
          // Synchronize.
          logic [m5_input_range] inputs_ff, inputs_sync;
          always @(posedge clk) begin
              inputs_ff <= {ui_in, m5_if_fpga([''], ['uio_in, '])ena, rst_n};
              inputs_sync <= inputs_ff;
          end
          
          // Debounce.
          `define DEBOUNCE_MAX_CNT m5_if_defined_as(MAKERCHIP, 1, ['14'h8'], ['14'h3fff'])
          logic [m5_input_range] inputs_candidate, inputs_captured;
          logic sync_rst_n = inputs_sync[0];
          logic [13:0] cnt;
          always @(posedge clk) begin
              if (!sync_rst_n)
                 cnt <= `DEBOUNCE_MAX_CNT;
              else if (inputs_sync != inputs_candidate) begin
                 // Inputs changed before stablizing.
                 cnt <= `DEBOUNCE_MAX_CNT;
                 inputs_candidate <= inputs_sync;
              end
              else if (cnt > 0)
                 cnt <= cnt - 14'b1;
              else begin
                 // Cnt == 0. Capture candidate inputs.
                 inputs_captured <= inputs_candidate;
              end
          end
          logic [7:0] clean_ui_in\m5_if_fpga([''], [', clean_uio_in']);
          logic clean_ena, clean_rst_n;
          assign {clean_ui_in, m5_if_fpga([''], ['clean_uio_in, '])clean_ena, clean_rst_n} = inputs_captured;
          
          my_design my_design (
              .ui_in(clean_ui_in),
              m5_if_fpga([''], ['.uio_in(clean_uio_in),'])
              .ena(clean_ena),
              .rst_n(clean_rst_n),
              .*);
      endmodule
   '])
\SV
   m4_include_lib(['https://raw.githubusercontent.com/os-fpga/Virtual-FPGA-Lab/a069f1e4e19adc829b53237b3e0b5d6763dc3194/tlv_lib/fpga_includes.tlv'])

// Map TT I/Os to Virtual Lab.
\TLV tt_connections()
   $slideswitch[7:0] = *ui_in;
   $sseg_segment_n[6:0] = ~ *uo_out[6:0];
   $sseg_decimal_point_n = ~ *uo_out[7];
   $sseg_digit_n[7:0] = 8'b11111110;

\TLV tt_input_labels_viz(_labels_js)
   /input_label[7:0]
      \viz_js
         box: {width: 40, height: 10, strokeWidth: 0, fill: "#ffffffa0", rx: 4, ry: 4},
         layout: {left: 0, top: 18},
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
         where: {left: 370, top: 437, scale: 2.9}

\TLV tt_pmod_led(/_led, _sig_prefix)
   /_led
      \viz_js
            box: {width: 100, height: 100, strokeWidth: 0},
            where: {left: 0, top: 0},
            init() {
               let img = this.newImageFromURL(
                  "https://blastfromthepast.dev/assets/Pmod_LED.png",
                  "",
                  {
                     left: 0,
                     top: 0,
                     width: 100,
                     height: 100,
                  }
               );
         
               let ledPositions = [30, 37, 45, 53];
               let leds = [];
         
               for (let i = 0; i < 4; i++) {
                  leds.push(new fabric.Rect({
                     left: 73,
                     top: ledPositions[i],
                     width: 3,
                     height: 3,
                     fill: "rgb(255, 43, 57)",
                     stroke: "rgb(255, 43, 57)"
                  }));
               }
         
               return {img, led0: leds[0], led1: leds[1], led2: leds[2], led3: leds[3]};
            },
            renderEach() {
               this.led0.fill = $ld0_out ? "rgb(255, 43, 57)" : "rgb(100, 100, 100)";
               this.led1.fill = $ld1_out ? "rgb(255, 43, 57)" : "rgb(100, 100, 100)";
               this.led2.fill = $ld2_out ? "rgb(255, 43, 57)" : "rgb(100, 100, 100)";
               this.led3.fill = $ld3_out ? "rgb(255, 43, 57)" : "rgb(100, 100, 100)";
            }


\TLV tt_pmod_ssd(/_ssd, _sig_prefix)
   /_ssd
      \viz_js
         box: {strokeWidth: 0},
         where: {left: #_left, top: #_top},
         init() {
            let img = this.newImageFromURL(
               "https://blastfromthepast.dev/assets/Pmod_SSD.png",
               "",
               {
                  left: 0,
                  top: 0,
                  width: 100,
                  height: 100,
               }
            );
            return {img};
         }

\TLV tt_pmod_btn(/_btn, _sig_prefix)
   /_btn
      \viz_js
         box: {strokeWidth: 0},
         init() {
            let img = this.newImageFromURL(
               "https://blastfromthepast.dev/assets/Pmod_BTN.png",
               "",
               {
                  left: 0,
                  top: 0,
                  width: 100,
                  height: 100,
               }
            );
            return {img};
         }

\TLV tt_pmod_kypd(/_kypd, _sig_prefix)
   /_kypd
      \viz_js
         box: {strokeWidth: 0},
         init() {
            let img = this.newImageFromURL(
               "https://blastfromthepast.dev/assets/Pmod_KYPD.png",
               "",
               {
                  left: 0,
                  top: 0,
                  width: 100,
                  height: 100,
               }
            );
            return {img};
         }
