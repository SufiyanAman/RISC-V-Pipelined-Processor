`timescale 1ns / 1ps

module processor_tb();
reg clk;
reg reset;

processor proc(clk, reset);
initial begin
    clk = 0;
    reset = 1;
    #0.5 reset = 0;
end

//clock toggle
always #1 clk = ~clk;
endmodule
