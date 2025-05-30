`include "defines.v"

// Instruction Decode to Execute

module id_ex (
        input   wire                    clk,
        input   wire                    rst,
        input   wire [31:0]             pcAddr,
        input   wire [4:0]              rs1Addr,
        input   wire [4:0]              rs2Addr,
        input   wire [4:0]              rdAddr,
        input   wire [`BITWIDTH - 1:0]  rs1Data,
        input   wire [`BITWIDTH - 1:0]  rs2Data,
        input   wire [`BITWIDTH - 1:0]  immData,
        input   wire                    rwen,
        input   wire                    mwen,
        input   wire                    ASel,
        input   wire                    BSel,
        input   wire [1:0]              bj,
        input   wire [1:0]              wbSel,
        input   wire [2:0]              lsWidth,
        input   wire [3:0]              ALUOp,
        input   wire [2:0]              BOp,
        output  reg [31:0]              pcAddrNext,
        output  reg [4:0]               rs1AddrNext,
        output  reg [4:0]               rs2AddrNext,
        output  reg [4:0]               rdAddrNext,
        output  reg [`BITWIDTH - 1:0]   rs1DataNext,
        output  reg [`BITWIDTH - 1:0]   rs2DataNext,
        output  reg [`BITWIDTH - 1:0]   immDataNext,
        output  reg                     rwenNext,
        output  reg                     mwenNext,
        output  reg                     ASelNext,
        output  reg                     BSelNext,
        output  reg [1:0]               bjNext,
        output  reg [1:0]               wbSelNext,
        output  reg [2:0]               lsWidthNext,
        output  reg [3:0]               ALUOpNext,
        output  reg [2:0]               BOpNext
    );

    always @(posedge clk) begin
        if (rst == `RESET) begin
            pcAddrNext  <= 32'b0;
            rs1AddrNext <= 5'b0;
            rs2AddrNext <= 5'b0;
            rdAddrNext  <= 5'b0;
            rs1DataNext <= 32'b0;
            rs2DataNext <= 32'b0;
            immDataNext <= 32'b0;
            rwenNext    <= 1'b0;
            mwenNext    <= 1'b0;
            ASelNext    <= 1'b0;
            BSelNext    <= 1'b0;
            bjNext      <= 2'b0;
            wbSelNext   <= 2'b0;
            lsWidthNext <= 3'b0;
            ALUOpNext   <= 4'b0;
            BOpNext     <= 3'b0;
        end
        else begin
            pcAddrNext  <= pcAddr;
            rs1AddrNext <= rs1Addr;
            rs2AddrNext <= rs2Addr;
            rdAddrNext  <= rdAddr;
            rs1DataNext <= rs1Data;
            rs2DataNext <= rs2Data;
            immDataNext <= immData;
            rwenNext    <= rwen;
            mwenNext    <= rwen;
            ASelNext    <= ASel;
            BSelNext    <= BSel;
            bjNext      <= bj;
            wbSelNext   <= wbSel;
            lsWidthNext <= lsWidth;
            ALUOpNext   <= ALUOp;
            BOpNext     <= BOp;
        end

    end
endmodule
