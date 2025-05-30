
module tb();
    reg clk;
    reg rst;

    wire x3 = tb.u_neorv32_soc.u_neorv32.u_id.u_regs.registers[5];
    wire x26 = tb.u_neorv32_soc.u_neorv32.u_id.u_regs.registers[26];
    wire x27 = tb.u_neorv32_soc.u_neorv32.u_id.u_regs.registers[27];

    integer r;

    always #10 clk = ~clk;

    initial begin
        clk <= 1'b1;
        rst <= 1'b0;

        #30;
        rst <= 1'b1;
    end

    initial begin
        $readmemh("F:\\Verilog\\neorv32\\tb\\tast\\rv32ui-p-add.txt", tb.u_neorv32_soc.u_instrROM.rom_mem);
    end

    initial begin
        wait(x26);

        #200;
        if (x27 == 32'b1) begin
            $display("pass");
        end
        else begin
            $display("fail");
            $display("gp:%d", tb.u_neorv32_soc.u_neorv32.u_id.u_regs.registers[3]);
            for (r = 0;r<32;r = r + 1) begin
                $display("x%2d:%d", r, tb.u_neorv32_soc.u_neorv32.u_id.u_regs.registers[r]);
            end
        end
    end

    neorv32_soc u_neorv32_soc(
                    .clk   	(clk    ),
                    .rst   	(rst    )
                );

endmodule //tb
