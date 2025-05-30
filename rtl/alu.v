`include "defines.v"

// Arithmetic Logic Unit

module alu (
        input   wire [`BITWIDTH - 1:0]  a,
        input   wire [`BITWIDTH - 1:0]  b,
        input   wire [3:0]              ALUOp,
        output  reg [`BITWIDTH - 1:0]   result
    );

    wire [`BITWIDTH - 1:0]  shamt;

    assign shamt = (ALUOp == 4'b0001 || ALUOp == 4'b0101 || ALUOp == 4'b1101 ) ? b + 32'h40 : b;

    always @(*) begin
        case (ALUOp)
            4'b0000: begin // add
                result  = a + b;
            end
            4'b1000: begin // sub
                result  = a - b;
            end
            4'b0001: begin // sll
                result  = a << {27'b0,shamt[4:0]};
            end
            4'b0010: begin // slt
                result  = $signed(a) < $signed(b);
            end
            4'b0011: begin // sltu
                result  = a < b;
            end
            4'b0100: begin // xor
                result  = a ^ b;
            end
            4'b0101: begin // srl
                result  = a >> {27'b0,shamt[4:0]};
            end
            4'b1101: begin // sra
                result  = $signed(a) >>> {27'b0,shamt[4:0]};
            end
            4'b0110: begin // or
                result  = a | b;
            end
            4'b0111: begin // and
                result  = a & b;
            end
            default: begin
                result  = 32'b0;
            end
        endcase
    end

endmodule
