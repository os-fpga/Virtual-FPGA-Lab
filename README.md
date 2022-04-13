# Virtual FPGA Lab

  - **Develop FPGA logic in your browser!**
  - **Run on your own FPGA!**
  - **Share with others!**

<img src="https://user-images.githubusercontent.com/64545984/130665759-9894f0de-c058-4075-a990-2dee094123b4.gif" alt="lcd" width="800">


## References

This document introduces the Virtual FPGA Lab. Separate documents will help you with:

  - [FPGA training using this platform](https://github.com/stevehoover/GettingStartedWithFPGAs)
  - [Exporting to your FPGA board (if supported)](fpga/readme.md)


## Contents

[Overview](#overview)

[About Makerchip](about-makerchip)

[What makes the project __Virtual FPGA Lab__ special?](what-makes-the-project-virtual-fpga-lab-special)

[FPGA Boards demonstrated](fpga-boards-demonstrated)

[FPGA peripheral macro instantiations](fpga-peripheral-macro-instantiations)
- [Board Select](board-select)
- [LED Module](led-module)
- [Seven segment displays](seven-segment-displays)
- [LCD Module](lcd-module)
- [VGA display](vga-display)
- [Push buttons](push-buttons)
- [Slideswitches](slideswitches)

[Examples](examples)

[Visual Debug](visual-debug)
- [How Visual Debug is built?](how-visual-debug-is-built)
- [Examples](examples)
    - [Visualizing logic gates](visualizing-logic-gates)
    - [Visualizing LCD 16x2 display](visualizing-lcd-16x2-display)

[How to add own FPGA boards and peripherals](how-to-add-own-fpga-boards-and-peripherals)
- [Adding custom FPGA board](adding-custom-fpga-board)
- [Interfacing LEDs](interfacing-leds)

[Steps to run in an actual FPGA](steps-to-run-in-an-actual-fpga)

[Future Scope](future-scope)

[Contributors](contributors)

[Contributing](contributing)

[License](license)



## What are FPGAs?

New to FPGAs? Field-programmable gate arrays (FPGAs) are a hardware circuits that can be programmed to carry out logical operations. They provide a sweet spot between implementing algorithms in software and fabricating application-specific integrated circuits (ASICs). They generally provide far better performance and power-efficiency than software implementations, and they require far less time and expense to implement than ASICs. They can be reprogrammed as needed to upgrade functionality or fix bugs, even after deployment to customers (in the "field"). FPGAs are also beneficial for prototyping application-specific integrated circuits (ASICs) or processors.


## Virtual Lab Overview

Though far more accessible than ASICs, FPGAs can still be a bit costly and difficult to learn for beginners and students. That's where this project comes in... and it's not just for beginners.

This project builds on all the power and ease-of-use of [Makerchip IDE](http://makerchip.com/) and adds convenience for FPGA development. In particular, we take advantage of Makerchip's [__Visual Debug__ feature](https://redwoodeda.com/viz) to provide visualizations of FPGAs and their peripherals, thereby mimicking the physical lab experience. But better than the physical experience, you also have the benefits of simulation-based development: fast compilation (no synthesis, place-and-route, and bitstreams), full visibility of all signal values, and full control of time.

Makerchip further simplifies the experience with support for [TL-Verilog](http://tl-x.org/) in addition to Verilog/SystemVerilog. TL-Verilog features are more approachable to newcomers (not to mention the myriad benefits for experts).

In summary:

  - __Easy learning:__ Online; no board/peripherals required (but supported); simplified by TL-Verilog and Makerchip.
  - __Powerful for experts:__ (for open-source development) The virtual lab augments vendor tools with the benefits of Makerchip development and virtual FPGA board/peripheral integration.
  - __Vendor-agnostic:__ You're designs work on any FPGA boards with compatible peripherals. (Though currently-supported boards are all Xilinx-based.)
  - __Exportable:__ Code in Virtual Lab works on real FPGAs!!!
  - __Open Source:__ MIT-licensed.


## Supported FPGA Boards

1. Zedboard Zynq-7000 ARM/FPGA SoC Development Board ([Product Link](https://www.avnet.com/wps/portal/us/products/avnet-boards/avnet-board-families/zedboard/))
2. EDGE Artix 7 FPGA Development Board ([Product Link](https://allaboutfpga.com/product/edge-artix-7-fpga-development-board/))
3. Basys 3 Artix-7 FPGA Trainer Board ([Product Link](https://store.digilentinc.com/basys-3-artix-7-fpga-beginner-board-recommended-for-introductory-users/)) 
4. Icebreaker FPGA ([Product Link](https://1bitsquared.com/products/icebreaker))
5. Nexys A7 ([Product Link](https://store.digilentinc.com/nexys-a7-fpga-trainer-board-recommended-for-ece-curriculum/))
6. CLEAR ([Article](https://www.hackster.io/news/efabless-clear-is-a-fully-open-source-asic-with-embedded-fpga-and-risc-v-core-now-on-groupgets-8ed72c5cff6a)) (no physical FPGA flow)

Currently we demonstrate using only these boards and we plan to add more boards in the future. You can very easily [add your own FPGA boards](fpga/readme.md). Contributions are welcome.


## Development Flow

Just click [here](http://www.makerchip.com/sandbox?code_url=https:%2F%2Fraw.githubusercontent.com%2FBalaDhinesh%2FVirtual-FPGA-Lab%2Fmain%2Fexamples%2Ffpga_lab.tlv), and go! _(Right-click to open in a new tab.)_ Instructions below will guide you.

You can also start from any of the [example project](#examples) here.

Alternately, especially for local FPGA use, you can use [Makerchip-app](https://pypi.org/project/makerchip-app/) to edit files on your local machine (where you can maintain your git repository and run FPGA flows).

Once you have some logic running in simulation, you'll be able to export your design to any supported physical FPGA board using these [instructions](fpga/readme.md).


## Starting Template

```
\m4_TLV_version 1d: tl-x.org
\SV
   m4_include_lib(['https://raw.githubusercontent.com/BalaDhinesh/Virtual-FPGA-Lab/main/tlv_lib/fpga_includes.tlv'])
   
   m4_lab()

   // ... SystemVerilog or TL-Verilog FPGA logic goes here ...
   
\TLV
   /board
      // Board selection:
      // 0: M4_FIRST_CLAAS_ID
      // 1: M4_ZEDBOARD_ID
      // 2: M4_ARTIX7_ID
      // 3: M4_BASYS3_ID
      // 4: M4_ICEBREAKER_ID
      // 5: M4_NEXYS_ID
      // 6: M4_CLEAR_ID
      m4+board(/board, /fpga, 3, *)   // 3rd arg selects the board.
\SV

   endmodule

```

The `m4+board(...)` macro (and peripheral macros, such as `m4+lcd(...)`, define the hardware).

`m4_lab()` provides a superset of signals for I/Os. Those that have corresponding components on the board or peripherals should be driven/used. These include:

```
logic [15:0] led;             // corresponding LEDs are lit when asserted
logic [6:0] sseg_segment_n;   // corresponding segments are lit for selected digit(s) when deasserted 

logic sseg_decimal_point_n;   // decimal point is lit for selected digit(s) when deasserted
logic [7:0] sseg_digit_n;     // corresponding digits are enabled when deasserted

```

You can see these signal declarations in the one-line expansion of the `m4_lab()` macro instantiation in the NAV-TLV tab.


## Configuring and Driving the FPGA Board and Peripherals

#### Board

In the starting template, the 3rd argument below can be used to select the board:

```
// Board selection:
// 0 - 1st CLaaS on AWS F1
// 1 - Zedboard
// 2 - Artix-7
// 3 - Basys3
// 4 - Icebreaker
// 5 - Nexys
// 6 - CLEAR
m4+board(/board, /fpga, 3, *)   // 3rd arg selects the board.
```

Boards contain a subset of the following components, 

### Virtual FPGA Lab builtin peripheral modules

#### LED Module

```
// Internal to FPGA - no need to instantiate
// Signals:
// *led - led signal
```

#### Seven segment displays

```
// Internal to FPGA - no need to instantiate
// Signals:
// *sseg_digit_n - common anode signal
// *sseg_segment_n - seven segments
// *sseg_decimal_point_n - decimal point
```
#### Push buttons

```
// Internal to FPGA - no need to instantiate
// Signals:
// *push - push button signal
```

#### Slideswitches

```
// Internal to FPGA - no need to instantiate
// Signals:
// *slideswitch - switch signal
```



#### LCD Module

```
// External to FPGA - instantiated using
m4+fpga_lcd() 

// Signals:
// *out - 8-bit data/command line
// *lcd_enable - lcd enable signal
// *lcd_reset - lcd reset signal, 0 for command and 1 for data
```

#### VGA display

```
// External to FPGA - instantiated using
m4+fpga_vga()

// Signals:
// *vga_hsync - horizontal sync
// *vga_vsync - vertical sync
// *vga_r - red signal
// *vga_g - green signal
// *vga_b - blue signal
```
External and other peripherals can be instantiated uisng `m4+` macros.




## Examples

Here are some example you can load in Makerchip. You'll find the source code in this repository under [examples](examples). (Right-click links to open in a new tab.)

[LED Module](http://www.makerchip.com/sandbox?code_url=https:%2F%2Fraw.githubusercontent.com%2FBalaDhinesh%2FVirtual-FPGA-Lab%2Fmain%2Fexamples%2Fled_counter.tlv)

[Seven segment displays](http://www.makerchip.com/sandbox?code_url=https:%2F%2Fraw.githubusercontent.com%2FBalaDhinesh%2FVirtual-FPGA-Lab%2Fmain%2Fexamples%2Fseven_segment_counter.tlv)

[LCD Module](http://www.makerchip.com/sandbox?code_url=https:%2F%2Fraw.githubusercontent.com%2FBalaDhinesh%2FVirtual-FPGA-Lab%2Fmain%2Fexamples%2Flcd_module.tlv)

[VGA display](http://www.makerchip.com/sandbox?code_url=https:%2F%2Fraw.githubusercontent.com%2FBalaDhinesh%2FVirtual-FPGA-Lab%2Fmain%2Fexamples%2Fvga_display.tlv)

[Temperature sensor](http://www.makerchip.com/sandbox?code_url=https:%2F%2Fraw.githubusercontent.com%2FBalaDhinesh%2FVirtual-FPGA-Lab%2Fmain%2Fexamples%2Ftemperature_sensor.tlv)

[Light sensor](http://www.makerchip.com/sandbox?code_url=https:%2F%2Fraw.githubusercontent.com%2FBalaDhinesh%2FVirtual-FPGA-Lab%2Fmain%2Fexamples%2Flight_sensor.tlv)

[Push buttons](http://www.makerchip.com/sandbox?code_url=https:%2F%2Fraw.githubusercontent.com%2FBalaDhinesh%2FVirtual-FPGA-Lab%2Fmain%2Fexamples%2Fpushbutton.tlv)

[Slideswitches](http://www.makerchip.com/sandbox?code_url=https:%2F%2Fraw.githubusercontent.com%2FBalaDhinesh%2FVirtual-FPGA-Lab%2Fmain%2Fexamples%2Fslideswitch.tlv)

[RGB LED](http://www.makerchip.com/sandbox?code_url=https:%2F%2Fraw.githubusercontent.com%2FBalaDhinesh%2FVirtual-FPGA-Lab%2Fmain%2Fexamples%2Fice_rgb.tlv)

[RISC-V MYTH Core](http://www.makerchip.com/sandbox?code_url=https:%2F%2Fraw.githubusercontent.com%2FBalaDhinesh%2FVirtual-FPGA-Lab%2Fmain%2Fexamples%2Friscv_myth_core.tlv)


## How to Add FPGA Boards and Peripherals

Board definitions appear at the top of the `fpga_includes.tlv` file. It should be easy
enough to interpret these parameters and add new boards by example. Be sure also to update all listings of available boards (which you can find using `git grep -i zedboard`).

The above steps update the virtual environment only. The physical FPGA build flow is a different matter and is platform-dependent, though open-source platform-agnostic build flows are available, and we'd love to use them.

We welcome your contributions.


## Visual Debug:

Makerchip's Visual Debug feature is used to create the Virtual FPGA Lab.

You can also use Visual Deubg to visualize the logic running inside the FPGA.

<img src="https://user-images.githubusercontent.com/11302288/149048729-dd462221-6bd9-44b4-a2be-c61409234316.jpg">

### Visualizing your FPGA logic

By structuring your code to define your FPGA logic in TL-Verilog (which does not preclude using pure Verilog/SystemVerilog), you can add visualization to your logic.

Here's a sample code structure.

```
...
\SV
   m4_lab()

\TLV my_fpga_logic(/_fpga)
   // ... Your TL-Verilog FPGA logic along with it's visualization ...

\TLV
   /board
      m4+board(/board, /fpga, 3, *, , my_fpga_logic)
...
```

Visual Debug documentation and examples can be found within the Makerchip IDE.


## Steps to run in an actual FPGA

Detailed step-by-step instructions are provided in this [link](fpga/readme.md). Credit goes to [Mayank Kabra](https://www.linkedin.com/in/mayank-kabra-6993701ab/) for helping me build this part.

LED Demo: [Link](https://makerchip.com/sandbox/0mZf5hLPG/0y8h64Z#)

<h4> Output in Makerchip and actual FPGA board:</h3>

  <p float="left">

  <img src="https://user-images.githubusercontent.com/64545984/130665841-6e43f51a-6347-4262-9b3f-19e256127df4.gif" alt="led_makerchip" width="40%" />
  <img src="https://user-images.githubusercontent.com/64545984/130665845-18b89d49-a5dc-4308-bdf1-45119d93abef.gif" alt="led_artix" width="50%" /> 
</p>


## Future Scope

- To support more FPGA boards and peripherals.
- The automated shell script that converts TL-V code to run in an actual FPGA currently supports only Xilinx boards with Vivado software. So to provide scripts that target other vendors as well using open source tools. It would probably be wise to use EDAlize.


## Links

### A Blog Post on this Virtual FPGA Lab

[Blog post](https://medium.com/@m.baladhinesh/fpgas-in-your-browser-bb92be1c1fa3)

### Similar Environments

In our efforts, we've come across the following related projects. (Appearance on this list is not an endorsement, just a recognition that we are not alone.) Give us a pull request with any others.

  - [FPGA View](https://www.linkedin.com/posts/martin-fink-23561890_fpgas-engineeringtech-activity-6849438567710691328-JPx_) A tracefile-driven virtual FPGA lab with touch UI for iPad initially, by [Martin Fink](https://www.linkedin.com/in/martin-fink-23561890/)
  - A [remote virtual FPGA lab environment](https://www.linkedin.com/posts/alexmagyari_fpga-remote-laboratory-using-iot-approaches-activity-6842591085324316672-RB9x/) providing multi-user access to each FPGA, by [Alexander Magyari](https://www.linkedin.com/in/alexmagyari/).
  - [Web FPGA](https://beta.webfpga.io/dashboard) A crowd-funded project to provide browser access to a local FPGA via WebUSB. Very cool, though it seems browsers have been removing support for WebUSB for security reasons.
  - [Labs Land](https://labsland.com/en/labs/fpga-llstd1) A commercial option for virtualized labs.


## Sponsors
This work has been sponsored through the OSFPGA Foundation and Google Summer of Code (GSoC) 2021(with the Free and Open Source Silicon Foundation (FOSSi) as a GSoC umbrella organization), with mentorship from Redwood EDA, LLC, and with training support from VLSI System Design.
<p>
    <img src="https://user-images.githubusercontent.com/64545984/152572571-1e10d2fa-acc6-4048-8d73-1be63267b778.png" alt="gsoc-logo" height="80"><span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
    <img src="https://upload.wikimedia.org/wikipedia/commons/0/08/GSoC_logo.svg" alt="gsoc-logo" height="80"><span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
    <img src="https://user-images.githubusercontent.com/11302288/130831451-1c3b1541-06f2-4c0e-bbaf-8e0026db00c1.png" alt="redwoodeda-logo" height="80"><span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
    <img src="https://www.fossi-foundation.org/assets/fossi_logo_large.png" alt="fossi-logo" height="80"><span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
    <img src="https://user-images.githubusercontent.com/11302288/133894333-14ff8014-4bbb-4573-90b9-bed24e509d6e.png" alt="vsd-logo" height="80">
</p>


## Contributors

- [Akos Hadnagy](https://github.com/ahadnagy), Primary Mentor
- [Steve Hoover](https://github.com/stevehoover), Mentor; Founder & CEO, Redwood EDA, LLC
- [Dylan McNamee](https://github.com/dylanmc), Advisor
- [Bala Dhinesh](https://github.com/BalaDhinesh), Contributing as a participant in Google Summer of Code 2021.
- [Shivani Shah](https://github.com/shivanishah269), Student at the International Institute of Information Technology, Bangalore
- [Mayank Kabra](https://github.com/mayank-kabra2001), Student at the International Institute of Information Technology, Bangalore


## Contributing

Contributions are what make the open source community such an amazing vehicle to learn, inspire, and create. Any contributions you make are **greatly appreciated**. Kudos for filing bugs. Deepest thanks for fixing them and for contributing new features and support for new boards.


## License

Distributed under the MIT License. See [LICENSE.md](LICENSE.md).


