`timescale 1ns / 1ps

module ALU_1(
    input A,
    input B,
    input carry_in,
    input [3:0]ALU_op,
    output result,
    output carry_out
    );
wire mux1out, mux2out, and_out, or_out, add_out;
assign mux1out = (ALU_op[3] == 0) ? A : ~ A; 
assign mux2out = (ALU_op[2] == 0) ? B : ~B;

assign and_out = mux1out & mux2out;
assign or_out = mux1out | mux2out;
assign add_out = mux1out + mux2out + carry_in;

assign carry_out = (mux1out & carry_in) | (mux2out & carry_in) | (mux1out & mux2out);


assign result = (ALU_op[1] == 0) ? 
                ((ALU_op[0] == 0) ? and_out : or_out)
                 : add_out;
endmodule
