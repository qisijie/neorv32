`include "defines.v"

// Memory to Write Back

module mem_wb (
        input   wire                    clk,
        input   wire                    rst,
        input   wire                    rwen,
        input   wire [1:0]              wbSel,
        input   wire [4:0]              rdAddr,
        input   wire [`BITWIDTH - 1:0]  pcP4,
        input   wire [`BITWIDTH - 1:0]  result,
        input   wire [`BITWIDTH - 1:0]  lData,
        output  reg                     rwenNext,
        output  reg [1:0]               wbSelNext,
        output  reg [4:0]               rdAddrNext,
        output  reg [`BITWIDTH - 1:0]   pcP4Next,
        output  reg [`BITWIDTH - 1:0]   resultNext,
        output  reg [`BITWIDTH - 1:0]   lDataNext
    );

    always @(posedge clk) begin
        if (rst == `RESET) begin
            rwenNext    <= 1'b0;
            wbSelNext   <= 2'b0;
            rdAddrNext  <= 5'b0;
            pcP4Next    <= 32'b0;
            resultNext  <= 32'b0;
            lDataNext   <= 32'b0;
        end
        else begin
            rwenNext    <= rwen;
            wbSelNext   <= wbSel;
            rdAddrNext  <= rdAddr;
            pcP4Next    <= pcP4;
            resultNext  <= result;
            lDataNext   <= lData;
        end

    end

endmodule
