module remote (
    input reset, clk_pll, IRDA_RXD,
    output reg [1:0] cor,
    output reg [2:0] botao,
    output reg ready
);

    parameter START = 4'b0000,
              S0 = 4'b0001,
              S1 = 4'b0010,
              S2 = 4'b0011,
              S3 = 4'b0100,
              S4 = 4'b0101,
              S5 = 4'b0110,
              S6 = 4'b0111,
              S7 = 4'b1000,
              S8 = 4'b1001,
              S9 = 4'b1010,
              S10 = 4'b1011,
              S11 = 4'b1100;

    parameter POS_1 = 8'b11000001,
              POS_2 = 8'b11101010,
              POS_3 = 8'b11111110;

    reg [3:0] state;
    reg [3:0] next_state;

    reg [7:0] counter_botao;
    reg [7:0] counter_random;

    always @(posedge clk_pll) begin
        if (reset) begin
            cor <= 2'b00;
            botao <= 3'b000;
            ready <= 1'b0;
        end else begin
            case (state)
                START: begin
                    counter_random <= 1'b0;
                end

                S0: begin
                    counter_random <= counter_random + 1'b1;
                    cor <= counter_random;
                end

                S1: begin
                    counter_botao <= 1'b0;
                end

                S2: begin
                    counter_botao <= counter_botao + 1'b1;
                end

                S3: begin
                    botao[2] <= IRDA_RXD;
                end

                S4: begin
                    counter_botao <= counter_botao + 1'b1;
                end

                S5: begin
                    botao[1] <= IRDA_RXD;
                end

                S6: begin
                    counter_botao <= counter_botao + 1'b1;
                end

                S7: begin
                    botao[0] <= IRDA_RXD;
                end

                S8: begin
                    ready <= 1'b1;
                end

                S9: begin
                    ready <= 1'b1;
                end

                S10: begin
                    ready <= 1'b1;
                end

                S11: begin
                    ready <= 1'b1;
                end
            endcase
        end
    end

    always @(posedge clk_pll) begin
        next_state = START;

        if (reset) begin
            next_state = START;
        end else begin
            case (state)
                START: begin
                    next_state = S0;
                end

                S0: begin
                    if (IRDA_RXD == 1'b0) begin
                        next_state = S1;
                    end else begin
                        next_state = S0;
                    end
                end

                S1: begin
                    next_state = S2;
                end

                S2: begin
                    if (counter_botao >= POS_1) begin
                        next_state = S3;
                    end else begin
                        next_state = S2;
                    end
                end

                S3: begin
                    next_state = S4;
                end

                S4: begin
                    if (counter_botao >= POS_2) begin
                        next_state = S5;
                    end else begin
                        next_state = S4;
                    end
                end

                S5: begin
                    next_state = S6;
                end

                S6: begin
                    if (counter_botao >= POS_3) begin
                        next_state = S7;
                    end else begin
                        next_state = S6;
                    end
                end

                S7: begin
                    case (botao)
                        3'b100: begin
                            next_state = S8;
                        end

                        3'b011: begin
                            next_state = S8;
                        end

                        3'b110: begin
                            next_state = S8;
                        end

                        3'b010: begin
                            next_state = S8;
                        end

                        3'b001: begin
                            next_state = S8;
                        end

                        default: begin
                            next_state = START;
                        end
                    endcase
                end

                S8: begin
                    next_state = S9;
                end

                S9: begin
                    next_state = S10;
                end

                S10: begin
                    next_state = S11;
                end

                S11: begin
                    next_state = START;
                end
            endcase
        end
    end

    always @(posedge clk_pll) begin
        state <= next_state;
    end

endmodule
