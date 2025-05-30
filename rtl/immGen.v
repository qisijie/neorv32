`include "defines.v"

// Immediate Generate

module immGen (
        input  wire [6:0]               opcode,
        input  wire [31:0]              instr,
        output reg [`BITWIDTH - 1:0]    imm
    );

    wire [`BITWIDTH - 1:0] immi;
    wire [`BITWIDTH - 1:0] imms;
    wire [`BITWIDTH - 1:0] immb;
    wire [`BITWIDTH - 1:0] immu;
    wire [`BITWIDTH - 1:0] immj;

    assign immi = {{20{instr[31]}},instr[31:20]};
    assign imms = {instr[31:25],instr[11:7]};
    assign immb = {{19{instr[31]}},instr[31],instr[7],instr[30:25],instr[11:8],1'b0};
    assign immu = {instr[31:12],12'b0};
    assign immj = {instr[31],instr[19:12],instr[20],instr[30:21],1'b0};

    always @(*) begin
        case (opcode)
            `INST_TYPE_I: begin
                imm = immi;
            end
            `INST_TYPE_S: begin
                imm = imms;
            end
            `INST_TYPE_B: begin
                imm = immb;
            end
            `INST_AUIPC: begin
                imm = immu;
            end
            `INST_LUI: begin
                imm = immu;
            end
            `INST_TYPE_JI: begin
                imm = immi;
            end
            `INST_JAL: begin
                imm = immj;
            end
            default: begin
                imm = 32'b0;
            end
        endcase
    end

endmodule
