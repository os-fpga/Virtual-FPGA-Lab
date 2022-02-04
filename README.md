
# Virtual FPGA Lab
- **Develop FPGA logic in your browser!**
- **Run on your own FPGA!**
- **Share with others!**


## Contents
[1. Abstract](#1-abstract)

[2. About Makerchip](#2-about-makerchip)

[3. What makes the project __Virtual FPGA Lab__ special?](#3-what-makes-the-project-virtual-fpga-lab-special)

[4. FPGA Boards demonstrated](#4-fpga-boards-demonstrated)

[5. FPGA peripheral macro instantiations](#5-fpga-peripheral-macro-instantiations)
- [5.1 Board Select](#51-board-select)
- [5.2 Board Initailisation](#52-board-initailisation)
- [5.3 LED Module](#53-led-module)
- [5.4 Seven segment displays](#54-seven-segment-displays)
- [5.5 LCD Module](#55-lcd-module)
- [5.6 VGA display](#56-vga-display)
- [5.7 Push buttons](#57-push-buttons)
- [5.8 Slideswitches](#58-slideswitches)

[6. Examples](#6-examples)

[7. Visual Debug](#7-visual-debug)
- [7.1 How Visual Debug is built?](#71-how-visual-debug-is-built)
- [7.2 Examples](#72-examples)
    - [7.2.1 Visualizing logic gates](#721-visualizing-logic-gates)
    - [7.2.2 Visualizing LCD 16x2 display](#722-visualizing-lcd-16x2-display)

[8. How to add own FPGA boards and peripherals](#8-how-to-add-own-fpga-boards-and-peripherals)
- [8.1 Adding custom FPGA board](#81-adding-custom-fpga-board)
- [8.1 Interfacing LEDs](#82-interfacing-leds)

[9. Steps to run in an actual FPGA](#9-steps-to-run-in-an-actual-fpga)

[10. Future Scope](#10-future-scope)

[11. Sponsors](#11-sponsors)

[12. Contributors](#12-contributors)

[13. Contributing](#13-contributing)

[14. License](#14-license)

[15. Disclaimer](#15-disclaimer)




## 1. Abstract: 
<p align="left">

<img src="https://user-images.githubusercontent.com/64545984/130665673-63e52c11-f5e4-4290-8d05-a5a0741fbbbd.png" alt="artix preview" width="600" >
</p>
Field-Programmable Gate Array(FPGA) is a hardware circuit that a user can program to carry out logical operations. FPGAs are beneficial for prototyping application-specific integrated circuits (ASICs) or processors. The advantage of FPGA being energy-efficient, flexible to reprogram, support parallelism, decreased latency made them widely used in many applications. But the flexibility of FPGAs comes at the price of the difficulty of reprogramming the circuit. FPGA’s are a bit costly and difficult to learn for beginners. Also, students don’t have access to physical FPGA Lab classes in their curriculum amidst this pandemic situation. So there is a massive demand in having an alternative option of having an online simulator for FPGA curriculum development. 

This project __Virtual FPGA Lab__ aims to solve the problem by taking advantage of the __VIZ Visualization__ feature in the Makerchip platform and provide visualizations of basic peripherals of an FPGA, thereby mimicking the physical lab experience.

Here is the link to the blog post: [Link](https://medium.com/@m.baladhinesh/fpgas-in-your-browser-bb92be1c1fa3)

## 2. About Makerchip:
[Makerchip](http://makerchip.com/) is a free web-based IDE as well as available as [makerchip-app](https://pypi.org/project/makerchip-app/), a virtual desktop application for developing high-quality integrated circuits. You can __code__, __compile__, __simulate__, and __debug__ Verilog designs, all from your browser. Your code, block diagrams, and waveforms are tightly integrated. Makerchip supports the emerging [Transaction-Level Verilog](http://tl-x.org/) standard. Transaction-Level Verilog, or TL-Verilog, represents a huge step forward, by eliminating the need for the legacy language features of Verilog and by introducing simpler syntax. At the same time, TL-Verilog adds powerful constructs for pipelines and transactions. __More details about TL-Verilog:__ https://www.redwoodeda.com/tl-verilog

## 3. What makes the project __Virtual FPGA Lab__ special?
- __Easy Learning📖:__ Understanding the basics of FPGA programming without having an actual board 
- __Time travel😜:__  Move back and forth between cycles so that we can visualize what's happening in each cycle.
- __Faster🚀:__ No need to wait for Synthesis, Implementation and Bitstream Generation for simple designs.
- __Abstraction💪:__ TL-V requires lesser code than standard HDL languages, making faster development, fewer bugs, easier maintenance, and better quality silicon. It supports System Verilog as well.
- __Synthesizable😊:__ Code in Virtual Lab works on real FPGAs!!!. We will cover this in the last section.
- __Open Source🥰:__ Licensed under MIT.

## 4. FPGA Boards demonstrated:
1. Zedboard Zynq-7000 ARM/FPGA SoC Development Board ([Product Link](https://www.avnet.com/wps/portal/us/products/avnet-boards/avnet-board-families/zedboard/))
2. EDGE Artix 7 FPGA Development Board ([Product Link](https://allaboutfpga.com/product/edge-artix-7-fpga-development-board/))
3. Basys 3 Artix-7 FPGA Trainer Board ([Product Link](https://store.digilentinc.com/basys-3-artix-7-fpga-beginner-board-recommended-for-introductory-users/)) 
4. Icebreaker FPGA ([Product Link](https://1bitsquared.com/products/icebreaker))
5. Nexys A7 ([Product Link](https://store.digilentinc.com/nexys-a7-fpga-trainer-board-recommended-for-ece-curriculum/))

Currently we demonstrate using only these boards and we plan to add more boards in the future. You can very easily to add your own FPGA boards. Contributions are welcome.

## 5. FPGA peripheral macro instantiations:
#### 5.1 Board select:
```
m4_define(M4_BOARD, 1)      // This should always be declared for below macros to work

// M4_BOARD numbering
// 1 - Zedboard
// 2 - Artix-7
// 3 - Basys3
// 4 - Icebreaker
// 5 - Nexys
```
#### 5.2 Board Initailisation:
```
m4+fpga_init()
```

#### 5.3 LED Module:
```
m4+fpga_led(*led)

// Arguments:
// *led - led signal
```
#### 5.4 Seven segment displays:
```
m4+fpga_sseg(*digit, *sseg, *dp)

// Arguments:
// *digit - common anode signal
// *sseg - seven segments
// *dp - decimal point
```
#### 5.5 LCD Module:
```
m4+fpga_lcd(*data, *lcd_e, *lcd_rs) 

// Arguments:
// *data - 8-bit data/command line
// *lcd_e - lcd enable signal
// *lcd_rs - lcd reset signal, 0 for command and 1 for data
```
#### 5.6 VGA display:
```
m4+fpga_vga(*vga_hsync, *vga_vsync, *vga_r, *vga_g, *vga_b, /top|vga_pipe$sx, /top|vga_pipe$sy)

// Arguments:
// *vga_hsync - horizontal sync
// *vga_vsync - vertical sync
// *vga_r - red signal
// *vga_g - green signal
// *vga_b - blue signal
// $sx - horizontal count
// $sy - vertical count
```
#### 5.7 Push buttons:
```
m4+fpga_push(*pb) 

// Arguments:
// *pb - push button signal
```
#### 5.8 Slideswitches:
```
m4+fpga_led(*sw)

// Arguments:
// *sw - switch signal
```
## 6. Examples:
[6.1 LED Module](https://makerchip.com/sandbox/0mZf5hLPG/0y8h64Z)


[6.2 Seven segment displays](https://makerchip.com/sandbox/0mZf5hLPG/0zmh8rV) 


[6.3 LCD Module](https://makerchip.com/sandbox/0mZf5hLPG/0k5hYwz) 


[6.4 VGA display](https://makerchip.com/sandbox/0mZf5hLPG/0nZhlW1)


[6.5 Temperature sensor](https://makerchip.com/sandbox/031fmhpnZ/0JZhpWr) 


[6.6 Light sensor](https://makerchip.com/sandbox/031fmhpnZ/0KOh8yJ)


[6.7 Push buttons](https://makerchip.com/sandbox/0mZf5hLPG/0pghQw2) 


[6.8 Slideswitches](https://makerchip.com/sandbox/05yf0h91P/066hVzy) 


[6.9 RGB LED](https://makerchip.com/sandbox/0mZf5hLPG/0vghOl6) 


[6.10 RISC-V MYTH Core](https://github.com/BalaDhinesh/Virtual-FPGA-Lab/blob/main/examples/riscv_myth_core.tlv) 



## 7. Visual Debug:
### 7.1 How Visual Debug is built?
Visual Debug is a __JavaScript__ canvas where we used [fabric.js](http://fabricjs.com/), which is a powerful and simple Javascript HTML5 canvas library framework. It provides us to use interactive object models on top of canvas element.
### 7.2 Examples 
#### 7.2.1 Visualizing logic gates
[Makerchip Sandbox](http://makerchip.com/sandbox/0mZf5hLDQ/0X6hB6q)

Let us first visualize the output of simple digital **logic gates**. From the GIF below, we can see that the left portion is the coding part where you can see the logic of the gates and right portion is the Visual Debug(VIZ) part where you can see the visualization of each logic gates. We can move back and forth between cycles and see in the top right which cycle currently is. Also, look at the waveform of the logic from the below image.

<img src="https://user-images.githubusercontent.com/64545984/130665737-2b249ce2-3aa7-4b3e-8b44-ca9e9e9ffa7f.gif" alt="logic gates" width="800">

[Code and explanation](https://github.com/BalaDhinesh/Virtual-FPGA-Lab/blob/main/examples/logic_gates.tlv)
#### 7.2.2 Visualizing LCD 16x2 display:

<img src="https://user-images.githubusercontent.com/64545984/130665759-9894f0de-c058-4075-a990-2dee094123b4.gif" alt="lcd" width="800">

This program prints the following in the LCD 16x2 display

__Line 1:__ FPGAs are fun!!!

__Line 2:__ --

And then left shift line1 and line2 once completed

__NOTE: This visualization supports only 8 bit data/command mode__
#### LCD Commands supported:
         - 8'h38 - Function Set: 8-bit, 2 Line, 5x7 Dots
         - 8'h30 - Function Set: 8-bit, 1 Line, 5x7 Dots
         - 8'h0C - Display on Cursor off
         - 8'h06 - Entry Mode: Increment, entire shift off
         - 8'h04 - Entry Mode: Decrement, entire shift off
         - 8'h01 - Clear display
         - 8'h02 - Return home
         - 8'h80 - force cursor to begin at first line
         - 8'hC0 - force cursor to begin at second line
         - 8'h18 - Shift entire display to the left
         - 8'h1C - Shift entire display to the right
         - 8'h10 - Shift cursor left 
         - 8'h14 - Shift cursor right
         
[Code and Explanation](https://github.com/BalaDhinesh/Virtual-FPGA-Lab/blob/main/examples/lcd_module/lcd_lib.tlv)


## 8. How to add own FPGA boards and peripherals
#### 8.1 Adding custom FPGA board:
```
// Macro definition for adding fpga board
\TLV fpga_init()
   |fpga_init_macro
      @0
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
#### 8.2 Interfacing LEDs:
```
\TLV fpga_led($_leds)
   |led_pipe_macro
      @0
        $led[\$size($_leds)-1:0] = $_leds;      // copying SystemVerilog/TL-Verilog to TL-Verilog signal
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

## 9. Steps to run in an actual FPGA:
Detailed step-by-step instructions are provided in this [link](https://github.com/BalaDhinesh/Virtual-FPGA-Lab/tree/main/fpga). Credit goes to [Mayank Kabra](https://www.linkedin.com/in/mayank-kabra-6993701ab/) for helping me build this part.

LED Demo: [Link](https://makerchip.com/sandbox/0mZf5hLPG/0y8h64Z#)

<h4> Output in Makerchip and actual FPGA board:</h3>

  <p float="left">

  <img src="https://user-images.githubusercontent.com/64545984/130665841-6e43f51a-6347-4262-9b3f-19e256127df4.gif" alt="led_makerchip" width="40%" />
  <img src="https://user-images.githubusercontent.com/64545984/130665845-18b89d49-a5dc-4308-bdf1-45119d93abef.gif" alt="led_artix" width="50%" /> 
</p>

## 10. Future Scope:
- To support more FPGA boards and peripherals.
- The automated shell script that converts TL-V code to run in an actual FPGA currently supports only Xilinx boards with Vivado software. So to provide scripts that target other vendors as well using open source tools.

## 11. Sponsors
This work has been sponsored through the OSFPGA Foundation and Google Summer of Code (GSoC) 2021(with the Free and Open Source Silicon Foundation (FOSSi) as a GSoC umbrella organization), with mentorship from Redwood EDA, LLC, and with training support from VLSI System Design.
<p>
    <img src="https://user-images.githubusercontent.com/64545984/152572571-1e10d2fa-acc6-4048-8d73-1be63267b778.png" alt="gsoc-logo" height="80"><span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
    <img src="https://upload.wikimedia.org/wikipedia/commons/0/08/GSoC_logo.svg" alt="gsoc-logo" height="80"><span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
    <img src="https://user-images.githubusercontent.com/11302288/130831451-1c3b1541-06f2-4c0e-bbaf-8e0026db00c1.png" alt="redwoodeda-logo" height="80"><span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
    <img src="https://www.fossi-foundation.org/assets/fossi_logo_large.png" alt="fossi-logo" height="80"><span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
    <img src="https://user-images.githubusercontent.com/11302288/133894333-14ff8014-4bbb-4573-90b9-bed24e509d6e.png" alt="vsd-logo" height="80">
</p>

## 12. Contributors:
- [Steve Hoover](https://github.com/stevehoover), Founder, Redwood EDA
- [Akos Hadnagy](https://github.com/ahadnagy), Advisor
- [Dylan McNamee](https://github.com/dylanmc), Advisor
- [Bala Dhinesh](https://github.com/BalaDhinesh), Contributing as a participant in Google Summer of Code 2021, under FOSSi Foundation
- [Shivani Shah](https://github.com/shivanishah269), Student at the International Institute of Information Technology, Bangalore
- [Mayank Kabra](https://github.com/mayank-kabra2001), Student at the International Institute of Information Technology, Bangalore

__Funding for this work is provided by the Open Source Silicon Foundation__

## 13. Contributing

Contributions are what make the open source community such an amazing place to be learn, inspire, and create. Any contributions you make are **greatly appreciated**.

## 14. License

Distributed under the MIT License. See `LICENSE` for more information.
## 15. Disclaimer
Though the algorithms developed has been tested against a large number of custom inputs, there are situations where it can fail. If you come across any such problem, please feel free to raise an issue here and we will try to address the issue as soon as possible.


