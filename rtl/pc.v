`include "defines.v"

// Program Counter

module pc(
        input   wire        clk,
        input   wire        rst,
        input   wire        pcWrite,
        input   wire [31:0] nextAddr,
        output  wire [31:0] currentAddr
    );

    reg [31:0] addr;

    assign currentAddr = addr;

    always @(posedge clk) begin
        if (rst == `RESET) begin
            addr = 32'b0;
        end
        else begin
            addr = pcWrite ? addr : nextAddr;
        end
    end
    
endmodule //pc
