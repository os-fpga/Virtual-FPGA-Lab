# FPGA flow 

## Installtion and Overview of Sandpiper
* [SandPiper](https://www.redwoodeda.com/products) is a code generator that generates readable, well-structured, Verilog or SystemVerilog\  code from the given TL-Verilog code.
* [SandPiper SaaS Edition](https://pypi.org/project/sandpiper-saas/) runs as a microservice in the cloud to support easy open-source development. Install Sanpiper SaaS Edition for this project. 
* To run locally, SandPiper Education Edition can be requested from [RedwoodEDA](https://www.redwoodeda.com/products)

## Steps to run FPGA setup
1. `git clone https://github.com/BalaDhinesh/Virtual-FPGA-Lab.git`
2.  From your working directory run the shell script `/<complete_path>/run.sh`.

      ![image](https://user-images.githubusercontent.com/15063738/125673954-680bffd0-94a3-484a-ad28-e2611f74c44f.png)

  
3.  Three inputs will be asked by shell script

    a. Input file name of TL-Verilog file
 
       ![image](https://user-images.githubusercontent.com/15063738/125674121-a9217314-dfd8-4980-b068-73c670678938.png)

    b. Board name (If board is not from given options then provide part number of board)
    
      If board is from given options:
    
       ![image](https://user-images.githubusercontent.com/15063738/125674297-52e8536d-b2f0-4b13-842e-92e6050e5e00.png)
       
      If board is not from given options:
     
       ![image](https://user-images.githubusercontent.com/15063738/125675066-9f5e92cb-9067-4685-b66d-a6625bf4366a.png)

          
    c. (Optional) If board is not from given options then constraints file should be present in your working directory as `<filename_partno>.xdc`.

       For example: From above iamge it should be `design_xc7a100tcsg324-1.xdc`
    
    d. Clock period (in ns)
      
       ![image](https://user-images.githubusercontent.com/15063738/125674515-9b3ac294-176a-4c50-a4a8-aebd6cb974b2.png)

