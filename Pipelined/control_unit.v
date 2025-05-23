`timescale 1ns / 1ps
module control_unit(
    input [6:0] opcode,
    output reg branch,
    output reg memread,
    output reg memtoreg,
    output reg [1:0] ALUOp,
    output reg memwrite,
    output reg ALUsrc,
    output reg regwrite
);

    always @(*)
    begin
        if (opcode[6:0] == 7'b0110011) begin
            regwrite = 1;
            ALUOp[1:0] = 2'b10;
            branch = 0;
            memread = 0;
            memtoreg = 0;
            memwrite = 0;
            ALUsrc = 0;
        end
        else if (opcode[6:0] == 7'b0000011) begin
            regwrite = 1;
            ALUOp[1:0] = 2'b00;
            branch = 0;
            memread = 1;
            memtoreg = 1;
            memwrite = 0;
            ALUsrc = 1;
        end
        else if (opcode[6:0] == 7'b0100011) begin
            regwrite = 0;
            ALUOp[1:0] = 2'b00;
            branch = 0;
            memread = 0;
            memtoreg = 'bX;
            memwrite = 1;
            ALUsrc = 1;
        end
        else if (opcode[6:0] == 7'b1100011) begin
            regwrite = 0;
            ALUOp[1:0] = 2'b01;
            branch = 1;
            memread = 0;
            memtoreg = 1'bX;
            memwrite = 0;
            ALUsrc = 0;
        end
        else if (opcode[6:0] == 7'b0010011) begin
            regwrite = 1;
            ALUOp[1:0] = 2'b00;
            branch = 0;
            memread = 0;
            memtoreg = 0;
            memwrite = 0;
            ALUsrc = 1;
        end
    end
endmodule