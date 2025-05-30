`include "defines.v"

// Instruction Decode

module id (
        input   wire                    clk,
        input   wire                    rst,
        input   wire                    mem_wb_rwen,
        input   wire [4:0]              mem_wb_rdAddr,
        input   wire [`BITWIDTH - 1:0]  wb_rdData,
        input   wire [31:0]             if_id_instr,
        input   wire                    id_ex_rwen,
        input   wire [1:0]              id_ex_wbSel,
        input   wire [4:0]              id_ex_rdAddr,
        input   wire                    ex_pcSel,
        output  wire [4:0]              rs1Addr,
        output  wire [4:0]              rs2Addr,
        output  wire [4:0]              rdAddr,
        output  wire [`BITWIDTH - 1:0]  rs1Data,
        output  wire [`BITWIDTH - 1:0]  rs2Data,
        output  wire [`BITWIDTH - 1:0]  immData,
        output  wire                    rwen,
        output  wire                    mwen,
        output  wire                    ASel,
        output  wire                    BSel,
        output  wire [1:0]              bj,
        output  wire [1:0]              wbSel,
        output  wire [2:0]              lsWidth,
        output  wire [3:0]              ALUOp,
        output  wire [2:0]              BOp,
        output  wire                    pcWrite,
        output  wire                    if_dWrite
    );

    wire stall;

    wire [31:0] instr = ex_pcSel ? `INST_NOP : if_id_instr;

    wire [6:0]  opcode  = instr[6:0];
    wire [2:0]  func3   = instr[14:12];
    wire [6:0]  func7   = instr[31:25];

    assign rdAddr  = instr[11:7];
    assign rs1Addr = opcode == `INST_LUI ? 32'b0 : instr[19:15];
    assign rs2Addr = instr[24:20];

    hdu u_hdu(
            .id_ex_wbSel    (id_ex_wbSel    ),
            .id_ex_rdAddr  	(id_ex_rdAddr   ),
            .rs1Addr 	    (rs1Addr        ),
            .rs2Addr 	    (rs2Addr        ),
            .pcWrite       	(pcWrite        ),
            .if_dWrite     	(if_dWrite      ),
            .stall         	(stall          )
        );

    ctrl u_ctrl(
             .opcode 	(opcode     ),
             .func3  	(func3      ),
             .func7  	(func7      ),
             .stall     (stall      ),
             .rwen      (rwen       ),
             .mwen      (mwen       ),
             .ASel   	(ASel       ),
             .BSel   	(BSel       ),
             .bj        (bj         ),
             .wbSel     (wbSel      ),
             .lsWidth   (lsWidth    ),
             .ALUOp  	(ALUOp      ),
             .BOp       (BOp        )
         );

    regs u_regs(
             .clk     	(clk            ),
             .rst     	(rst            ),
             .wen     	(mem_wb_rwen    ),
             .rdAddr  	(mem_wb_rdAddr  ),
             .rs1Addr 	(rs1Addr        ),
             .rs2Addr 	(rs2Addr        ),
             .rdData  	(wb_rdData      ),
             .rs1Data 	(rs1Data        ),
             .rs2Data 	(rs2Data        )
         );

    immGen u_immGen(
               .opcode 	(opcode     ),
               .instr  	(instr      ),
               .imm    	(immData    )
           );

endmodule
