\m4_TLV_version 1d: tl-x.org
\SV      // System Verilog
   
   m4_makerchip_module   // (Expanded in Nav-TLV pane.)
   // module top(input wire clk, input wire reset, input wire [31:0] cyc_cnt, output wire passed, output wire failed); // This is the equivalent of the above line
   /* verilator lint_on WIDTH */


\TLV     // TL-Verilog
   /dummy
      // reset signal from instantiation of m4_makerchip_module above
      $reset = *reset;
      
      // Two inputs, x1 and x2, used a counter to increment its value to obtain all input values
      $x[1:0] = $reset ? 3 : >>1$x+1;
      $x1 = $x[1];
      $x0 = $x[0];
      
      // Logic
      $and = $x1 & $x0;
      $or = $x1 | $x0;
      $not_x1 = !$x1;
      $not_x0 = !$x0;
      $nand = !($x1 & $x0);
      $nor = !($x1 | $x0);
      $xor = $x1 ^ $x0;
      $xnor = !($x1 ^ $x0);


      // Assert these to end simulation (before Makerchip cycle limit).
      *passed = *cyc_cnt > 40;      // Simulation ends after 40 cycles
      *failed = 1'b0;


      // Visualization for logic gates
      \viz_alpha
         // JavaScript code
         initEach(){               // This function executes at the start
         
            // Function to add text - used for displaying the logic gate names
            function addtext(text, left, top){
               // Fabric.js Text object
               var value = new fabric.Text(text, {
                    left: left,
                    top: top,
                    fontSize: 28,
                    fontFamily: "Courier New",
                  })
               global.canvas.add(value)      // Add the text object into the canvas
            }
            addtext("Digital Logic Gates", -200, -250)
            addtext("AND", -130, -170)
            addtext("OR", 80, -170)
            addtext("NAND", -130, -20)
            addtext("NOR", 70, -20)
            addtext("XOR", -130, 130)
            addtext("XNOR", 70, 130)
            
            // Image URLs
            let and_img_url = "https://upload.wikimedia.org/wikipedia/commons/thumb/6/64/AND_ANSI.svg/150px-AND_ANSI.svg.png"
            let or_img_url = "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b5/OR_ANSI.svg/150px-OR_ANSI.svg.png"
            let nand_img_url = "https://upload.wikimedia.org/wikipedia/commons/thumb/f/f2/NAND_ANSI.svg/150px-NAND_ANSI.svg.png"
            let nor_img_url = "https://upload.wikimedia.org/wikipedia/commons/thumb/6/6c/NOR_ANSI.svg/150px-NOR_ANSI.svg.png"
            let xor_img_url = "https://upload.wikimedia.org/wikipedia/commons/thumb/0/01/XOR_ANSI.svg/150px-XOR_ANSI.svg.png"
            let xnor_img_url = "https://upload.wikimedia.org/wikipedia/commons/thumb/d/d6/XNOR_ANSI.svg/150px-XNOR_ANSI.svg.png"
            
            // Function to add image - used for displaying the logic gate images
            function add_image(url, left, top){
            // Fabric.js add image object
               fabric.Image.fromURL(
                        url,
                        function (img) {
                           global.canvas.add(img)     // Add the image object into the canvas
                        },
                        {originX: "center",
                         originY: "center",
                         left: left,
                         top: top,
                         scaleX: 0.8,
                         scaleY: 0.8,
                         angle: 0,
                        }
                     )
            }
            add_image(and_img_url, -100, -100)
            add_image(or_img_url, 100, -100)
            add_image(nand_img_url, -100, 50)
            add_image(nor_img_url, 100, 50)
            add_image(xor_img_url, -100, 200)
            add_image(xnor_img_url, 100, 200)
            
            // Value for logic gate gate inputs and outputs
            let and_x1 = new fabric.Text("", {
              left: -180,
              top: -130,
              fontSize: 28,
              fontFamily: "Courier New",
            })
            let and_x0 = new fabric.Text("", {
              left: -180,
              top: -100,
              fontSize: 28,
              fontFamily: "Courier New",
            })
            let and_output = new fabric.Text("", {
              left: -40,
              top: -120,
              fontSize: 28,
              fontFamily: "Courier New",
            })
            let or_x1 = new fabric.Text("", {
              left: 20,
              top: -130,
              fontSize: 28,
              fontFamily: "Courier New",
            })
            let or_x0 = new fabric.Text("", {
              left: 20,
              top: -100,
              fontSize: 28,
              fontFamily: "Courier New",
            })
            let or_output = new fabric.Text("", {
              left: 160,
              top: -120,
              fontSize: 28,
              fontFamily: "Courier New",
            })
            let nand_x1 = new fabric.Text("", {
              left: -180,
              top: 20,
              fontSize: 28,
              fontFamily: "Courier New",
            })
            let nand_x0 = new fabric.Text("", {
              left: -180,
              top: 50,
              fontSize: 28,
              fontFamily: "Courier New",
            })
            let nand_output = new fabric.Text("", {
              left: -40,
              top: 35,
              fontSize: 28,
              fontFamily: "Courier New",
            })
            let nor_x1 = new fabric.Text("", {
              left: 20,
              top: 20,
              fontSize: 28,
              fontFamily: "Courier New",
            })
            let nor_x0 = new fabric.Text("", {
              left: 20,
              top: 50,
              fontSize: 28,
              fontFamily: "Courier New",
            })
            let nor_output = new fabric.Text("", {
              left: 160,
              top: 35,
              fontSize: 28,
              fontFamily: "Courier New",
            })
            let xor_x1 = new fabric.Text("", {
              left: -180,
              top: 170,
              fontSize: 28,
              fontFamily: "Courier New",
            })
            let xor_x0 = new fabric.Text("", {
              left: -180,
              top: 200,
              fontSize: 28,
              fontFamily: "Courier New",
            })
            let xor_output = new fabric.Text("", {
              left: -40,
              top: 185,
              fontSize: 28,
              fontFamily: "Courier New",
            })
            let xnor_x1 = new fabric.Text("", {
              left: 20,
              top: 170,
              fontSize: 28,
              fontFamily: "Courier New",
            })
            let xnor_x0 = new fabric.Text("", {
              left: 20,
              top: 200,
              fontSize: 28,
              fontFamily: "Courier New",
            })
            let xnor_output = new fabric.Text("", {
              left: 160,
              top: 185,
              fontSize: 28,
              fontFamily: "Courier New",
            })
            // The objects that we return here only can be used in the below renderEach function
            return {objects: 
                   {and_x0, and_x1, and_output, or_x0,
                    or_x1, or_output, nand_x0, nand_x1, nand_output, 
                    nor_x0, nor_x1, nor_output, xor_x0, xor_x1, 
                    xor_output, xnor_x0, xnor_x1, xnor_output}
                   }
         },
         renderEach() {                 // This method executes for every cycle
            // Get TLV signals $x0 and $x1 from TLV as a Binary String
            let x0 = '$x0'.asBinaryStr()
            let x1 = '$x1'.asBinaryStr()
            
            // The objects that was returned in initEach() function are used below using this.getInitObject("<object_name>") method
            
            // set inputs
            this.getInitObject("and_x0").setText(x0)
            this.getInitObject("and_x1").setText(x1)
            this.getInitObject("or_x0").setText(x0)
            this.getInitObject("or_x1").setText(x1)
            this.getInitObject("nand_x0").setText(x0)
            this.getInitObject("nand_x1").setText(x1)
            this.getInitObject("nor_x0").setText(x0)
            this.getInitObject("nor_x1").setText(x1)
            this.getInitObject("xor_x0").setText(x0)
            this.getInitObject("xor_x1").setText(x1)
            this.getInitObject("xnor_x0").setText(x0)
            this.getInitObject("xnor_x1").setText(x1)
            
            // set outputs
            this.getInitObject("and_output").setText('$and'.asBinaryStr())
            this.getInitObject("or_output").setText('$or'.asBinaryStr())
            this.getInitObject("nand_output").setText('$nand'.asBinaryStr())
            this.getInitObject("nor_output").setText('$nor'.asBinaryStr())
            this.getInitObject("xor_output").setText('$xor'.asBinaryStr())
            this.getInitObject("xnor_output").setText('$xnor'.asBinaryStr())
            }
\SV
   endmodule      // close the module
