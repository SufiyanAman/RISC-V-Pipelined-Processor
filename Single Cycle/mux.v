`timescale 1ns / 1ps

module mux(
input [63:0] a,
input [63:0] b,
input sel,
output [63:0] out
    );
    assign out[63:0]= (sel) ? b:a;
endmodule
