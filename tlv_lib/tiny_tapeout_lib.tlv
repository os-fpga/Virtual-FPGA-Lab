\m5_TLV_version 1d: tl-x.org
\m5
   / A library for Tiny-Tapeout-specific projects.
   /use(m5-1.0)
\SV
   m4_include_lib(['https://raw.githubusercontent.com/os-fpga/Virtual-FPGA-Lab/cb3901d709f6668e97a499db33106f50c06843fd/tlv_lib/fpga_includes.tlv'])

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
