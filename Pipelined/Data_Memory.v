`timescale 1ns / 1ps
module Data_Memory(
    input [63:0] Mem_Addr,
    input [63:0] Write_DataMEM,
    input clk,
    input MemWrite,
    input MemRead,
    output reg [63:0] Read_Data
);
reg [63:0]element1;
reg [63:0]element2;
reg [63:0]element3;
reg [63:0]element4;

    reg [7:0] data_mem [63:0];     //64BIT DATA //stored using 8 bit registers
    integer i;
    initial begin
        for (i = 0; i < 64; i = i+1) begin
           data_mem[i] = 0;
        end
      data_mem[0] = 8'd255;
      data_mem[8] = 8'd244;
      data_mem[16] = 8'd100;
      data_mem[24] = 8'd125;
      data_mem[32] = 8'd25;
    end
  

          
    always @(*) begin
        if (MemRead==1) begin
            Read_Data[7:0] = data_mem[Mem_Addr];
            Read_Data[15:8] = data_mem[Mem_Addr+1];
            Read_Data[23:16] = data_mem[Mem_Addr+2];
            Read_Data[31:24] = data_mem[Mem_Addr+3];
            Read_Data[39:32] = data_mem[Mem_Addr+4];
            Read_Data[47:40] = data_mem[Mem_Addr+5  ];
            Read_Data[55:48] = data_mem[Mem_Addr+6];
            Read_Data[63:56] = data_mem[Mem_Addr+7];
            end           
    end
    
    
    
    
    always @(posedge clk) begin
        if (MemWrite==1) begin
            data_mem[Mem_Addr] = Write_DataMEM[7:0];
            data_mem[Mem_Addr+1] = Write_DataMEM[15:8];
            data_mem[Mem_Addr+2] = Write_DataMEM[23:16];
            data_mem[Mem_Addr+3] = Write_DataMEM[31:24];
            data_mem[Mem_Addr+4] = Write_DataMEM[39:32];
            data_mem[Mem_Addr+5] = Write_DataMEM[47:40];
            data_mem[Mem_Addr+6] = Write_DataMEM[55:48];
            data_mem[Mem_Addr+7] = Write_DataMEM[63:56];
            end
             
    end



endmodule