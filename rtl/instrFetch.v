`include "defines.v"

// Instructure Fetch

module instrFetch (
        input   wire        clk,
        input   wire        rst,
        input   wire [31:0] bjAddr,
        input   wire        pcSel,
        input   wire        pcWrite,
        output  wire [31:0] pcAddr
    );

    wire [31:0] currentAddr;
    wire [31:0] nextAddr;

    assign pcAddr = currentAddr;
    assign nextAddr = pcSel ? bjAddr : currentAddr + 3'd4;

    pc u_pc(
           .clk         	(clk          ),
           .rst         	(rst          ),
           .pcWrite     	(pcWrite      ),
           .nextAddr    	(nextAddr     ),
           .currentAddr 	(currentAddr  )
       );

endmodule
