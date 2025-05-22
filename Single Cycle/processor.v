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
    wire [63:0]add_pc_out;
    adder add_pc(pc_out, 64'd4, add_pc_out);
    
    //INST_MEM
    wire [31:0] instruction;
    instruction_memory im2(pc_out, instruction);
    
    //PARSER
    wire [6:0]opcode;
    wire [2:0] func3;
    wire [6:0] func7;
    wire [4:0] rs1;
    wire [4:0] rs2;
    wire [4:0] rd;
    instruction_parser ip(instruction,opcode,rd,func3,rs1,rs2,func7);
    
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
    registerFile rf(writedata,rs1,rs2,rd,regwrite,clk,reset, readdata1,readdata2);
    
    //Immediate gen
    wire [63:0] imm_data;
    immediate_data_generator idg(instruction,imm_data);

    //ALU_control
    wire [3:0]funct;
    wire [3:0]operation;
    assign funct = {instruction[30],instruction[14:12]};
    ALU_control aluc(ALUOp, funct, operation);
 
    //MUX (ALUSrc)
    wire [63:0] m1out;
    mux m1(readdata2, imm_data, ALUsrc, m1out);

    //ALU
    wire [63:0] alu_result;
    wire zero;
    ALU_64 alu64(readdata1, m1out, operation, alu_result, zero);   
    
    //MEM_READ DATA
    wire [63:0] mem_out;
    Data_Memory dm1(alu_result, readdata2 ,clk, memwrite, memread, mem_out);
    
    //MUX(MEMtoREG) to select between ALU_result and MEMORY_OUT
    mux m2(alu_result, mem_out, memtoreg, writedata);   //MemToReg Mux


    //SHIFT LEFT
    wire [63:0]sl_result;
    shift_left sl(imm_data, sl_result);
    
    //ADDING THE PC with shift left
    wire [63:0]pc_branch;
    adder add_branch(pc_out, sl_result, pc_branch);
   
    //MUX for BRANCH (PC & PC + 4)
    wire PCmuxselect;
//    assign and_out = (branch && zero) ? 1 : 0;
    branching_unit branch_check(func3, readdata1, readdata2, PCmuxselect);
    wire and_out;
    assign and_out = branch && PCmuxselect;
    mux m3(add_pc_out, pc_branch, and_out, pc_in);
    
        
endmodule
