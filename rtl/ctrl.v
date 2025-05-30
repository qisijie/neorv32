`include "defines.v"

// Control

module ctrl (
    input   wire [6:0]  opcode,
    input   wire [2:0]  func3,
    input   wire [6:0]  func7,
    input   wire        stall,
    output  wire        rwen,
    output  wire        mwen,
    output  wire        ASel,
    output  wire        BSel,
    output  wire [1:0]  bj,
    output  wire [1:0]  wbSel,
    output  wire [2:0]  lsWidth,
    output  wire [3:0]  ALUOp,
    output  wire [2:0]  BOp
    
);

    assign rwen     = stall ? 1'b0 : (opcode == `INST_TYPE_S || opcode == `INST_TYPE_B) ? 1'b0 : 1'b1;
    assign mwen     = stall ? 1'b0 : (opcode == `INST_TYPE_S) ? 1'b1 : 1'b0;
    assign ASel     = stall ? 1'b0 : (opcode == `INST_TYPE_B || opcode == `INST_JAL || opcode == `INST_AUIPC) ? 1'b1 : 1'b0;
    assign BSel     = stall ? 1'b0 : (opcode == `INST_TYPE_L || opcode == `INST_TYPE_S || opcode == `INST_TYPE_B || opcode == `INST_JAL || opcode == `INST_TYPE_JI || opcode == `INST_TYPE_I || opcode == `INST_AUIPC || opcode == `INST_LUI) ? 1'b1 : 1'b0;
    assign bj       = stall ? 2'b0 : (opcode == `INST_TYPE_B) ? 2'b10 : ((opcode == `INST_TYPE_JI || opcode == `INST_JAL) ? 2'b01 : 2'b00);
    assign wbSel    = stall ? 2'b0 : (opcode == `INST_TYPE_JI || opcode == `INST_JAL) ? 2'b10 : ((opcode == `INST_TYPE_L) ? 2'b00 : 2'b01);
    assign lsWidth  = stall ? 3'b0 : (opcode == `INST_TYPE_L || opcode == `INST_TYPE_S) ? func3 : 3'b0;
    assign ALUOp    = stall ? 4'b0 : (opcode == `INST_TYPE_L || opcode == `INST_TYPE_S || opcode == `INST_TYPE_B || opcode == `INST_TYPE_JI) ? 1'b0 : {(((opcode == `INST_TYPE_I && func3 ==`INST_SRLI_SRAI) || (opcode == `INST_TYPE_R && func3 ==`INST_SRL_SRA) || (opcode == `INST_TYPE_R && func3 ==`INST_ADD_SUB)) ? func7[5] : 1'b0),func3};
    assign BOp      = stall ? 3'b0 : (opcode == `INST_TYPE_B) ? func3 : 3'b0;

endmodule