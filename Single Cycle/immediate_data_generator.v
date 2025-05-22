
`timescale 1ns / 1ps

module immediate_data_generator(
    input [31:0] instruction,
    output reg [63:0] imm_data
);
    wire [1:0] select_bits;
    assign select_bits = instruction[6:5];

    always @(*)
    begin
        if (select_bits == 2'b00)
            imm_data[11:0] = instruction[31:20];
        else if (select_bits == 2'b01)
            imm_data[11:0] = {instruction[31:25], instruction[11:7]};
        else if (select_bits == 2'b11)
            imm_data[11:0] = {instruction[31], instruction[7], instruction[30:25], instruction[11:8]};

        if (imm_data[11] == 1)
            imm_data[63:12] = 52'b1111111111111111111111111111111111111111111111111111;
        else if (imm_data[11] == 0)
            imm_data[63:12] = 0;
    end

endmodule