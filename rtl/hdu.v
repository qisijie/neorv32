`include "defines.v"

// Hazard detection unit

module hdu (
        input   wire [1:0]  id_ex_wbSel,
        input   wire [4:0]  id_ex_rdAddr,
        input   wire [4:0]  rs1Addr,
        input   wire [4:0]  rs2Addr,
        output  wire        pcWrite,
        output  wire        if_dWrite,
        output  wire        stall
    );

    wire flag = (id_ex_wbSel == 2'b00 && ((id_ex_rdAddr == rs1Addr || id_ex_rdAddr == rs2Addr))) && (id_ex_rdAddr != 32'b0) && (rs1Addr != 32'b0) && (rs2Addr != 32'b0);

    assign pcWrite    = flag ? 1'b1 : 1'b0;
    assign if_dWrite  = flag ? 1'b1 : 1'b0;
    assign stall      = flag ? 1'b1 : 1'b0;

endmodule
