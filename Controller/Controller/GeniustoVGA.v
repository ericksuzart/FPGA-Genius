module genius(
  // ------ Input
  input VGA_FLAG,
  input VGA_LOSE,
  input VGA_WIN,
  input [1:0] VGA,
  input [2:0] B,
  input RESET,

  // ------ Output
  output reg [7:0] SPRITES_FLAGS  //{BLUE, GREEN, RED, YELLOW, LOSE, WIN, PWR_BTN},
);

reg[2:0] estado_atual;
reg[2:0] estado_futuro;

parameter
    ESPERAR = 0,
    POWER_ON = 1,
    BLUE_STATE = 2,
    GREEN_STATE = 3,
    RED_STATE = 4,
    YELLOW_STATE = 5,
    LOSE = 6,
    WIN = 7;
    
parameter
    BLUE = 2'b00,
    GREEN = 2'b01,
    RED = 2'b10,
    YELLOW = 2'b11;


always @(VGA or VGA_FLAG or VGA_LOSE or VGA_WIN or RESET or B)
  begin
    if (RESET)
    begin
      estado_atual <= ESPERAR;
    end
    else
    begin
      estado_atual <= estado_futuro;
    end
  end

  always @(*) begin //Decodificador de Próximo Estado

    if (RESET) begin
      estado_futuro = ESPERAR;
    end

    case (estado_atual)
      ESPERAR:
      begin
        if (VGA_FLAG == 0 && VGA_LOSE == 0 && VGA_WIN == 0)
            estado_futuro = ESPERAR;
        else if (B == 1)
            estado_futuro = POWER_ON;
        else if (VGA == BLUE && VGA_FLAG == 1)
            estado_futuro = BLUE_STATE;
        else if (VGA == GREEN && VGA_FLAG == 1)
            estado_futuro = GREEN_STATE;
        else if (VGA == RED && VGA_FLAG == 1)
            estado_futuro = RED_STATE;
        else if (VGA == YELLOW && VGA_FLAG == 1)
            estado_futuro = YELLOW_STATE;
        else if (VGA_LOSE == 1)
            estado_futuro = LOSE;
        else if (VGA_WIN == 1)
            estado_futuro = WIN;
      end

      POWER_ON:
      begin
        if (VGA_FLAG == 0 && VGA_LOSE == 0 && VGA_WIN == 0)
            estado_futuro = POWER_ON;
        else if (VGA == BLUE && VGA_FLAG == 1)
            estado_futuro = BLUE_STATE;
        else if (VGA == GREEN && VGA_FLAG == 1)
            estado_futuro = GREEN_STATE;
        else if (VGA == RED && VGA_FLAG == 1)
            estado_futuro = RED_STATE;
        else if (VGA == YELLOW && VGA_FLAG == 1)
            estado_futuro = YELLOW_STATE;
        else if (VGA_LOSE == 1)
            estado_futuro = LOSE;
        else if (VGA_WIN == 1)
            estado_futuro = WIN;
      end

      BLUE:
      begin
        if (VGA == BLUE && VGA_FLAG == 1)
            estado_futuro = BLUE_STATE;
        else if (VGA_FLAG == 0)
            estado_futuro = POWER_ON;
      end

      GREEN:
      begin
        if (VGA == GREEN && VGA_FLAG == 1)
            estado_futuro = GREEN_STATE;
        else if (VGA_FLAG == 0)
            estado_futuro = POWER_ON;
      end

      RED:
      begin
        if (VGA == RED && VGA_FLAG == 1)
            estado_futuro = RED_STATE;
        else if (VGA_FLAG == 0)
            estado_futuro = POWER_ON;
      end

      YELLOW:
      begin
        if (VGA == YELLOW && VGA_FLAG == 1)
            estado_futuro = YELLOW_STATE;
        else if (VGA_FLAG == 0)
            estado_futuro = POWER_ON;
      end

      LOSE:
      begin
        if (VGA_LOSE == 1)
            estado_futuro = LOSE;
        else if (VGA_LOSE == 1)
            estado_futuro = ESPERAR;
      end

      WIN:
      begin
        if (VGA_WIN == 1)
            estado_futuro = WIN;
        else if (VGA_WIN == 0)
            estado_futuro = ESPERAR;
      end
    endcase
  end


  always @(*) begin //Determinar as saídas 

    if (RESET) begin
      SPRITES_FLAGS = 7'b0000000;
    end

    case (estado_atual)
      ESPERAR:
      begin
        SPRITES_FLAGS = 7'b0000000;
      end

      POWER_ON:
      begin
        SPRITES_FLAGS = 7'b0000001;
      end

      BLUE:
      begin
        SPRITES_FLAGS = 7'b1000001;
      end

      GREEN:
      begin
        SPRITES_FLAGS = 7'b0100001;
      end

      RED:
      begin
        SPRITES_FLAGS = 7'b0010001;
      end

      YELLOW:
      begin
        SPRITES_FLAGS = 7'b0001001;
      end

      LOSE:
      begin
        SPRITES_FLAGS = 7'b0000100;
      end

      WIN:
      begin
        SPRITES_FLAGS = 7'b0000010;
      end
    endcase
  end



endmodule

