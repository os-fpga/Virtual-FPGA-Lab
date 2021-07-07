# VIRTUAL_FPGA_LAB_WORKSHOP

## About the Workshop:
__Course: “Getting Started with FPGAs”,__
a one-hour primer to get you off the ground developing your first FPGA logic. Several low-cost FPGA boards are supported. This course uses a virtual FPGA lab within the Makerchip online IDE.

Within Makerchip, you’ll use Verilog or the latest Transaction-Level Verilog to build and simulate a counter circuit and show the count on the virtual 7-segment display. Then, if you have a supported FPGA board, such as Basys 3 or iCEBreaker (+ 7-segment display), you’ll be able to run your design on your own FPGA. From there, the sky’s the limit.

## Makerchip and TL-Verilog:
[Makerchip](https://www.makerchip.com/) is a free online environment for developing high-quality integrated circuits. You can code, compile, simulate, and debug Verilog designs, all from your browser. Your code, block diagrams, and waveforms are tightly integrated. [Makerchip](https://www.makerchip.com/) supports the emerging Transaction-Level Verilog standard. [Transaction-Level Verilog](http://tl-x.org/), or [TL-Verilog](http://tl-x.org/), represents a huge step forward, by eliminating the need for the legacy language features of Verilog and by introducing simpler syntax. At the same time, TL-Verilog adds powerful constructs for pipelines and transactions. More details about TL-Verilog: [https://www.redwoodeda.com/tl-verilog](https://www.redwoodeda.com/tl-verilog)

## Features of Virtual FPGA Lab:
- Move back and forth between cycles so that we can visualize what's happening in each and every cycle.
- Faster to see the output for simple designs. No need to wait for Synthesis, Implementation and Bitstream Generation.
### Supported FPGA Boards:
1. Basys 3 Artix-7 FPGA Trainer Board ([Product Link](https://store.digilentinc.com/basys-3-artix-7-fpga-beginner-board-recommended-for-introductory-users/)) 
3. EDGE Artix 7 FPGA Development Board ([Product Link](https://allaboutfpga.com/product/edge-artix-7-fpga-development-board/))
4. Zedboard Zynq-7000 ARM/FPGA SoC Development Board ([Product Link](https://www.avnet.com/wps/portal/us/products/avnet-boards/avnet-board-families/zedboard/))

## Demos:
### 1. LED:
__Counter Demo:__  [http://makerchip.com/sandbox/0jRfjhMkx/0DRhjj0](http://makerchip.com/sandbox/0jRfjhMkx/0DRhjj0)

__Output on Virtual Basys3 board:__ 

![Basys3_LED](https://user-images.githubusercontent.com/15063738/124799122-d4d59e00-df71-11eb-94c8-ed500c5f8945.gif)

__Output on Virtual Edge Artix7 board:__ 

![EDGE_Artix7_LED](https://user-images.githubusercontent.com/15063738/124793980-27ac5700-df6c-11eb-81ea-5728abba6777.gif)

__Output on Virtual ZedBoard:__

![Zedboard_LED](https://user-images.githubusercontent.com/15063738/124794052-3c88ea80-df6c-11eb-9da2-1e250868b6de.gif)


### 2. Seven Segment Display:
__Counter Demo:__  [http://makerchip.com/sandbox/0jRfjhMkx/0Elh119](http://makerchip.com/sandbox/0jRfjhMkx/0Elh119)

__Output on Virtual Basys3 board:__

![Basys3_7seg](https://user-images.githubusercontent.com/15063738/124794130-532f4180-df6c-11eb-8541-0f83f9ec47c6.gif)

__Output on Virtual Edge Artix7 board:__

![EDGE_Artix7_7seg](https://user-images.githubusercontent.com/15063738/124794148-57f3f580-df6c-11eb-8dca-5805e6d32887.gif)


## Run on FPGA:
