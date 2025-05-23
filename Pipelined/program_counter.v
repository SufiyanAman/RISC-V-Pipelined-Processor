`timescale 1ns / 1ps
module program_counter( input clk,
                        input reset,
                        input [63:0]PC_In,
                        output reg [63:0]PC_Out );
   initial
     begin PC_Out = 0;
     end
   always @(posedge clk)
     begin
       if (reset) begin
            PC_Out = 0; end
       else begin
            PC_Out = PC_In; end
    end
endmodule