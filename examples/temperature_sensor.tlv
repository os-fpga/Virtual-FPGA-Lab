\m4_TLV_version 1d -p verilog --bestsv --noline: tl-x.org
\SV
   m4_include_lib(['https://raw.githubusercontent.com/BalaDhinesh/Virtual-FPGA-Lab/main/viz_libraries/fpga_includes.tlv'])                   
\SV
   m4_ifelse_block(M4_MAKERCHIP, 1,['
   `include "sqrt32.v";
   m4_makerchip_module   
   '],['
   module top(
    input clk, vauxp7, vauxn7, vauxp15, vauxn15, input reset,
    output [3:0] digit, output [6:0] sseg, output dp
	);
   wire [15:0] data_adc;
   wire [6:0] addr_in;
   wire enable, ready;
   xadc_wiz_0 ADC1
		(
          .daddr_in(addr_in),            // Address bus for the dynamic reconfiguration port
          .dclk_in(clk),             // Clock input for the dynamic reconfiguration port
          .den_in(1),              // Enable Signal for the dynamic reconfiguration port
          .di_in(0),               // Input data bus for the dynamic reconfiguration port
          .dwe_in(0),              // Write Enable for the dynamic reconfiguration port
          .vauxp6(),              // Auxiliary channel 6
          .vauxn6(),
          .vauxp7(vauxp7),              // Auxiliary channel 7
          .vauxn7(vauxn7),
          .vauxp14(),             // Auxiliary channel 14
          .vauxn14(),
          .vauxp15(vauxp15),             // Auxiliary channel 15
          .vauxn15(vauxn15),
          .busy_out(),            // ADC Busy signal
          .channel_out(),         // Channel Selection Outputs
          .do_out(data_adc),              // Output data bus for dynamic reconfiguration port
          .drdy_out(ready),            // Data ready signal for the dynamic reconfiguration port
          .eoc_out(enable),             // End of Conversion Signal
          .eos_out(),             // End of Sequence Signal
          .alarm_out(),           // OR'ed output of all the Alarms    
          .vp_in(0),               // Dedicated Analog Input Pair
          .vn_in(0)
		);
   ']
   )  
\TLV
   |temp_pipe
      @0
         //https://icons8.com/icons/set/sun
         $reset = *reset;
         $addr_in[6:0] = $ready ? 7'b0010111 : 0;
         m4_ifelse_block(M4_MAKERCHIP, 1,['
         $ready = 1;
         $check = (/top|sseg_pipe$Count == 0);
         $left[5:0] = 0;
         $top[5:0] = $reset ? 0 : $check ? >>1$top + 1 : $RETAIN;
         //$data_adc[15:0] = (640 - $left) * (640 + $top);
         $value[15:0] = sqrt(((640 - $left) ** 2) + ((640 - $top) ** 2));
         $max[7:0] = 150;
         $data_adc[10:0] = int'((($value - 816) * ($max - 20) / 89) + 20);
         \viz_alpha
            initEach(){
            let temp_val = '/top|temp_pipe$max'.asInt()
            console.log("t", temp_val)
            let block_square = new fabric.Rect(
                     {originX: "center",
                      originY: "center",
                      width: 490,
                      height: 300,
                      fill: transparent
                     }
                  )
            let logic_block = new fabric.Group([block_square],
                  {originX: "center",
                   originY: "center",
                   angle: 0,
                   width: 20,
                   height: 20
                  })
            let sun_img_url = "https://raw.githubusercontent.com/BalaDhinesh/Virtual-FPGA-Lab/main/images/icons8-sun-144.png"
            let sun_img = new fabric.Image.fromURL(
                        sun_img_url,
                        function (img) {
                           let value = new fabric.Text(temp_val + "C", {
                             left: -236,
                             top: 130,
                             fontSize: 15,
                             fill: "black",
                             fontFamily: "Courier New",
                           })
                           logic_block.add(img)
                           logic_block.add(value)
                           global.canvas.bringToFront(logic_block)
                           global.canvas.renderAll()
                        },
                        {originX: "center",
                         originY: "center",
                         left: -220,
                         top: 140,
                         scaleX: 0.6,
                         scaleY: 0.6,
                         angle: 0
                        }
                     )
             
             return {objects:{logic_block}}
            },
            renderEach(){
            let left = '|temp_pipe$left'.asInt()
            let top = '|temp_pipe$top'.asInt()
            this.getInitObjects().logic_block.animate({left: left * 10, top:-top * 10}, { onChange: this.global.canvas.renderAll.bind(this.global.canvas), duration:300 })
            console.log("left",640-this.getInitObjects().logic_block.get("left"))
            console.log("top",640+this.getInitObjects().logic_block.get("top"))
            }
         '],['
         $ready = *ready;
         $data_adc[15:0] = (*data_adc[15:4]) * 330 / 4096;
         *addr_in = $addr_in;
         ']
         )
   |sseg_pipe
      @0   
         $data_adc[15:0] = /top|temp_pipe$data_adc;         
         m4+fpga_refresh($refresh, m4_ifelse(M4_MAKERCHIP, 1, 1, 500000))  
         $reset = *reset;
         ?$refresh
            //All 4 digits can be enabled by sending logic ‘0’.
            //Each segment can be enabled by sending logic ‘0’
            $Count[1:0] <= $reset ? 0 : $Count + 1;
            $digit[3:0] = $Count == 0 ? 4'b1110 : 
                       $Count == 1 ? 4'b1101 : 
                       $Count == 2 ? 4'b1011 : 
                       4'b0111; 
            $led_bcd[3:0] =    (($Count == 0) ? ((($data_adc % 1000) % 100) % 10)  : // 1st digit in 16-bit no.
                            ($Count == 1) ?  (($data_adc % 1000) % 100) / 10:  // 2nd digit in 16-bit no. 
                            ($Count == 2) ?  ($data_adc % 1000) / 100 :   // 3rd digit in 16-bit no.
                            ($Count == 3) ? $data_adc / 1000 : 
                             4'b0);  
            $sseg[6:0] = ($led_bcd == 0) ? 7'b0000001 : // '0'
                         ($led_bcd == 1) ? 7'b1001111 : // '1'
                         ($led_bcd == 2) ? 7'b0010010 : // '2'
                         ($led_bcd == 3) ? 7'b0000110 : // '3'
                         ($led_bcd == 4) ? 7'b1001100 : // '4'
                         ($led_bcd == 5) ? 7'b0100100 : // '5'
                         ($led_bcd == 6) ? 7'b0100000 : // '6'
                         ($led_bcd == 7) ? 7'b0001111 : // '7'
                         ($led_bcd == 8) ? 7'b0000000 : // '8'
                         ($led_bcd == 9) ? 7'b0000100 : // '9'
                         ($led_bcd == 10) ? 7'b0000010 : // 'a'
                         ($led_bcd == 11) ? 7'b1100000 : // 'b'
                         ($led_bcd == 12) ? 7'b0110001 : // 'c'
                         ($led_bcd == 13) ? 7'b1000010 : // 'd'
                         ($led_bcd == 14) ? 7'b0010000 : // 'e'
                         ($led_bcd == 15) ? 7'b0111000 : // 'f'
                         7'b1111111 ;                   // 'nothing'
            $dp = 1;                
         m4_ifelse_block(M4_MAKERCHIP, 1,[''],['
         *digit = $digit;
         *sseg = $sseg;
         *dp = $dp;
         '])
   m4_ifelse_block(M4_MAKERCHIP, 1, ['
   // M4_BOARD numbering
   // 1 - Zedboard
   // 2 - Artix-7
   // 3 - Basys3
   // 4 - Icebreaker
   // 5 - Nexys
   m4_define(M4_BOARD, 3)
   m4+fpga_init(|top_pipe, @0)
   m4+fpga_sseg(|sseg_pipe, @0, $digit, $sseg, $dp)   
   *passed = *cyc_cnt > 400;
   *failed = 1'b0;   
   '])
   
\SV
   endmodule