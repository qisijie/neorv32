`include "defines.v"

// Registers

module regs (
        input   wire                    clk,
        input   wire                    rst,
        input   wire                    wen,
        input   wire [4:0]              rdAddr,
        input   wire [4:0]              rs1Addr,
        input   wire [4:0]              rs2Addr,
        input   wire [`BITWIDTH - 1:0]  rdData,
        output  wire [`BITWIDTH - 1:0]  rs1Data,
        output  wire [`BITWIDTH - 1:0]  rs2Data
    );

    reg [`BITWIDTH - 1:0] registers [0:31];
    integer i;

    assign rs1Data = rs1Addr ? ((rs1Addr == rdAddr) ? rdData : registers[rs1Addr]) : 32'b0; // zero is always 0
    assign rs2Data = rs2Addr ? ((rs2Addr == rdAddr) ? rdData : registers[rs2Addr]) : 32'b0; // zero is always 0

    always @(posedge clk) begin
        if (rst == `RESET) begin
            for (i = 0;i < 32;i = i + 1) begin
                registers[i] <= 32'b0;
            end
        end
        else if (rdAddr != 5'b0 && wen) begin
            registers[rdAddr] <= rdData;
        end
        else begin
            registers[0] <= 32'b0; // zero is always 0
        end
    end

endmodule
