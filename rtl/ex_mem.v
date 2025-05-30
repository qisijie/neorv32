`include "defines.v"

// Execute to Memory

module ex_mem (
        input   wire                    clk,
        input   wire                    rst,
        input   wire [31:0]             pcAddr,
        input   wire [4:0]              rdAddr,
        input   wire                    rwen,
        input   wire                    mwen,
        input   wire [1:0]              wbSel,
        input   wire [2:0]              lsWidth,
        input   wire [`BITWIDTH - 1:0]  result,
        input   wire                    pcSel,
        input   wire [`BITWIDTH - 1:0]  rs2Data,
        output  reg [31:0]              pcAddrNext,
        output  reg [4:0]               rdAddrNext,
        output  reg                     rwenNext,
        output  reg                     mwenNext,
        output  reg [1:0]               wbSelNext,
        output  reg [2:0]               lsWidthNext,
        output  reg [`BITWIDTH - 1:0]   resultNext,
        output  reg                     pcSelNext,
        output  reg [`BITWIDTH - 1:0]   rs2DataNext
    );

    always @(posedge clk) begin
        if (rst == `RESET) begin
            pcAddrNext  <= 32'b0;
            rdAddrNext  <= 5'b0;
            rwenNext    <= 1'b0;
            mwenNext    <= 1'b0;
            pcSelNext   <= 1'b0;
            wbSelNext   <= 2'b0;
            lsWidthNext <= 3'b0;
            resultNext  <= 32'b0;
            rs2DataNext <= 32'b0;
        end
        else begin
            pcAddrNext  <= pcAddr;
            rdAddrNext  <= rdAddr;
            rwenNext    <= rwen;
            mwenNext    <= mwen;
            pcSelNext   <= pcSel;
            wbSelNext   <= wbSel;
            lsWidthNext <= lsWidth;
            resultNext  <= result;
            rs2DataNext <= rs2Data;
        end
    end

endmodule
