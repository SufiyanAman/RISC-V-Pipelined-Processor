`timescale 1ns / 1ps
module registerFile(
    input [63:0] writedataREG,
    input [4:0] rs1,
    input [4:0] rs2,
    input [4:0] rd,
    input registerwrite,
    input clk,
    input reset,
    output reg [63:0] readdata1,
    output reg [63:0] readdata2
);
    reg [63:0] registers[31:0];
    integer i;

    initial begin
        for (i = 0; i < 32; i = i + 1)
        begin
            registers[i] = i;
        end
    end

    always @(posedge clk) begin
        if (registerwrite == 1) begin
            registers[rd] = writedataREG;
        end
    end

always @(*) begin
    if (reset)begin
        readdata1 = 0;
        readdata2 = 0;
    end 
    else begin
        readdata1 = registers[rs1];
        readdata2 = registers[rs2];
    end
end
endmodule
