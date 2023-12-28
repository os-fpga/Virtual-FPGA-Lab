# FPGA flow 

## Installation and Overview of SandPiper

* [SandPiper](https://www.redwoodeda.com/products) is a code generator that generates readable, well-structured, Verilog or SystemVerilog\ code from the given TL-Verilog code.
* [SandPiper SaaS Edition](https://pypi.org/project/sandpiper-saas/) runs as a microservice in the cloud to support easy open-source development. Install Sanpiper SaaS Edition for this project. 
* To run locally, SandPiper Education Edition can be requested from [RedwoodEDA](https://www.redwoodeda.com/products)

## Steps to run FPGA setup

1. `git clone https://github.com/os-fpga/Virtual-FPGA-Lab.git`
2.  From your working directory run the shell script `/<complete_path>/run.sh`.
      ![image](https://user-images.githubusercontent.com/64545984/130664456-5d59afb5-aeb0-47bd-bdd7-83820f687a47.png)

  
3.  Three inputs will be asked by shell script

    a. Input file name of TL-Verilog file
 
       ![image](https://user-images.githubusercontent.com/64545984/130664463-61eba65b-8c0b-4857-a678-226c5dcb042e.png)

    b. Board name (if board is not from given options then provide part number of board)
    
      If board is from given options:
    
       ![image](https://user-images.githubusercontent.com/64545984/130664477-e031938b-1b79-4315-b2b5-59c873640426.png)
       
      If board is not from given options:
     
       ![image](https://user-images.githubusercontent.com/64545984/130664484-bf7d2dab-aa31-4d60-87b9-46dee69eaf8e.png)

          
    c. (Optional) If board is not from given options then constraints file should be present in your working directory as `<filename_partno>.xdc`.

       For example: From above iamge it should be `design_xc7a100tcsg324-1.xdc`
    
    d. Clock period (in ns)
      
       ![image](https://user-images.githubusercontent.com/64545984/130664493-a20d0d64-a5b2-4a70-9b05-50b559c1484b.png)

