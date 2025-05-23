`timescale 1ns / 1ps

module instruction_memory
(
input [63:0] Inst_Address,
output reg [31:0] Instruction
);
reg [7:0] inst_mem [80:0];
initial begin
      {inst_mem[3], inst_mem[2], inst_mem[1], inst_mem[0]} = 32'h00000513;//1
//      {inst_mem[7], inst_mem[6], inst_mem[5], inst_mem[4]} = 32'h00000093;//2
//      {inst_mem[11], inst_mem[10], inst_mem[9], inst_mem[8]} = 32'h00000113;//3
//      {inst_mem[15], inst_mem[14], inst_mem[13], inst_mem[12]} = 32'h00000293;//4
//      {inst_mem[19], inst_mem[18], inst_mem[17], inst_mem[16]} = 32'h005505b3;//5	
//      {inst_mem[23], inst_mem[22], inst_mem[21], inst_mem[20]} = 32'h0005a603;//6
//      {inst_mem[27], inst_mem[26], inst_mem[25], inst_mem[24]} = 32'h00858693;//7
//      {inst_mem[31], inst_mem[30], inst_mem[29], inst_mem[28]} = 32'h0006a703;//8
//      {inst_mem[35], inst_mem[34], inst_mem[33], inst_mem[32]} = 32'h00e64663;//9
//      {inst_mem[39], inst_mem[38], inst_mem[37], inst_mem[36]} = 32'h00c6a023;//10	
//      {inst_mem[43], inst_mem[42], inst_mem[41], inst_mem[40]} = 32'h00e5a023;//11
//      {inst_mem[47], inst_mem[46], inst_mem[45], inst_mem[44]} = 32'h00110113;//12
//      {inst_mem[51], inst_mem[50], inst_mem[49], inst_mem[48]} = 32'h00828293;//13
//      {inst_mem[55], inst_mem[54], inst_mem[53], inst_mem[52]} = 32'hfc411ee3;//14
//      {inst_mem[59], inst_mem[58], inst_mem[57], inst_mem[56]} = 32'h00000113;//15
//      {inst_mem[63], inst_mem[62], inst_mem[61], inst_mem[60]} = 32'h00000293;//16
//      {inst_mem[67], inst_mem[66], inst_mem[65], inst_mem[64]} = 32'h00108093;//17
//      {inst_mem[71], inst_mem[70], inst_mem[69], inst_mem[68]} = 32'hfc4096e3;//18

end

always @(Inst_Address) begin
Instruction[7:0] = inst_mem[Inst_Address+0];
      Instruction[15:8] = inst_mem[Inst_Address+1];
      Instruction[23:16] = inst_mem[Inst_Address+2];
      Instruction[31:24] = inst_mem[Inst_Address+3];
end

endmodule