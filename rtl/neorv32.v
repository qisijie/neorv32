`include "defines.v"

module neorv32 (
        input   wire        clk,
        input   wire        rst,
        input   wire [31:0] instr, // from rom
        output  wire [31:0] instrAddr
    );

    // if
    wire [31:0]             if_pcAddr;

    // if_id
    wire [31:0]             if_id_instr;
    wire [31:0]             if_id_pcAddr;

    //id
    wire [4:0]              id_rs1Addr;
    wire [4:0]              id_rs2Addr;
    wire [4:0]              id_rdAddr;
    wire [`BITWIDTH - 1:0]  id_rs1Data;
    wire [`BITWIDTH - 1:0]  id_rs2Data;
    wire [`BITWIDTH - 1:0]  id_immData;
    wire                    id_rwen;
    wire                    id_mwen;
    wire                    id_ASel;
    wire                    id_BSel;
    wire [1:0]              id_bj;
    wire [1:0]              id_wbSel;
    wire [2:0]              id_lsWidth;
    wire [3:0]              id_ALUOp;
    wire [2:0]              id_BOp;
    wire                    pcWrite;
    wire                    if_dWrite;

    // id_ex
    wire [31:0]             id_ex_pcAddr;
    wire [4:0]              id_ex_rs1Addr;
    wire [4:0]              id_ex_rs2Addr;
    wire [4:0]              id_ex_rdAddr;
    wire [`BITWIDTH - 1:0]  id_ex_rs1Data;
    wire [`BITWIDTH - 1:0]  id_ex_rs2Data;
    wire [`BITWIDTH - 1:0]  id_ex_immData;
    wire                    id_ex_rwen;
    wire                    id_ex_mwen;
    wire                    id_ex_ASel;
    wire                    id_ex_BSel;
    wire [1:0]              id_ex_bj;
    wire [1:0]              id_ex_wbSel;
    wire [2:0]              id_ex_lsWidth;
    wire [3:0]              id_ex_ALUOp;
    wire [2:0]              id_ex_BOp;

    // ex
    wire [`BITWIDTH - 1:0]  ex_mem_rdData;
    wire [`BITWIDTH - 1:0]  mem_wb_rdData;
    wire [`BITWIDTH - 1:0]  ex_result;
    wire                    ex_pcSel;

    // ex_mem
    wire [31:0]             ex_mem_pcAddr;
    wire [4:0]              ex_mem_rdAddr;
    wire                    ex_mem_rwen;
    wire                    ex_mem_mwen;
    wire [1:0]              ex_mem_wbSel;
    wire [2:0]              ex_mem_lsWidth;
    wire [`BITWIDTH - 1:0]  ex_mem_result;
    wire                    ex_mem_pcSel;
    wire [`BITWIDTH - 1:0]  ex_mem_rs2Data;

    // mem
    wire [`BITWIDTH - 1:0]  mem_pcP4;
    wire [`BITWIDTH - 1:0]  mem_lData;

    // mem_wb
    wire                    mem_wb_rwen;
    wire [1:0]              mem_wb_wbSel;
    wire [4:0]              mem_wb_rdAddr;
    wire [`BITWIDTH - 1:0]  mem_wb_pcP4;
    wire [`BITWIDTH - 1:0]  mem_wb_result;
    wire [`BITWIDTH - 1:0]  mem_wb_lData;

    // wb
    wire [`BITWIDTH - 1:0]  wb_rdData;

    // fu
    wire [1:0]              forwardA;
    wire [1:0]              forwardB;

    assign instrAddr = if_pcAddr;

    assign id_ex_rdData = ex_result;
    assign ex_mem_rdData = ex_mem_result;
    assign mem_wb_rdData = wb_rdData;

    instrFetch u_instrFetch(
                   .clk     	(clk        ),
                   .rst     	(rst        ),
                   .bjAddr  	(ex_result  ),
                   .pcSel   	(ex_pcSel   ),
                   .pcWrite 	(pcWrite    ),
                   .pcAddr  	(if_pcAddr  )
               );

    if_id u_if_id(
              .clk        	(clk            ),
              .rst        	(rst            ),
              .pcAddr     	(if_pcAddr      ),
              .instr      	(instr          ),
              .if_dWrite  	(if_dWrite      ),
              .instrNext  	(if_id_instr    ),
              .pcAddrNext 	(if_id_pcAddr   )
          );

    id u_id(
           .clk          	(clk            ),
           .rst          	(rst            ),
           .mem_wb_rwen     (mem_wb_rwen    ),
           .mem_wb_rdAddr   (mem_wb_rdAddr  ),
           .wb_rdData       (wb_rdData      ),
           .if_id_instr     (if_id_instr    ),
           .id_ex_rwen   	(id_ex_rwen     ),
           .id_ex_wbSel   	(id_ex_wbSel    ),
           .id_ex_rdAddr 	(id_ex_rdAddr   ),
           .ex_pcSel        (ex_pcSel       ),
           .rs1Addr      	(id_rs1Addr     ),
           .rs2Addr      	(id_rs2Addr     ),
           .rdAddr       	(id_rdAddr      ),
           .rs1Data      	(id_rs1Data     ),
           .rs2Data      	(id_rs2Data     ),
           .immData      	(id_immData     ),
           .rwen         	(id_rwen        ),
           .mwen         	(id_mwen        ),
           .ASel         	(id_ASel        ),
           .BSel         	(id_BSel        ),
           .bj        	    (id_bj          ),
           .wbSel        	(id_wbSel       ),
           .lsWidth      	(id_lsWidth     ),
           .ALUOp        	(id_ALUOp       ),
           .BOp             (id_BOp         ),
           .pcWrite      	(pcWrite        ),
           .if_dWrite    	(if_dWrite      )
       );

    id_ex u_id_ex(
              .clk         	(clk            ),
              .rst         	(rst            ),
              .pcAddr      	(if_id_pcAddr   ),
              .rs1Addr     	(id_rs1Addr     ),
              .rs2Addr     	(id_rs2Addr     ),
              .rdAddr      	(id_rdAddr      ),
              .rs1Data     	(id_rs1Data     ),
              .rs2Data     	(id_rs2Data     ),
              .immData     	(id_immData     ),
              .rwen        	(id_rwen        ),
              .mwen        	(id_mwen        ),
              .ASel        	(id_ASel        ),
              .BSel        	(id_BSel        ),
              .bj           (id_bj          ),
              .wbSel       	(id_wbSel       ),
              .lsWidth     	(id_lsWidth     ),
              .ALUOp       	(id_ALUOp       ),
              .BOp          (id_BOp         ),
              .pcAddrNext  	(id_ex_pcAddr   ),
              .rs1AddrNext 	(id_ex_rs1Addr  ),
              .rs2AddrNext 	(id_ex_rs2Addr  ),
              .rdAddrNext  	(id_ex_rdAddr   ),
              .rs1DataNext 	(id_ex_rs1Data  ),
              .rs2DataNext 	(id_ex_rs2Data  ),
              .immDataNext 	(id_ex_immData  ),
              .rwenNext    	(id_ex_rwen     ),
              .mwenNext    	(id_ex_mwen     ),
              .ASelNext    	(id_ex_ASel     ),
              .BSelNext    	(id_ex_BSel     ),
              .bjNext   	(id_ex_bj       ),
              .wbSelNext   	(id_ex_wbSel    ),
              .lsWidthNext 	(id_ex_lsWidth  ),
              .ALUOpNext   	(id_ex_ALUOp    ),
              .BOpNext      (id_ex_BOp      )
          );

    ex u_ex(
           .pcAddr        	(id_ex_pcAddr   ),
           .rs1Data       	(id_ex_rs1Data  ),
           .rs2Data       	(id_ex_rs2Data  ),
           .immData       	(id_ex_immData  ),
           .ASel          	(id_ex_ASel     ),
           .BSel          	(id_ex_BSel     ),
           .bj              (id_ex_bj       ),
           .ALUOp         	(id_ex_ALUOp    ),
           .BOp             (id_ex_BOp      ),
           .forwardA      	(forwardA       ),
           .forwardB      	(forwardB       ),
           .ex_mem_rdData 	(ex_mem_rdData  ),
           .mem_wb_rdData 	(mem_wb_rdData  ),
           .result        	(ex_result      ),
           .pcSel           (ex_pcSel       )
       );

    ex_mem u_ex_mem(
               .clk         (clk            ),
               .rst         (rst            ),
               .pcAddr      (id_ex_pcAddr   ),
               .rdAddr      (id_ex_rdAddr   ),
               .rwen        (id_ex_rwen     ),
               .mwen        (id_ex_mwen     ),
               .wbSel       (id_ex_wbSel    ),
               .lsWidth     (id_ex_lsWidth  ),
               .result      (ex_result      ),
               .pcSel       (ex_pcSel       ),
               .rs2Data     (id_ex_rs2Data  ),
               .pcAddrNext  (ex_mem_pcAddr  ),
               .rdAddrNext  (ex_mem_rdAddr  ),
               .rwenNext    (ex_mem_rwen    ),
               .mwenNext    (ex_mem_mwen    ),
               .wbSelNext   (ex_mem_wbSel   ),
               .lsWidthNext (ex_mem_lsWidth ),
               .resultNext  (ex_mem_result  ),
               .pcSelNext   (ex_mem_pcSel   ),
               .rs2DataNext (ex_mem_rs2Data )
           );

    mem u_mem(
            .clk        (clk            ),
            .rst        (rst            ),
            .pcAddr  	(ex_mem_pcAddr  ),
            .mwen    	(ex_mem_mwen    ),
            .lsWidth 	(ex_mem_lsWidth ),
            .lsAddr   	(ex_mem_result  ),
            .osData  	(ex_mem_rs2Data ),
            .pcP4    	(mem_pcP4       ),
            .lData   	(mem_lData      )
        );

    mem_wb u_mem_wb(
               .clk        	(clk            ),
               .rst        	(rst            ),
               .rwen       	(ex_mem_rwen    ),
               .wbSel      	(ex_mem_wbSel   ),
               .rdAddr     	(ex_mem_rdAddr  ),
               .pcP4       	(mem_pcP4       ),
               .result     	(ex_mem_result  ),
               .lData      	(mem_lData      ),
               .rwenNext   	(mem_wb_rwen    ),
               .wbSelNext  	(mem_wb_wbSel   ),
               .rdAddrNext 	(mem_wb_rdAddr  ),
               .pcP4Next   	(mem_wb_pcP4    ),
               .resultNext 	(mem_wb_result  ),
               .lDataNext  	(mem_wb_lData   )
           );

    wb u_wb(
           .wbSel  	(mem_wb_wbSel   ),
           .pcP4   	(mem_pcP4       ),
           .result 	(mem_wb_result  ),
           .lData  	(mem_lData      ),
           .rdData 	(wb_rdData      )
       );


    fu u_fu(
           .rs1         (id_ex_rs1Addr  ),
           .rs2         (id_ex_rs2Addr  ),
           .ex_mem_rd   (ex_mem_rdAddr  ),
           .mem_wb_rd   (mem_wb_rdAddr  ),
           .ex_mem_rwen (ex_mem_rwen    ),
           .mem_wb_rwen (mem_wb_rwen    ),
           .forwardA    (forwardA       ),
           .forwardB    (forwardB       )
       );

endmodule
