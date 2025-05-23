`timescale 1ns / 1ps

module instruction_parser(
    input [31:0] instruction,
    output [6:0] op_code,
    output [4:0] rd,
    output [2:0] fun3,
    output [4:0] rs1,
    output [4:0] rs2,
    output [6:0] fun7
);

assign op_code = instruction[6:0];
assign rd = instruction[11:7];
assign fun3 = instruction[14:12];
assign rs1 = instruction[19:15];
assign rs2 = instruction[24:20];
assign fun7 = instruction[31:25];

endmodule