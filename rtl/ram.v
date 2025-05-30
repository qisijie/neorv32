`include "defines.v"

module ram (
        input   wire                    clk,
        input   wire                    rst,
        input   wire                    wen,
        input   wire [31 : 0]           wAddr,
        input   wire [`BITWIDTH -1:0]   wData,
        input   wire                    ren,
        input   wire [31 : 0]           rAddr,
        output  wire [`BITWIDTH- 1:0]   rData
    );

    wire [11:0] waddr = wAddr[13:2];
    wire [11:0] raddr = rAddr[13:2];

    dualRAM #(
                .DATAWIDTH 	(8),
                .ADDRWIDTH 	(12),
                .MEM_NUM   	(4096))
            u_byte0(
                .clk   	(clk            ),
                .rst   	(rst            ),
                .wen   	(wen            ),
                .wAddr 	(waddr          ),
                .wData 	(wData[7:0]     ),
                .ren   	(ren            ),
                .rAddr 	(raddr          ),
                .rData 	(rData[7:0]     )
            );

    dualRAM #(
                .DATAWIDTH 	(8),
                .ADDRWIDTH 	(12),
                .MEM_NUM   	(4096))
            u_byte1(
                .clk   	(clk            ),
                .rst   	(rst            ),
                .wen   	(wen            ),
                .wAddr 	(waddr          ),
                .wData 	(wData[15:8]    ),
                .ren   	(ren            ),
                .rAddr 	(raddr          ),
                .rData 	(rData[15:8]    )
            );

    dualRAM #(
                .DATAWIDTH 	(8),
                .ADDRWIDTH 	(12),
                .MEM_NUM   	(4096))
            u_byte2(
                .clk   	(clk            ),
                .rst   	(rst            ),
                .wen   	(wen            ),
                .wAddr 	(waddr          ),
                .wData 	(wData[23:16]   ),
                .ren   	(ren            ),
                .rAddr 	(raddr          ),
                .rData 	(rData[23:16]   )
            );

    dualRAM #(
                .DATAWIDTH 	(8),
                .ADDRWIDTH 	(12),
                .MEM_NUM   	(4096))
            u_byte3(
                .clk   	(clk            ),
                .rst   	(rst            ),
                .wen   	(wen            ),
                .wAddr 	(waddr          ),
                .wData 	(wData[31:24]   ),
                .ren   	(ren            ),
                .rAddr 	(raddr          ),
                .rData 	(rData[31:24]   )
            );


endmodule
