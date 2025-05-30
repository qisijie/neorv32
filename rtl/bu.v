`include "defines.v"

// Branch unit

module bu (
        input   wire [`BITWIDTH - 1:0]  a,
        input   wire [`BITWIDTH - 1:0]  b,
        input   wire [2:0]              func3,
        output  reg                     zero
    );

    always @(*) begin
        case (func3)
            `INST_BEQ: begin // beq
                zero  = (a == b) ? 1'b1 : 1'b0;
            end
            `INST_BNE: begin // bne
                zero  = (a == b) ? 1'b0 : 1'b1;
            end
            `INST_BLT: begin // blt
                zero  = ($signed(a) < $signed(b)) ? 1'b1 : 1'b0;
            end
            `INST_BGE: begin // bge
                zero  = ($signed(a) < $signed(b)) ? 1'b0 : 1'b1;
            end
            `INST_BLTU: begin // bltu
                zero  = (a < b) ? 1'b1 : 1'b0;
            end
            `INST_BGEU: begin // bgeu
                zero  = (a < b) ? 1'b0 : 1'b1;
            end
            default: begin
                zero  = 1'b0;
            end
        endcase
    end

endmodule
