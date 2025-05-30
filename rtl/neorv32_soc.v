module neorv32_soc (
        input wire clk,
        input wire rst
    );

    wire [31:0] instr;
    wire [31:0] instrAddr;

    // output declaration of module neorv32

    neorv32 u_neorv32(
                .clk       	(clk        ),
                .rst       	(rst        ),
                .instr     	(instr      ),
                .instrAddr 	(instrAddr  )
            );

    // output declaration of module instrROM

    instrROM u_instrROM(
                 .instrAddr (instrAddr  ),
                 .instr     (instr      )
             );

endmodule
