`include "defines.v"


module dualRAM #(
        parameter    DATAWIDTH = 32,
        parameter    ADDRWIDTH = 12,
        parameter    MEM_NUM = 4096
    ) (
        input   wire                        clk,
        input   wire                        rst,
        input   wire                        wen,
        input   wire [ADDRWIDTH - 1 : 0]    wAddr,
        input   wire [DATAWIDTH - 1 : 0]    wData,
        input   wire                        ren,
        input   wire [ADDRWIDTH - 1 : 0]    rAddr,
        output  wire [DATAWIDTH - 1 : 0]    rData
    );

    wire [DATAWIDTH - 1:0] rData_wire;

    reg rd_wr_equ_flag;
    reg [DATAWIDTH - 1:0] wData_reg;

    assign rData = rd_wr_equ_flag ? wData_reg : rData_wire;

    always @(posedge clk) begin
        wData_reg <= wData;
    end

    always @(posedge clk) begin
        rd_wr_equ_flag <= (rst && wen && ren && (wAddr == rAddr)) ? 1'b1 : 1'b0;
    end

    dualRAM_template #(
                         .DATAWIDTH  (DATAWIDTH),
                         .ADDRWIDTH  (ADDRWIDTH),
                         .MEM_NUM    (MEM_NUM)
                     ) u_dualRAM_template(
                         .clk    (clk),
                         .rst    (rst),
                         .wen    (wen),
                         .wAddr  (wAddr),
                         .wData  (wData),
                         .ren    (ren),
                         .rAddr  (rAddr),
                         .rData  (rData_wire)
                     );
endmodule

module dualRAM_template #(
        parameter    DATAWIDTH = 32,
        parameter    ADDRWIDTH = 12,
        parameter    MEM_NUM = 4096
    ) (
        input   wire                        clk,
        input   wire                        rst,
        input   wire                        wen,
        input   wire [ADDRWIDTH - 1 : 0]    wAddr,
        input   wire [DATAWIDTH - 1 : 0]    wData,
        input   wire                        ren,
        input   wire [ADDRWIDTH - 1 : 0]    rAddr,
        output  wire [DATAWIDTH - 1 : 0]    rData
    );

    reg [DATAWIDTH - 1:0] memory [0:MEM_NUM - 1];
    integer i;

    assign rData = memory[rAddr];

    always @(posedge clk) begin
        if (rst == `RESET) begin
            for (i = 0;i < MEM_NUM;i = i + 1) begin
                memory[i] <= 32'b0;
            end
        end
        else if (wen) begin
            memory[wAddr] <= wData;
        end
    end

endmodule
