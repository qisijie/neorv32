`include "defines.v"

// Instructure Fetch to Instruction Decode

module if_id (
        input   wire        clk,
        input   wire        rst,
        input   wire [31:0] pcAddr,
        input   wire [31:0] instr,
        input   wire        if_dWrite,
        output  wire [31:0] instrNext,
        output  wire [31:0] pcAddrNext
    );

        assign pcAddrNext   = pcAddr;
        assign instrNext    = if_dWrite ? `INST_NOP : instr;

    // always @(posedge clk) begin
    //     if (rst == `RESET) begin
    //         instrNext       <= 32'b0;
    //         pcAddrNext      <= 32'b0;
    //     end
    //     else begin
    //         instrNext       <= instr;
    //         pcAddrNext      <= pcAddr;
    //     end
    // end

endmodule
