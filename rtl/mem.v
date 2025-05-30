`include "defines.v"

// Memory

module mem (
        input   wire                    clk,
        input   wire                    rst,
        input   wire [31:0]             pcAddr,
        input   wire                    mwen,
        input   wire [2:0]              lsWidth,
        input   wire [`BITWIDTH - 1:0]  lsAddr,
        input   wire [`BITWIDTH - 1:0]  osData,
        output  wire [31:0]             pcP4,
        output  wire [`BITWIDTH - 1:0]  lData
    );

    assign pcP4 = pcAddr + 3'd4;

    wire [`BITWIDTH - 1:0]  olData;
    wire [`BITWIDTH - 1:0]  sData;

    assign lData = (lsWidth == 3'd0) ? {24'b0,olData[7:0]} : ((lsWidth == 3'd1 ) ? {16'b0,olData[15:0]} : ((lsWidth == 3'd2 ) ? olData[31:0] : (lsWidth == 3'd4 ) ? {{24{olData[7]}},olData[7:0]} : (lsWidth == 3'd5 ) ? {{16{olData[15]}},olData[15:0]} : 32'b0));
    assign sData = (lsWidth == 3'd0) ? {24'b0,osData[7:0]} : ((lsWidth == 3'd1 ) ? {16'b0,osData[15:0]} : ((lsWidth == 3'd2 ) ? osData[31:0] : 32'b0));

    ram u_ram(
            .clk   	(clk    ),
            .rst   	(rst    ),
            .wen   	(mwen   ),
            .wAddr 	(lsAddr ),
            .wData 	(sData  ),
            .ren   	(1'b1   ),
            .rAddr 	(lsAddr ),
            .rData 	(olData )
        );

endmodule
