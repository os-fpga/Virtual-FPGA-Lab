\m4_TLV_version 1d -p verilog --bestsv --noline: tl-x.org
   
m4_define(['M4_SCALE'], 10)
\SV
   // This code can be found in: https://github.com/stevehoover/RISC-V_MYTH_Workshop
   
   m4_include_lib(['https://raw.githubusercontent.com/mayank-kabra2001/fpga_lab/main/riscv-shell.tlv'])

\SV
   m4_ifelse_block(M4_MAKERCHIP, 1, ['
    m4_makerchip_module   // Compile within Makerchip to see expanded module definition.                          
   '], ['
    module top(input clk, input reset, input [14:0] sw, output reg [6:0] sseg, output reg [3:0] digit, output reg led); 
	'])

       
\TLV counter($_var, #_delay)
   m4_ifelse_block(M4_MAKERCHIP, 1, ['
   $_var = 1;
   '], ['
   $count[26:0] = /top|cpu<>0$reset ? 1'b0 : ($RETAIN >= #_delay) ? 1'b0 : >>1$count + 1 ; 
   $counter = ($count == #_delay) ? 1'b1 : 1'b0 ;
   $_var = $counter;
   '])                   
   

//#####################################################################################
       //   FPGA  //
//#####################################################################################
       
\TLV segment_viz(@_stage)
   |fpga_viz 
      @_stage
         /fpga_img
            \viz_alpha
               initEach() {
                           let block_square = new fabric.Rect(
                              {originX: "center",
                               originY: "center",
                               width: 490,
                               height: 300
                              }
                           )
                           let logic_block = new fabric.Group([block_square],
                           {originX: "center",
                            originY: "center",
                            angle: 0,
                            width: 20,
                            height: 20
                           })
                           //let fpga_img_url = "https://raw.githubusercontent.com/mayank-kabra2001/images/main/basys3.jpg"
                           let fpga_img_url = "https://raw.githubusercontent.com/mayank-kabra2001/images/main/15650254130_919249aa0f_o.jpg"
                           //let fpga_img_url = "https://raw.githubusercontent.com/BalaDhinesh/Shaastra-FPGA-Workshop/main/Wack_mole_game/NEXYS_A7.jpg"
                           let fpga_img = new fabric.Image.fromURL(
                                 fpga_img_url,
                                 function (img) {
                                    logic_block.add(img)
                                    global.canvas.renderAll()
                                 },
                                 {originX: "center",
                                  originY: "center",
                                  left: 0,
                                  top: 0,
                                  scaleX: 0.25,
                                  scaleY: 0.25,
                                  angle: 0
                                 }
                              )
                            let start_led = new fabric.Rect({
                                 top: -108,
                                 left: -195, 
                                 width: 5, 
                                 height: 8, 
                                 fill: "red",
                                 opacity: 1
                              })
                            let rec = new fabric.Rect({
                                 top: -36,
                                 left: -20, 
                                 width: 39, 
                                 height: 37, 
                                 fill: "white",
                                 stroke: "black",
                                 opacity: 1
                              })
                              return {objects : {logic_block,start_led,rec}}; 
                         },
         $ANY = /top|fpga<>0$ANY;                
         //$enable[3:0] = {$pin_U2,$pin_U4,$pin_V4,$pin_W4} ;
         $enable[3:0] = {$pin_W4,$pin_V4,$pin_U4,$pin_U2} ;
         $sevenseg[7:0] = {$pin_W7,$pin_W6,$pin_U8,$pin_V8,$pin_U5,$pin_V5,$pin_U7};
         
         /digit[3:0]
            /led[6:0]
               \viz_alpha
                  initEach() {
                  // 0 25:-155, 1 25:-142
                     // var mod = ('/top/des_pipe/const_level$digit'.asBinaryStr());
                     let sseg = new fabric.Rect({
                           top: 26 + ((scopes.led.index == 5) ? 1 : (scopes.led.index == 4) ? 13 : (scopes.led.index == 3) ? 23 : (scopes.led.index == 2) ? 13 : (scopes.led.index == 1) ? 1 : (scopes.led.index == 0) ? 11 : 0),
                           left: ((scopes.digit.index == 0) ? -154 : (scopes.digit.index == 1) ? -124 : (scopes.digit.index == 2) ? -94 : -64) + ((scopes.led.index == 5) ? 10 : (scopes.led.index == 4) ? 8 : (scopes.led.index == 3) ? -2 : (scopes.led.index == 2) ? -6 : (scopes.led.index == 1) ? -4 : 0),
                           width: 0,
                           height: 0,
                           fill: "red",
                           skewX: ((this.getIndex() == 5) || (this.getIndex() == 4) || (this.getIndex() == 2) || (this.getIndex() == 1)) ? -9 : 0,
                           opacity: 0
                        })
                     /*let fp = new fabric.Circle({
                           top: 49,
                           left: (scopes.digit.index == 0) ? -142 : (scopes.digit.index == 1) ? -112 : (scopes.digit.index == 2) ? -82 : -52 ,
                           radius: 0,
                           opacity: 0,
                           fill: "red"
                        })
                     let done_led = new fabric.Rect({
                           top: -108,
                           left: 191,
                           width: 5,
                           height: 8,
                           fill: "green",
                           opacity: 1
                        }) */
                     return{objects : {sseg  /*, fp , done_led*/}};
                  },
                  //0001100
                  renderEach() {
                     var mod = ('/top|fpga_viz<>0$enable'.asBinaryStr());
                     console.log(mod) ; 
                     this.getInitObject("sseg").set("width" , mod[scopes.digit.index] == 1 ? 0 : ((this.getIndex() == 6) || (this.getIndex() == 3) || (this.getIndex() == 0)) ? 11 : 3);
                     this.getInitObject("sseg").set("height" , mod[scopes.digit.index] == 1 ? 0 : ((this.getIndex() == 5) || (this.getIndex() == 4) || (this.getIndex() == 2) || (this.getIndex() == 1)) ? 11 : 3);
                     //this.getInitObject("fp").set("radius" , mod[scopes.digit.index] == 0 ? 0 : 2);
                     var mod1 = ((('/top|fpga_viz<>0$enable'.asInt(-1) >> scopes.digit.index) & 1) == 0);
                     var mod2 = ((('/top|fpga_viz<>0$sevenseg'.asInt(-1) >> scopes.led.index) & 1) == 0);
                     //var mod2 = (fp == 0)
                     console.log("mod =", (mod1 == 1 && mod2 == 1)) ;  
                     //console.log("mod1 =", mod1) ; 
                     this.getInitObject("sseg").set(mod2 == 1 ? {opacity: 1} : {opacity: 0});
                     //this.getInitObject("fp").set(mod2 ? {opacity: 1} : {opacity: 0});
                 }    
   
   
\TLV fpga_seg(@_stage, $_final_reg)
   |fpga
      @_stage
         m4+counter($refresh, 250000 - 1) 
         
         $led_activating_counter[2:0] = /top|cpu<>0$reset ? 0 : ($RETAIN >=4) ? 0 : ($_final_reg == 0) ? 0 : $refresh ? >>1$led_activating_counter+1 : $RETAIN; // 2.5ms 
         // REMEMBER - SAME APPLIES HERE . 
         
         $digit[3:0] =  /top|cpu<>0$reset ? 0 : 
                                 ($led_activating_counter == 0) ? 4'b1110 :  // led 1 activates 
                                 ($led_activating_counter == 1) ? 4'b1101 : // led 2 activates
                                 ($led_activating_counter == 2) ? 4'b1011 : // led 3 activates 
                                 ($led_activating_counter == 3) ? 4'b0111 : 4'b1111 ; // led 4 activates 
                                 
         $led_bcd[3:0] = ($led_activating_counter == 0) ? ((($_final_reg % 1000) % 100) % 10)  : // 1st digit in 16-bit no.
                         ($led_activating_counter == 1) ?  (($_final_reg % 1000) % 100) / 10:  // 2nd digit in 16-bit no. 
                         ($led_activating_counter == 2) ?  ($_final_reg % 1000) / 100 :   // 3rd digit in 16-bit no.
                         ($led_activating_counter == 3) ? $_final_reg / 1000 : 4'b0;   // 4th digit in 16-bit no.
                         
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
                         
         m4_ifelse_block(M4_MAKERCHIP, 1, ['
         *passed = *cyc_cnt > 500;
         *failed = 1'b0;
         '], ['
         \SV_plus 
            always @(posedge clk) begin 
               *sseg = $sseg; 
               *digit = $digit;
            end 
         '])
         
          
   m4_ifelse_block(M4_MAKERCHIP, 1, ['
   m4+constraints(@_stage)
   m4+segment_viz(@_stage)
   '], [''])

\TLV silent() 
   `BOGUS_USE($pin_W7)
   `BOGUS_USE($pin_W6)
   `BOGUS_USE($pin_U8)
   `BOGUS_USE($pin_V8)
   `BOGUS_USE($pin_U5)
   `BOGUS_USE($pin_V5)
   `BOGUS_USE($pin_U7)
   `BOGUS_USE($pin_U2)
   `BOGUS_USE($pin_U4)
   `BOGUS_USE($pin_V4)
   `BOGUS_USE($pin_W4)
      
      
\TLV constraints(@_stage)  
   |fpga 
      @_stage
         $pin_W7 = $sseg[6] ; 
         $pin_W6 = $sseg[5] ; 
         $pin_U8 = $sseg[4] ; 
         $pin_V8 = $sseg[3] ; 
         $pin_U5 = $sseg[2] ; 
         $pin_V5 = $sseg[1] ; 
         $pin_U7 = $sseg[0] ; 
         $pin_U2 = $digit[0] ; 
         $pin_U4 = $digit[1] ; 
         $pin_V4 = $digit[2] ; 
         $pin_W4 = $digit[3] ; 
         m4+silent()
   

//#####################################################################################
       //   CPU RISCV CORE //
//#####################################################################################        

\TLV cpu_viz(@_stage)
   m4_ifelse_block(m4_sp_graph_dangerous, 1, [''], ['
   |cpu
      // for pulling default viz signals into CPU
      // and then back into viz
      @0
         $ANY = /top|cpuviz/defaults<>0$ANY;
         `BOGUS_USE($dummy)
         /xreg[31:0]
            $ANY = /top|cpuviz/defaults/xreg<>0$ANY;
         /dmem[15:0]
            $ANY = /top|cpuviz/defaults/dmem<>0$ANY;
   // String representations of the instructions for debug.
   \SV_plus
      logic [40*8-1:0] instr_strs [0:M4_NUM_INSTRS];
      assign instr_strs = '{m4_asm_mem_expr "END                                     "};
   |cpuviz
      @1
         /imem[m4_eval(M4_NUM_INSTRS-1):0]  // TODO: Cleanly report non-integer ranges.
            $instr[31:0] = /top|cpu/imem<>0$instr;
            $instr_str[40*8-1:0] = *instr_strs[imem];
            \viz_alpha
               initEach: function(){
                  /*let instr = new fabric.Text("", {
                     top: 70,
                     left: 90,
                     fill: "black",
                     fontSize: 14,
                     fontFamily: "monospace"
                  })
                  let transObj = new fabric.Group(
                     [
                        instr
                     ],
                     {originX: "center",
                      originY: "center",
                      left: 0,
                      top: 0,
                      scaleX: 0.25,
                      scaleY: 0.25,
                      angle: 0,
                      width: 200,
                      height: 500
                  })
                  return{objects: {transObj}} ;*/
               },
               renderEach: function() {
                  // Instruction memory is constant, so just create it once.
                 /* let instr_str = '$instr_str'.asString() + ": " + '$instr'.asBinaryStr(NaN);
                  this.getInitObjects.transObj[0].setText(instr_str);*/
                  if (!global.instr_mem_drawn) {
                     global.instr_mem_drawn = [];
                  }
                  if (!global.instr_mem_drawn[this.getIndex()]) {
                     global.instr_mem_drawn[this.getIndex()] = true;
                     let instr_str = '$instr_str'.asString() + ": " + '$instr'.asBinaryStr(NaN);
                     this.getCanvas().add(new fabric.Text(instr_str, {
                        top: -30 + 0.5 * this.getIndex(),  // TODO: Add support for '#instr_mem'.
                        left: -18,
                        fontSize: 14,
                        scaleX: 0.02,
                        scaleY: 0.02,
                        fontFamily: "monospace"
                     }));
                  }
               }
               
      @0
         /defaults
            {$is_lui, $is_auipc, $is_jal, $is_jalr, $is_beq, $is_bne, $is_blt, $is_bge, $is_bltu, $is_bgeu, $is_lb, $is_lh, $is_lw, $is_lbu, $is_lhu, $is_sb, $is_sh, $is_sw} = '0;
            {$is_addi, $is_slti, $is_sltiu, $is_xori, $is_ori, $is_andi, $is_slli, $is_srli, $is_srai, $is_add, $is_sub, $is_sll, $is_slt, $is_sltu, $is_xor} = '0;
            {$is_srl, $is_sra, $is_or, $is_and, $is_csrrw, $is_csrrs, $is_csrrc, $is_csrrwi, $is_csrrsi, $is_csrrci} = '0;
            {$is_load, $is_store} = '0;

            $valid               = 1'b1;
            $rd[4:0]             = 5'b0;
            $rs1[4:0]            = 5'b0;
            $rs2[4:0]            = 5'b0;
            $src1_value[31:0]    = 32'b0;
            $src2_value[31:0]    = 32'b0;

            $result[31:0]        = 32'b0;
            $pc[31:0]            = 32'b0;
            $imm[31:0]           = 32'b0;

            $is_s_instr          = 1'b0;

            $rd_valid            = 1'b0;
            $rs1_valid           = 1'b0;
            $rs2_valid           = 1'b0;
            $rf_wr_en            = 1'b0;
            $rf_wr_index[4:0]    = 5'b0;
            $rf_wr_data[31:0]    = 32'b0;
            $rf_rd_en1           = 1'b0;
            $rf_rd_en2           = 1'b0;
            $rf_rd_index1[4:0]   = 5'b0;
            $rf_rd_index2[4:0]   = 5'b0;

            $ld_data[31:0]       = 32'b0;
            $imem_rd_en          = 1'b0;
            $imem_rd_addr[M4_IMEM_INDEX_CNT-1:0] = {M4_IMEM_INDEX_CNT{1'b0}};
            
            /xreg[31:0]
               $value[31:0]      = 32'b0;
               $wr               = 1'b0;
               `BOGUS_USE($value $wr)
               $dummy[0:0]       = 1'b0;
            /dmem[15:0]
               $value[31:0]      = 32'0;
               $wr               = 1'b0;
               `BOGUS_USE($value $wr) 
               $dummy[0:0]       = 1'b0;
            `BOGUS_USE($is_lui $is_auig $is_jal $is_jalr $is_beq $is_bne $is_blt $is_bge $is_bltu $is_bgeu $is_lb $is_lh $is_lw $is_lbu $is_lhu $is_sb $is_sh $is_sw)
            `BOGUS_USE($is_addi $is_slti $is_sltiu $is_xori $is_ori $is_andi $is_slli $is_srli $is_srai $is_add $is_sub $is_sll $is_slt $is_sltu $is_xor)
            `BOGUS_USE($is_srl $is_sra $is_or $is_and $is_csrrw $is_csrrs $is_csrrc $is_csrrwi $is_csrrsi $is_csrrci)
            `BOGUS_USE($is_load $is_store)
            `BOGUS_USE($valid $rd $rs1 $rs2 $src1_value $src2_value $result $pc $imm)
            `BOGUS_USE($is_s_instr $rd_valid $rs1_valid $rs2_valid)
            `BOGUS_USE($rf_wr_en $rf_wr_index $rf_wr_data $rf_rd_en1 $rf_rd_en2 $rf_rd_index1 $rf_rd_index2 $ld_data)
            `BOGUS_USE($imem_rd_en $imem_rd_addr)
            
            $dummy[0:0]          = 1'b0;
      @_stage
         $ANY = /top|cpu<>0$ANY;
         
         /xreg[31:0]
            $ANY = /top|cpu/xreg<>0$ANY;
            `BOGUS_USE($dummy)
         
         /dmem[15:0]
            $ANY = /top|cpu/dmem<>0$ANY;
            `BOGUS_USE($dummy)

         // m4_mnemonic_expr is build for WARP-V signal names, which are slightly different. Correct them.
         m4_define(['m4_modified_mnemonic_expr'], ['m4_patsubst(m4_mnemonic_expr, ['_instr'], [''])'])
         $mnemonic[10*8-1:0] = m4_modified_mnemonic_expr $is_load ? "LOAD      " : $is_store ? "STORE     " : "ILLEGAL   ";
         \viz_alpha
            //
            renderEach: function() {
               debugger;
               //
               // PC instr_mem pointer
               //
               let $pc = '$pc';
               let color = !('$valid'.asBool()) ? "gray" :
                                                  "blue";
               let pcPointer = new fabric.Text("->", {
                  top: -30 + 0.5 * ($pc.asInt() / 4),
                  left: -18.5,
                  fill: color,
                  scaleX: 0.02,
                  scaleY: 0.02,
                  fontSize: 14,
                  fontFamily: "monospace"
               });
               
               let header = new fabric.Text("ARTIX-7 PROCESSING UNIT", {
                  top: -32,
                  left: -8,
                  fill: "black",
                  scaleX: 0.02,
                  scaleY: 0.02,
                  fontSize: 40,
                  fontFamily: "monospace"
               });
               //
               //
               // Fetch Instruction
               //
               // TODO: indexing only works in direct lineage.  let fetchInstr = new fabric.Text('|fetch/instr_mem[$Pc]$instr'.asString(), {  // TODO: make indexing recursive.
               //let fetchInstr = new fabric.Text('$raw'.asString("--"), {
               //   top: 50,
               //   left: 90,
               //   fill: color,
               //   fontSize: 14,
               //   fontFamily: "monospace"
               //});
               //
               // Instruction with values.
               //
               let regStr = (valid, regNum, regValue) => {
                  return valid ? `r${regNum} (${regValue})` : `rX`;
               };
               let srcStr = ($src, $valid, $reg, $value) => {
                  return $valid.asBool(false)
                             ? `\n      ${regStr(true, $reg.asInt(NaN), $value.asInt(NaN))}`
                             : "";
               };
               let str = `${regStr('$rd_valid'.asBool(false), '$rd'.asInt(NaN), '$result'.asInt(NaN))}\n` +
                         `  = ${'$mnemonic'.asString()}${srcStr(1, '$rs1_valid', '$rs1', '$src1_value')}${srcStr(2, '$rs2_valid', '$rs2', '$src2_value')}\n` +
                         `      i[${'$imm'.asInt(NaN)}]`;
               let instrWithValues = new fabric.Text(str, {
                  top: -29,
                  left: -4,
                  fill: color,
                  scaleX: 0.02,
                  scaleY: 0.02,
                  fontSize: 14,
                  fontFamily: "monospace"
               });
               return {objects: [pcPointer, instrWithValues, header]};
            }
         //
         // Register file
         //
         /xreg[31:0]           
            \viz_alpha
               initEach: function() {
                  let regname = new fabric.Text("Reg File", {
                        top: -30,
                        left: 1,
                        scaleX: 0.02,
                        scaleY: 0.02,
                        fontSize: 14,
                        fontFamily: "monospace"
                     });
                  let reg = new fabric.Text("", {
                     top:-29.5 + 0.5 * this.getIndex(),
                     left: 1,
                     fontSize: 14,
                     scaleX: 0.02,
                     scaleY: 0.02,
                     fontFamily: "monospace"
                  });
                  return {objects: {regname: regname, reg: reg}};
               },
               renderEach: function() {
                  let mod = '$wr'.asBool(false);
                  let reg = parseInt(this.getIndex());
                  let regIdent = reg.toString();
                  let oldValStr = mod ? `(${'>>1$value'.asInt(NaN).toString()})` : "";
                  this.getInitObject("reg").setText(
                     regIdent + ": " +
                     '$value'.asInt(NaN).toString() + oldValStr);
                  this.getInitObject("reg").setFill(mod ? "blue" : "black");
               }
         //
         // DMem
         //
         /dmem[15:0]
            \viz_alpha
               initEach: function() {
                  let memname = new fabric.Text("Mini DMem", {
                        top: -30,
                        left: 6,
                        scaleX: 0.02,
                        scaleY: 0.02,
                        fontSize: 14,
                        fontFamily: "monospace"
                     });
                  let mem = new fabric.Text("", {
                     top: -29.5 + 0.5 * this.getIndex(),
                     left: 6,
                     scaleX: 0.02,
                     scaleY: 0.02,
                     fontSize: 14,
                     fontFamily: "monospace"
                  });
                  return {objects: {memname: memname, mem: mem}};
               },
               renderEach: function() {
                  let mod = '$wr'.asBool(false);
                  let mem = parseInt(this.getIndex());
                  let memIdent = mem.toString();
                  let oldValStr = mod ? `(${'>>1$value'.asInt(NaN).toString()})` : "";
                  this.getInitObject("mem").setText(
                     memIdent + ": " +
                     '$value'.asInt(NaN).toString() + oldValStr);
                  this.getInitObject("mem").setFill(mod ? "blue" : "black");
               }
   '])   
       
\TLV
   
   // /====================\
   // | Sum 1 to 9 Program |
   // \====================/
   //
   // Program for MYTH Workshop to test RV32I
   // Add 1,2,3,...,9 (in that order).
   //
   // Regs:
   //  r10 (a0): In: 0, Out: final sum
   //  r12 (a2): 10
   //  r13 (a3): 1..10
   //  r14 (a4): Sum
   // 
   // External to function:
   
   m4_asm(ADD, r10, r0, r0)             // Initialize r10 (a0) to 0.
   // Function:
   m4_asm(ADD, r14, r10, r0)            // Initialize sum register a4 with 0x0
   m4_asm(ADDI, r12, r10, 1010)         // Store count of 10 in register a2.
   m4_asm(ADD, r13, r10, r0)            // Initialize intermediate sum register a3 with 0
   // Loop:
   m4_asm(ADD, r14, r13, r14)           // Incremental addition
   m4_asm(ADDI, r13, r13, 1)            // Increment intermediate register by 1
   m4_asm(BLT, r13, r12, 1111111111000) // If a3 is less than a2, branch to label named <loop>
   m4_asm(ADD, r10, r14, r0)            // Store final result to register a0 so that it can be read by main program
   m4_asm(SW, r0, r10, 10000)           // Store the value of r10 into address 17.
   m4_asm(LW, r17, r0, 10000)           // Load the value from 
   
   // Optional:
   // m4_asm(JAL, r7, 00000000000000000000) // Done. Jump to itself (infinite loop). (Up to 20-bit signed immediate plus implicit 0 bit (unlike JALR) provides byte address; last immediate bit should also be 0)
   m4_define_hier(['M4_IMEM'], M4_NUM_INSTRS)   
   
   
   |cpu
      @0
         $reset = *reset;
         
         m4+counter($one_second, 33333333)
      //Fetch
         // Next PC
         $pc[31:0] = (>>1$reset) ? 0 : ($one_second == 0) ? $RETAIN : 
                     (>>3$taken_br) ? >>3$br_tgt_pc : 
                     (>>3$valid_load) ? >>3$inc_pc : 
                     (>>3$valid_jump && >>3$is_jal) ? >>3$br_tgt_pc :
                     (>>3$valid_jump && >>3$is_jalr) ? >>3$jalr_tgt_pc : >>1$inc_pc ;
         
         $imem_rd_en = !$reset;
         $imem_rd_addr[31:0] = $pc[M4_IMEM_INDEX_CNT+1:2];
         
      @1         
         $instr[31:0] = $imem_rd_data[31:0];
         $inc_pc[31:0] = $pc + 32'd4;          
      // Decode   
         $is_i_instr = $instr[6:2] == 5'b00000 ||
                       $instr[6:2] == 5'b00001 ||
                       $instr[6:2] == 5'b00100 ||
                       $instr[6:2] == 5'b00110 ||
                       $instr[6:2] == 5'b11001;
         $is_r_instr = $instr[6:2] == 5'b01011 ||
                       $instr[6:2] == 5'b10100 ||
                       $instr[6:2] == 5'b01100 ||
                       $instr[6:2] == 5'b01101;                       
         $is_b_instr = $instr[6:2] == 5'b11000;
         $is_u_instr = $instr[6:2] == 5'b00101 ||
                       $instr[6:2] == 5'b01101;
         $is_s_instr = $instr[6:2] == 5'b01000 ||
                       $instr[6:2] == 5'b01001;
         $is_j_instr = $instr[6:2] == 5'b11011;
         
         $imm[31:0] = $is_i_instr ? { {21{$instr[31]}} , $instr[30:20] } :
                      $is_s_instr ? { {21{$instr[31]}} , $instr[30:25] , $instr[11:8] , $instr[7] } :
                      $is_b_instr ? { {20{$instr[31]}} , $instr[7] , $instr[30:25] , $instr[11:8] , 1'b0} :
                      $is_u_instr ? { $instr[31:12] , 12'b0} : 
                      $is_j_instr ? { {12{$instr[31]}} , $instr[19:12] , $instr[20] , $instr[30:21] , 1'b0} : 32'b0;
         
         $rs2_valid = $is_r_instr || $is_s_instr || $is_b_instr;
         $rs1_valid = $is_r_instr || $is_s_instr || $is_b_instr || $is_i_instr;
         $rd_valid = $is_r_instr || $is_i_instr || $is_u_instr || $is_j_instr;
         $funct3_valid = $is_r_instr || $is_s_instr || $is_b_instr || $is_i_instr;
         $funct7_valid = $is_r_instr;
         
         ?$rs2_valid
            $rs2[4:0] = $instr[24:20];
         ?$rs1_valid
            $rs1[4:0] = $instr[19:15];
         ?$rd_valid
            $rd[4:0] = $instr[11:7];
         ?$funct3_valid
            $funct3[2:0] = $instr[14:12];
         ?$funct7_valid
            $funct7[6:0] = $instr[31:25];
            
         $opcode[6:0] = $instr[6:0];
         
         $dec_bits[10:0] = {$funct7[5],$funct3,$opcode};
         
         // Branch Instruction
         $is_beq = $dec_bits[9:0] == 10'b000_1100011;
         $is_bne = $dec_bits[9:0] == 10'b001_1100011;
         $is_blt = $dec_bits[9:0] == 10'b100_1100011;
         $is_bge = $dec_bits[9:0] == 10'b101_1100011;
         $is_bltu = $dec_bits[9:0] == 10'b110_1100011;
         $is_bgeu = $dec_bits[9:0] == 10'b111_1100011;
         
         // Arithmetic Instruction
         $is_add = $dec_bits == 11'b0_000_0110011;
         $is_addi = $dec_bits[9:0] == 10'b000_0010011;
         $is_or = $dec_bits == 11'b0_110_0110011;
         $is_ori = $dec_bits[9:0] == 10'b110_0010011;
         $is_xor = $dec_bits == 11'b0_100_0110011;
         $is_xori = $dec_bits[9:0] == 10'b100_0010011;
         $is_and = $dec_bits == 11'b0_111_0110011;
         $is_andi = $dec_bits[9:0] == 10'b111_0010011;
         $is_sub = $dec_bits == 11'b1_000_0110011;
         $is_slti = $dec_bits[9:0] == 10'b010_0010011;
         $is_sltiu = $dec_bits[9:0] == 10'b011_0010011;
         $is_slli = $dec_bits == 11'b0_001_0010011;
         $is_srli = $dec_bits == 11'b0_101_0010011;
         $is_srai = $dec_bits == 11'b1_101_0010011;
         $is_sll = $dec_bits == 11'b0_001_0110011;
         $is_slt = $dec_bits == 11'b0_010_0110011;
         $is_sltu = $dec_bits == 11'b0_011_0110011;
         $is_srl = $dec_bits == 11'b0_101_0110011;
         $is_sra = $dec_bits == 11'b1_101_0110011;
         `BOGUS_USE($is_srli)
         // Load Instruction
         $is_load = $dec_bits[6:0] == 7'b0000011;
         
         // Store Instruction
         $is_sb = $dec_bits[9:0] == 10'b000_0100011;
         $is_sh = $dec_bits[9:0] == 10'b001_0100011;
         $is_sw = $dec_bits[9:0] == 10'b010_0100011;
         
         // Jump Instruction
         $is_lui = $dec_bits[6:0] == 7'b0110111;
         $is_auipc = $dec_bits[6:0] == 7'b0010111;
         $is_jal = $dec_bits[6:0] == 7'b1101111;
         $is_jalr = $dec_bits[9:0] == 10'b000_1100111;
         
         $is_jump = $is_jal || $is_jalr;
         
      @2   
      // Register File Read
         $rf_rd_en1 = $rs1_valid;
         ?$rf_rd_en1
            $rf_rd_index1[4:0] = $rs1[4:0];
         
         $rf_rd_en2 = $rs2_valid;
         ?$rf_rd_en2
            $rf_rd_index2[4:0] = $rs2[4:0];
            
      // Branch Target PC       
         $br_tgt_pc[31:0] = $pc + $imm;
      
      // Jump Target PC
         $jalr_tgt_pc[31:0] = $src1_value + $imm;
         
      // Input signals to ALU
         $src1_value[31:0] = ((>>1$rd == $rs1) && >>1$rf_wr_en) ? >>1$result : $rf_rd_data1[31:0];
         $src2_value[31:0] = ((>>1$rd == $rs2) && >>1$rf_wr_en) ? >>1$result : $rf_rd_data2[31:0];
         
      @3   
         
      // ALU
         $sltu_result = $src1_value < $src2_value ;
         $sltiu_result = $src1_value < $imm ;
         
         $result[31:0] = $is_addi ? $src1_value + $imm :
                         $is_add ? $src1_value + $src2_value : 
                         $is_or ? $src1_value | $src2_value : 
                         $is_ori ? $src1_value | $imm :
                         $is_xor ? $src1_value ^ $src2_value :
                         $is_xori ? $src1_value ^ $imm :
                         $is_and ? $src1_value & $src2_value :
                         $is_andi ? $src1_value & $imm :
                         $is_sub ? $src1_value - $src2_value :
                         $is_slti ? (($src1_value[31] == $imm[31]) ? $sltiu_result : {31'b0,$src1_value[31]}) :
                         $is_sltiu ? $sltiu_result :
                         $is_slli ? $src1_value << $imm[5:0] :
                         $is_srai ? ({{32{$src1_value[31]}}, $src1_value} >> $imm[4:0]) :
                         $is_sll ? $src1_value << $src2_value[4:0] :
                         $is_slt ? (($src1_value[31] == $src2_value[31]) ? $sltu_result : {31'b0,$src1_value[31]}) :
                         $is_sltu ? $sltu_result :
                         $is_srl ? $src1_value >> $src2_value[5:0] :
                         $is_sra ? ({{32{$src1_value[31]}}, $src1_value} >> $src2_value[4:0]) :
                         $is_lui ? ({$imm[31:12], 12'b0}) :
                         $is_auipc ? $pc + $imm :
                         $is_jal ? $pc + 4 :
                         $is_jalr ? $pc + 4 : 
                         ($is_load || $is_s_instr) ? $src1_value + $imm : 32'bx;
                         
      // Register File Write
         $rf_wr_en = ($rd_valid && $valid && $rd != 5'b0) || >>2$valid_load;
         ?$rf_wr_en
            $rf_wr_index[4:0] = !$valid ? >>2$rd[4:0] : $rd[4:0];
            $rf_wr_data[31:0] = !$valid ? >>2$ld_data[31:0] : $result[31:0];
      
      // Branch
         $taken_br = $is_beq ? ($src1_value == $src2_value) :
                     $is_bne ? ($src1_value != $src2_value) :
                     $is_blt ? (($src1_value < $src2_value) ^ ($src1_value[31] != $src2_value[31])) :
                     $is_bge ? (($src1_value >= $src2_value) ^ ($src1_value[31] != $src2_value[31])) :
                     $is_bltu ? ($src1_value < $src2_value) :
                     $is_bgeu ? ($src1_value >= $src2_value) : 1'b0;
                     
         $valid_taken_br = $valid && $taken_br;
         
      // Load
         $valid_load = $valid && $is_load;
         $valid = $reset ? 0 : ($one_second && !(>>1$valid_taken_br || >>2$valid_taken_br || >>1$valid_load || >>2$valid_load || >>1$valid_jump || >>2$valid_jump)) ;
      
      // Jump
         $valid_jump = $valid && $is_jump;
                  
      @4
         $dmem_rd_en = $valid_load;
         $dmem_wr_en = $valid && $is_s_instr;
         $dmem_addr[3:0] = $result[5:2];
         $dmem_wr_data[31:0] = $src2_value[31:0];
         
      @5   
         $ld_data[31:0] = $dmem_rd_data[31:0];
         
      // Note: Because of the magic we are using for visualisation, if visualisation is enabled below,
      //       be sure to avoid having unassigned signals (which you might be using for random inputs)
      //       other than those specifically expected in the labs. You'll get strange errors for these.
      
         `BOGUS_USE($is_beq $is_bne $is_blt $is_bge $is_bltu $is_bgeu)
         `BOGUS_USE($is_sb $is_sh $is_sw)
   // Assert these to end simulation (before Makerchip cycle limit).
         m4_ifelse_block(M4_MAKERCHIP, 1, ['   
         '], ['
         \SV_plus 
            always @(posedge clk) begin 
               *led = /top|cpu$one_second;
            end
         '])
   // Macro instantiations for:
   //  o instruction memory
   //  o register file
   //  o data memory
   //  o CPU visualization
   |cpu
      m4+imem(@1)    // Args: (read stage)
      m4+rf(@2, @3, /top|cpu$one_second)  // Args: (read stage, write stage) - if equal, no register bypass is required
      m4+dmem(@4, /top|cpu$one_second)    // Args: (read/write stage)
   
\TLV   
   m4+fpga_seg(@5, /top|cpu/xreg[14]<>0$value)
   m4_ifelse_block(M4_MAKERCHIP, 1, ['
   m4+cpu_viz(@4)    // For visualisation, argument should be at least equal to the last stage of CPU logic                      
   '], [''])
   
\SV
   endmodule