`include "defines.v"

// Forwarding unit

module fu (
        input   wire [4:0]  rs1,
        input   wire [4:0]  rs2,
        input   wire [4:0]  ex_mem_rd,
        input   wire [4:0]  mem_wb_rd,
        input   wire        ex_mem_rwen,
        input   wire        mem_wb_rwen,
        output  wire [1:0]  forwardA,
        output  wire [1:0]  forwardB
    );

    assign forwardA =
           (ex_mem_rwen // 确保前递数据有效
            && (ex_mem_rd != 32'b0) // reg0 永远为0
            && (ex_mem_rd == rs1)) // 确认是EX冒险
           ? 2'b01 : (
               (mem_wb_rwen // 确保前递数据有效
                && (mem_wb_rd != 32'b0) // reg0 永远为0
                && (mem_wb_rd == rs1)) // 确认是MEM冒险
               ? 2'b10 : 2'b0
           );

    assign forwardB =
           (ex_mem_rwen // 确保前递数据有效
            && (ex_mem_rd != 32'b0) // reg0 永远为0
            && (ex_mem_rd == rs2)) // 确认是EX冒险
           ? 2'b01 : (
               (mem_wb_rwen // 确保前递数据有效
                && (mem_wb_rd != 32'b0) // reg0 永远为0
                && (mem_wb_rd == rs2)) // 确认是MEM冒险
               ? 2'b10 : 2'b0
           );

endmodule
