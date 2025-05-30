`include "defines.v"

// Instructure ROM

module instrROM (
        input               clk,
        input               rst,
        input   wire [31:0] instrAddr,
        output  reg  [31:0] instr
    );

    reg [`BITWIDTH - 1:0] rom_mem[0:4095];

    integer i;

    always @(*) begin
        instr = rom_mem[instrAddr>>2];//除以4
    end

    always @(posedge clk) begin
        if (rst == `RESET) begin
            for (i = 0;i < 4095;i = i + 1) begin
                rom_mem[i] <= 32'b0;
            end
        end
    end

endmodule
