`include "defines.v"

// Write Back

module wb (
        input   wire [1:0]              wbSel,
        input   wire [`BITWIDTH - 1:0]  pcP4,
        input   wire [`BITWIDTH - 1:0]  result,
        input   wire [`BITWIDTH - 1:0]  lData,
        output  wire [`BITWIDTH - 1:0]  rdData
    );

    assign rdData = wbSel == 2'b10 ? pcP4 : (wbSel == 2'b00 ? lData : result);

endmodule
