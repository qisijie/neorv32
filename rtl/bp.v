`include "defines.v"

// Branch Predictor

module bp (
        input   wire clk,
        input   wire rst,
        input   wire b, // branch
        input   wire previousZero,
        output  wire predictiveZero,
        output  wire correct
    );

    reg [1:0] prediction;
    reg bBuf; // store branch inst

    assign predictiveZero = b ? prediction[1] : 1'b0;
    assign correct = ~(predictiveZero && predictiveZero) && bBuf;

    always @(posedge clk) begin
        if (rst == `RESET) begin
            prediction <= 2'b0;
        end
        else begin
            if (bBuf) begin
                case (prediction)
                    2'b00: begin // Strongly not taken
                        if (previousZero) begin
                            prediction <= 2'b01;
                            bBuf <= 1'b0;
                        end
                        else begin
                            prediction <= 2'b00;
                            bBuf <= 1'b0;
                        end
                    end
                    2'b01: begin // Weakly not taken
                        if (previousZero) begin
                            prediction <= 2'b10;
                            bBuf <= 1'b0;
                        end
                        else begin
                            prediction <= 2'b00;
                            bBuf <= 1'b0;
                        end
                    end
                    2'b10: begin // Weakly taken
                        if (previousZero) begin
                            prediction <= 2'b11;
                            bBuf <= 1'b0;
                        end
                        else begin
                            prediction <= 2'b01;
                            bBuf <= 1'b0;
                        end
                    end
                    2'b11: begin // Strongly taken
                        if (previousZero) begin
                            prediction <= 2'b11;
                            bBuf <= 1'b0;
                        end
                        else begin
                            prediction <= 2'b10;
                            bBuf <= 1'b0;
                        end
                    end
                    default: begin
                        prediction <= 2'b0;
                        bBuf <= 1'b0;
                    end
                endcase
            end
        end
    end

    always @(posedge clk) begin
        if (rst == `RESET) begin
            bBuf <= 1'b0;
        end
        else if(b) begin
            bBuf <= 1'b1;
        end
    end


endmodule
