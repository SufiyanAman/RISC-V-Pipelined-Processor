`timescale 1ns / 1ps

module processor(
    input clk,
    input reset
);

    //Program Counter
    wire [63:0]pc_in;
    wire [63:0] pc_out;
    program_counter pc2(clk, reset, pc_in, pc_out);
    
    //PC + 4
    wire [63:0] pc_out_adder;
    adder add_pc(pc_out, 64'd4, pc_out_adder);
    
    //INST_MEM
    wire [31:0] instruction;
    wire [63:0] ifidpc_out;
    wire [31:0] ifidinst;
    instruction_memory im2(pc_out, instruction);
    IF_ID ifid(clk, reset, pc_out, instruction, ifidpc_out, ifidinst);
    //PARSER
    wire [6:0]opcode;
    wire [2:0] func3;
    wire [6:0] func7;
    wire [4:0] rs1;
    wire [4:0] rs2;
    wire [4:0] rd;
    instruction_parser ip(ifidinst,opcode,rd,func3,rs1,rs2,func7);
    
    //CONTROL_UNIT
    wire branch;
    wire memread;
    wire memtoreg;
    wire [1:0]ALUOp;
    wire memwrite;
    wire ALUSrc;
    wire regwrite;
    control_unit cu(opcode, branch, memread, memtoreg, ALUOp, memwrite, ALUsrc, regwrite);
    
    //REG_FILE
    wire [63:0] writedata;
    wire [63:0] readdata1;
    wire [63:0] readdata2;
    wire [4:0] MEM_WB_rd;
    wire MEM_WB_regwrite;
    registerFile rf(writedata,rs1,rs2,MEM_WB_rd,MEM_WB_regwrite,clk,reset, readdata1,readdata2);
    
    //Immediate gen
    wire [63:0] imm_data,idexpc_out;
    immediate_data_generator idg(ifidinst,imm_data);
    
    wire [4:0] idexrs1;
    wire [4:0] idexrs2;
    wire [4:0] idexrd;
    wire [3:0] idexfunct;
    wire idexbranch;
    wire idexmemread;
    wire idexmemtoreg;
    wire idexmemwrite;
    wire idexregwrite;
    wire idexalusrc;
    wire [1:0] idexaluop;
    wire [63:0]idexreaddata1;
    wire [63:0]idexreaddata2;
    wire [63:0]ideximmdata;
    
    ID_EXE idex( clk, reset,  ifidpc_out,readdata1,readdata2, imm_data,   rs1, rs2, rd,
                {ifidinst[30],ifidinst[14:12] },  branch, memread, memtoreg, memwrite, regwrite, alusrc, 
               aluop,  idexpc_out,idexreaddata1,idexreaddata2, ideximmdata,  
               idexrs1, idexrs2, idexrd,   idexfunct,   idexbranch, idexmemread, 
               idexmemtoreg, idexmemwrite, idexregwrite, idexalusrc, idexaluop);
               
    //ALU_control
    wire [3:0]funct;
    wire [3:0]operation;
    assign funct = {instruction[30],instruction[14:12]};
    ALU_control aluc(idexaluop, idexfunct, operation);
 
    //MUX (ALUSrc)
    wire [63:0] m1out;
    wire [63:0] exmemaluout;
    wire [1:0] forwarda,forwardb;
    wire [63:0] m3to1out1,m3to1out2,mux2out;
    
    
//    ADDING THE PC with shift left
    wire [63:0]pc_branch;
    wire [63:0] random;
    adder add_branch(idexpc_out, ideximmdata*2, pc_branch);
    
//    mux m1(readdata2, imm_data, ALUsrc, m1out);

mux_3_by_1 mm(idexreaddata1, writedata, exmemaluout, forwarda, m3to1out1);

mux_3_by_1 mn(idexreaddata2, writedata, exmemaluout, forwardb, m3to1out2);

mux mmm(m3to1out2, ideximmdata, idexalusrc, mux2out);



    //ALU
    wire [63:0] alu_result;
    wire zero;
    ALU_64 alu64(m3to1out2, mux2out, operation, alu_result, zero);   
    
    wire [63:0] exmemadderout;
    wire exmemzero;
    
    wire [63:0] exmemwritedataout;
    wire [4:0] exmemrd;
    
    wire PCmuxselect;
    wire exmembranch, exmemmemread, exmemmemtoreg, exmemmemwrite, exmemregwrite;
    wire branch_finale;
    
    EXE_MEM exmem( clk,reset,
   pc_branch, 
    alu_result, 
   zero,
   m3to1out2,
   idexrd, 
   idexbranch,idexmemread, idexmemtoreg, idexmemwrite, idexregwrite,
     PCmuxselect,
     exmemadderout,
    exmemzero,
     exmemaluout,
     exmemwritedataout,
     exmemrd,
    exmembranch, exmemmemread, exmemmemtoreg, exmemmemwrite, exmemregwrite,
    branch_finale);
    
    
    
    //MEM_READ DATA
    wire [63:0] mem_out;
    wire [63:0] memwbreaddataout,memwbaluout;
    Data_Memory dm1(exmemaluout, exmemwritedataout ,clk, exmemmemwrite, exmemmemread, mem_out);
    
    wire memwbmemtoreg;
    MEM_WB memwb(clk, reset, mem_out, exmemaluout, exmemrd, exmemmemtoreg, exmemregwrite, 
                            memwbreaddataout, memwbaluout, MEM_WB_rd, memwbmemtoreg, MEM_WB_regwrite);
    
    
    //MUX(MEMtoREG) to select between ALU_result and MEMORY_OUT
    mux m2(memwbaluout, memwbreaddataout, memwbmemtoreg, writedata);   //MemToReg Mux


    //SHIFT LEFT
//    wire [63:0]sl_result;
//    shift_left sl(imm_data, sl_result);
    
//    assign and_out = (branch && zero) ? 1 : 0;


    forwarding_unit fu(idexrs1, idexrs2, exmemrd, MEM_WB_rd, MEM_WB_regwrite, exmemregwrite, forwarda, forwardb);

    branching_unit branch_check(idexfunct[2:0], idexreaddata1, idexreaddata2, PCmuxselect);
    wire and_out;
    
    assign and_out = branch_finale && exmembranch;
    wire and_out_final;
    z_to_0 zt0(and_out, and_out_final);
    

    mux m3(pc_out_adder, pc_branch, and_out_final, pc_in);
//    assign mux3_out = pc_in;
    
//        pc_ou
endmodule
