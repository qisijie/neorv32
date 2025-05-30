`include "defines.v"

// Execute

module ex (
        input   wire [31:0]             pcAddr,
        input   wire [`BITWIDTH - 1:0]  rs1Data,
        input   wire [`BITWIDTH - 1:0]  rs2Data,
        input   wire [`BITWIDTH - 1:0]  immData,
        input   wire                    ASel,
        input   wire                    BSel,
        input   wire [1:0]              bj,
        input   wire [3:0]              ALUOp,
        input   wire [2:0]              BOp,
        input   wire [1:0]              forwardA,
        input   wire [1:0]              forwardB,
        input   wire [`BITWIDTH - 1:0]  ex_mem_rdData,
        input   wire [`BITWIDTH - 1:0]  mem_wb_rdData,
        output  wire [`BITWIDTH - 1:0]  result,
        output  wire                    pcSel
    );

    wire [`BITWIDTH - 1:0] a;
    wire [`BITWIDTH - 1:0] b;
    wire [`BITWIDTH - 1:0] ba;
    wire [`BITWIDTH - 1:0] bb;

    assign a = ASel ? pcAddr  : (forwardA[0] ? ex_mem_rdData : (forwardA[1] ? mem_wb_rdData : rs1Data));
    assign b = BSel ? immData : (forwardB[0] ? ex_mem_rdData : (forwardB[1] ? mem_wb_rdData : rs2Data));

    assign ba = bj ? (forwardA[0] ? ex_mem_rdData : (forwardA[1] ? mem_wb_rdData : rs1Data)) : 32'b0;
    assign bb = bj ? (forwardB[0] ? ex_mem_rdData : (forwardB[1] ? mem_wb_rdData : rs2Data)) : 32'b0;

    assign pcSel = bj[0] || (bj[1] && zero) ? 1'b1 : 1'b0;

    alu u_alu(
            .a      (a      ),
            .b      (b      ),
            .ALUOp  (ALUOp  ),
            .result (result )
        );


    bu u_bu(
           .a       (ba     ),
           .b       (bb     ),
           .func3   (BOp    ),
           .zero 	(zero   )
       );

endmodule
