# Virtual-FPGA-Lab
This repository contains codebase for Virtual FPGA Lab in Makerchip as part of my Open Source contribution to the Google Summer of Code 2021 under FOSSi Foundation. 

More details about the project : https://summerofcode.withgoogle.com/projects/#6560715852218368

# Contents
[1. Abstract](#abstract)

2. Makerchip
3. What makes the project __Virtual FPGA Lab__ special?
4. FPGA Boards demonstrated
5. Demos
6. Visual Debug
    6.1 How Visual Debug is built?
    6.2 Simple example for visualizing logic gates
    6.3 Simple example on how to add own FPGA boards and peripherals

## Abstract: 
Field-Programmable Gate Array(FPGA) is a hardware circuit that a user can program to carry out logical operations. FPGAs are beneficial for prototyping application-specific integrated circuits (ASICs) or processors. The advantage of FPGA being energy-efficient, flexible to reprogram, support parallelism, decreased latency made them widely used in many applications. But the flexibility of FPGAs comes at the price of the difficulty of reprogramming the circuit. FPGA’s are a bit costly and difficult to learn for beginners. Also, students don’t have access to physical FPGA Lab classes in their curriculum amidst this pandemic situation. So there is a massive demand in having an alternative option of having an online simulator for FPGA curriculum development. 

This project __Virtual FPGA Lab__ aims to solve the problem by taking advantage of the __VIZ Visualization__ feature in the Makerchip platform and provide visualizations of basic peripherals of an FPGA, thereby mimicking the physical lab experience.

## Makerchip:
[Makerchip](http://makerchip.com/) is a free web-based IDE as well as available as [makerchip-app](https://pypi.org/project/makerchip-app/), a virtual desktop application for developing high-quality integrated circuits. You can __code__, __compile__, __simulate__, and __debug__ Verilog designs, all from your browser. Your code, block diagrams, and waveforms are tightly integrated. Makerchip supports the emerging [Transaction-Level Verilog](http://tl-x.org/) standard. Transaction-Level Verilog, or TL-Verilog, represents a huge step forward, by eliminating the need for the legacy language features of Verilog and by introducing simpler syntax. At the same time, TL-Verilog adds powerful constructs for pipelines and transactions. __More details about TL-Verilog:__ https://www.redwoodeda.com/tl-verilog

## What makes the project __Virtual FPGA Lab__ special?
- Move back and forth between cycles so that we can visualize what's happening in each and every cycle.
- Faster to see the output for simple designs. No need to wait for Synthesis, Implementation and Bitstream Generation.
- Abstraction in writing the digital logic in TL-Verilog over standard HDL languages.
- Code in Virtual Lab works on real FPGAs. 

## FPGA Boards demonstrated:
1. Zedboard Zynq-7000 ARM/FPGA SoC Development Board ([Product Link](https://www.avnet.com/wps/portal/us/products/avnet-boards/avnet-board-families/zedboard/))
2. EDGE Artix 7 FPGA Development Board ([Product Link](https://allaboutfpga.com/product/edge-artix-7-fpga-development-board/))
3. Basys 3 Artix-7 FPGA Trainer Board ([Product Link](https://store.digilentinc.com/basys-3-artix-7-fpga-beginner-board-recommended-for-introductory-users/)) 
4. Icebreaker FPGA ([Product Link](https://1bitsquared.com/products/icebreaker))
5. Nexys A7 ([Product Link](https://store.digilentinc.com/nexys-a7-fpga-trainer-board-recommended-for-ece-curriculum/))

Currently we demonstrate using only these three boards and we plan to add more boards in the future. You can very easily to add your own FPGA boards. Contributions are welcome.

## Demos:
[LED Module](https://github.com/BalaDhinesh/Virtual-FPGA-Lab/blob/main/examples/led_counter.tlv)


[Seven segment displays](https://github.com/BalaDhinesh/Virtual-FPGA-Lab/blob/main/examples/seven_segment_counter.tlv) 


[LCD Module](https://github.com/BalaDhinesh/Virtual-FPGA-Lab/blob/main/examples/lcd_module.tlv) 


[VGA display](https://github.com/BalaDhinesh/Virtual-FPGA-Lab/blob/main/examples/vga_display.tlv)


[Temperature sensor](https://github.com/BalaDhinesh/Virtual-FPGA-Lab/blob/main/examples/temperature_sensor.tlv) 


[Light sensor](https://github.com/BalaDhinesh/Virtual-FPGA-Lab/blob/main/examples/light_sensor.tlv) 


[Push buttons](https://github.com/BalaDhinesh/Virtual-FPGA-Lab/blob/main/examples/pushbutton.tlv) 


[Slideswitches](https://github.com/BalaDhinesh/Virtual-FPGA-Lab/blob/main/examples/slideswitch.tlv) 


[RGB LED](https://github.com/BalaDhinesh/Virtual-FPGA-Lab/blob/main/examples/ice_rgb.tlv) 


[RISC-V MYTH Core](https://github.com/BalaDhinesh/Virtual-FPGA-Lab/blob/main/examples/riscv_myth_core.tlv) 

## Visual Debug:
### 1. How Visual Debug is built?
Visual Debug is a __JavaScript__ canvas where we used [fabric.js](http://fabricjs.com/), which is a powerful and simple Javascript HTML5 canvas library framework. It provides us to use interactive object models on top of canvas element.
### 2. Simple example for visualizing logic gates
[Makerchip Sandbox](http://makerchip.com/sandbox/0mZf5hLDQ/0X6hB6q)
![logic_gates](https://raw.githubusercontent.com/BalaDhinesh/ultra-maple-42121/master/images/logic_gates.gif)

Let us first visualize the output of simple digital **logic gates**. From the GIF above, we can see that the left portion is the coding part where you can see the logic of the gates and right portion is the Visual Debug(VIZ) part where you can see the visualization of each logic gates. We can move back and forth between cycles and see in the top right which cycle currently is. Also, look at the waveform of the logic from the below image.

### 3. Simple example on how to add own FPGA boards and peripherals
### Initialize the board:
```
\viz_alpha
    initEach() {                    // initialize this function on start
        let fpga_img_url = "<PASTE YOUR FPGA BOARD IMAGE URL>"
        let fpga_img = new fabric.Image.fromURL(
            fpga_img_url,
            function (img) {
                global.canvas.add(img)          // add image to canvas
                global.canvas.sendToBack(img);  // z-indexing always on bottom
            },
            {
                // tweak the values here according to your board
                originX: "center",
                originY: "center",
                left: 0,
                top: 0,
                scaleX: 0.3,
                scaleY: 0.3,
            }
            )
    }
```
### Interfacing LEDs:
```
/led[7:0]                               // Hierarchy. The width is the number of LEDs in the board
    \viz_alpha
        initEach() {                     // initialize this function on start
            // Fabric js object
            let led = new fabric.Rect({
                // modify these values according to your board
                top: 233,
                left: 151 - 32 * (this.getIndex() + 1),
                width: 6, 
                height: 11, 
                fill: "red",
                opacity: 0
                })
            // The objects that we return can be used in renderEach function
            return{objects : {led}}; 
        }, 
        renderEach() {                  // initialize this function on every cycle count
            // LED ON/OFF logic
            var mod = ((('/top|_pipe$_leds'.asInt(-1) >> this.getScope("led").index) & 1) == 1);
            // The object "led" that was returned in initEach is used below using this.getInitObjects() method
            this.getInitObject().led.set(mod ? {opacity: 1} : {opacity: 0});
        }
```
