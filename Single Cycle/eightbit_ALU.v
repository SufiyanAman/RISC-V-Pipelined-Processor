`timescale 1ns / 1ps

module eightbit_ALU(
input [7:0] a,
input [7:0] b,
input carry_in,
input [3:0] ALU_op,
output [7:0] result,
output carry_out
    );
    wire c0,c1,c2,c3,c4,c5,c6;
    ALU_1 bit_zero(a[0], b[0],carry_in,ALU_op,result[0],c0);
    ALU_1 bit_one(a[1], b[1],c0,ALU_op,result[1],c1);
    ALU_1 bit_two(a[2], b[2],c1,ALU_op,result[2],c2);
    ALU_1 bit_three(a[3], b[3],c2,ALU_op,result[3],c3);
    ALU_1 bit_four(a[4], b[4],c3,ALU_op,result[4],c4);
    ALU_1 bit_five(a[5], b[5],c4,ALU_op,result[5],c5);
    ALU_1 bit_six(a[6], b[6],c5,ALU_op,result[6],c6);
    ALU_1 bit_seven(a[7], b[7],c6,ALU_op,result[7],carry_out);
endmodule
