`timescale 1ns / 1ps


module z_to_0(
input x,
output a
    );
    assign a = (x===1'bx)?1'b0:x;
endmodule
