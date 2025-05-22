`timescale 1ns / 1ps 
module ALU_64( 
input [63:0]a, 
input [63:0]b, 
input [3:0]AluOp,
output reg [63:0]Result, 
output reg zero 
);  
always @(*) begin 
case (AluOp) 
  4'b0000: begin  
          Result = a & b; 
      end 
  4'b0001: begin  
          Result = a | b; 
      end 
  4'b0010: begin  
          Result = a + b; 
      end 
  4'b0100: begin  
          Result = a & ~b; 
      end 
  4'b0101: begin  
          Result = a | ~b; 
      end 
  4'b0110: begin  
          Result = a - b; 
      end
  4'b1000: begin  
          Result = ~a & b; 
      end 
  4'b1001: begin  
          Result = ~a | b; 
      end 
  4'b1010: begin  
          Result = b - a; 
      end 
  4'b1100: begin  
          Result = ~a & ~b; 
      end 
  4'b1101: begin  
          Result = ~a | ~b; 
      end 
  4'b1110: begin  
          Result = 0-(a+b); 
      end 
  default: begin end 
 endcase 
zero = (Result == 0)? 1:0; 
end 

endmodule
