
`timescale 1ns / 1ps
module ALU_control(
    input [1:0] ALUOp,
    input [3:0] funct,
    output reg [3:0] operation
);

    always @(*)
    begin
        if (ALUOp == 2'b00) begin   
            operation <= 4'b0010;
        end
        else if (ALUOp == 2'b01) begin
            operation <= 4'b0110;
        end
        else if (ALUOp == 2'b10) begin
            if (funct == 4'b0000) begin
                operation <= 4'b0010;
            end
            else if (funct == 4'b1000) begin
                operation <= 4'b0110;
            end
            else if (funct == 4'b0111) begin
                operation <= 4'b0000;
            end
            else if (funct == 4'b0110) begin
                operation <= 4'b0001;
            end
        end
    end
endmodule



`timescale 1ns / 1ps 

  

//module ALU_Control( 
//    input [1:0]ALUOp, 
//    input [3:0]Funct, 
//    output reg [3:0]Operation 
//    ); 
//    always @(*) //    begin 
//        if (ALUOp == 2'b00) begin    // I/S-Type  
//            Operation <= 4'b0010;    
//        end 
//        else if (ALUOp == 2'b01) begin // SB-Type  
//            Operation <= 4'b0110; 
//        end 
//        else if (ALUOp == 2'b10) begin   // R-Type  
//            if (Funct == 4'b0000)    
//                Operation <= 4'b0010; 
//            if (Funct == 4'b1000) 
//                Operation <= 4'b0110; 
//            if (Funct == 4'b0111) 
//                Operation <= 4'b0000; 
//            if (Funct == 4'b0110) 
//                Operation <= 4'b0001; 
//        end 
//    end 
//endmodule