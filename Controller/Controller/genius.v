module genius(
  // ------ Input
  input RESET,
  input CLK,
  input R,
  input [2:0] B,
  input [1:0] C,
  input END_1,
  input END_2,

  // ------ Output
  output reg [2:0] B_OUT,
  output reg START_1,
  output reg START_2,
  output reg VGA_FLAG,
  output reg VGA_LOSE,
  output reg VGA_WIN,
  output reg[1:0] VGA,
  output reg[3:0] estado_atual, 
  output reg[3:0] estado_futuro
);
  // Decodificador de botão: R (ready), B (botão), C (cor)
  // Temporizador 1 (tempo de exibição da cor na tela): END_1, START_1
  // Temporizador 2 (tempo para o usuário inserir cor): END_2, START_2

  parameter[2:0] 
    POWER = 1,
    GREEN = 2,
    RED = 3,
    BLUE = 4,
    YELLOW = 6;
  
  // Contadores auxiliares
  reg [15:0] I;
  reg [15:0] J;
  reg signed [15:0] K;

  reg [31:0] SEQ;
  reg [1:0] BTN_USUARIO;

  // Estados
  parameter PREPARAR = 0,
            NOVA_COR = 1,
            BLINK = 2,
            MOSTRA_COR_1 = 3,
            INCREMENTA_J = 4,
            AGUARDANDO = 5,
            AGUARDANDO_BOTAO = 6,
            COMPARA_COR = 7,
            MOSTRA_COR_2 = 8,
            INCREMENTA_I = 9,
            PERDEU = 10,
            GANHOU = 11;

  initial begin
    J=0;
    I=0;
    K=-1;
  end

  always @(posedge CLK)
  begin
    if (RESET)
    begin
      estado_atual <= PREPARAR;
      I <= 0;
    end
    else
    begin
      estado_atual <= estado_futuro;

      if (estado_futuro == PREPARAR)
        I <= 0;
      else if (estado_futuro == INCREMENTA_J)
      begin
        J <= J + 1;
      end
      else if (estado_futuro == INCREMENTA_I)
      begin
        I <= I + 1;
      end
      else if (estado_futuro == AGUARDANDO)
        K <= K + 1;
    end
  end

  // Decodificador próximo estado
  always @(*) begin

    if (RESET) begin
      estado_futuro = PREPARAR;
      I=0;
    end

    case (estado_atual)
      PREPARAR:
      begin
        I=0;
        if (R == 1 && B == POWER)
          estado_futuro = NOVA_COR;
        else
          estado_futuro = PREPARAR;
      end

      NOVA_COR:
      begin
        case(I)
          0:  SEQ[1:0]   <= C;
          1:  SEQ[3:2]   <= C;
          2:  SEQ[5:4]   <= C;
          3:  SEQ[7:6]   <= C;
          4:  SEQ[9:8]   <= C;
          5:  SEQ[11:10] <= C;
          6:  SEQ[13:12] <= C;
          7:  SEQ[15:14] <= C;
          8:  SEQ[17:16] <= C;
          9:  SEQ[19:18] <= C;
          10: SEQ[21:20] <= C;
          11: SEQ[23:22] <= C;
          12: SEQ[25:24] <= C;
          13: SEQ[27:26] <= C;
          14: SEQ[29:28] <= C;
          15: SEQ[31:30] <= C;
          default: SEQ[1:0]<= C;
        endcase
        J=0;
        estado_futuro = BLINK;        
      end
      
      BLINK:
      begin
        estado_futuro = MOSTRA_COR_1;
      end

      MOSTRA_COR_1:
      begin
        if (END_1)
          estado_futuro = INCREMENTA_J;
        else
          estado_futuro = MOSTRA_COR_1;
      end

      INCREMENTA_J:
      begin
        K=-1;
        if (J < I)
          estado_futuro = BLINK;
        else
          estado_futuro = AGUARDANDO;
      end

      AGUARDANDO:
      begin
        estado_futuro = AGUARDANDO_BOTAO;
        if (K > I || K == 1)
          estado_futuro = INCREMENTA_I;
      end

      AGUARDANDO_BOTAO:
      begin
        if (R == 1)
          estado_futuro = COMPARA_COR;
        else if (END_2)
          estado_futuro = PERDEU;
        else
          estado_futuro = AGUARDANDO_BOTAO;
      end

      COMPARA_COR:
      begin

        case(K)
          0:begin
              if (SEQ[1:0] == BTN_USUARIO)
               estado_futuro = MOSTRA_COR_2;
              else
               estado_futuro = PERDEU;
            end
          1:begin
              if (SEQ[3:2] == BTN_USUARIO)
               estado_futuro = MOSTRA_COR_2;
              else
                estado_futuro = PERDEU;
            end
          2:begin
              if (SEQ[5:4] == BTN_USUARIO)
               estado_futuro = MOSTRA_COR_2;
              else
                estado_futuro = PERDEU;
            end
          3:begin
              if (SEQ[7:6] == BTN_USUARIO)
               estado_futuro = MOSTRA_COR_2;
              else
                estado_futuro = PERDEU;
            end
          4:begin
              if (SEQ[9:8] == BTN_USUARIO)
               estado_futuro = MOSTRA_COR_2;
              else
                estado_futuro = PERDEU;
            end
          5:begin
              if (SEQ[11:10] == BTN_USUARIO)
               estado_futuro = MOSTRA_COR_2;
              else
                estado_futuro = PERDEU;
            end
          6:begin
              if (SEQ[13:12] == BTN_USUARIO)
               estado_futuro = MOSTRA_COR_2;
              else
                estado_futuro = PERDEU;
            end
          7:begin
              if (SEQ[15:14] == BTN_USUARIO)
               estado_futuro = MOSTRA_COR_2;
              else
                estado_futuro = PERDEU;
            end
          8:begin
              if (SEQ[17:16] == BTN_USUARIO)
               estado_futuro = MOSTRA_COR_2;
              else
                estado_futuro = PERDEU;
            end
          9:begin
              if (SEQ[19:18] == BTN_USUARIO)
               estado_futuro = MOSTRA_COR_2;
              else
                estado_futuro = PERDEU;
            end
          10:begin
              if (SEQ[21:20] == BTN_USUARIO)
               estado_futuro = MOSTRA_COR_2;
              else
                estado_futuro = PERDEU;
            end
          11:begin
              if (SEQ[23:22] == BTN_USUARIO)
               estado_futuro = MOSTRA_COR_2;
              else
                estado_futuro = PERDEU;
            end
          12:begin
              if (SEQ[25:24] == BTN_USUARIO)
               estado_futuro = MOSTRA_COR_2;
              else
                estado_futuro = PERDEU;
            end
          13:begin
              if (SEQ[27:26] == BTN_USUARIO)
               estado_futuro = MOSTRA_COR_2;
              else
                estado_futuro = PERDEU;
            end
          14:begin
              if (SEQ[29:28] == BTN_USUARIO)
               estado_futuro = MOSTRA_COR_2;
              else
                estado_futuro = PERDEU;
            end
          15:begin
              if (SEQ[31:30] == BTN_USUARIO)
               estado_futuro = MOSTRA_COR_2;
              else
                estado_futuro = PERDEU;
            end
          default: estado_futuro = PERDEU;
        endcase
      end

      MOSTRA_COR_2:
      begin
        if (END_1)
          estado_futuro = AGUARDANDO;
        else
          estado_futuro = MOSTRA_COR_2;
      end
      
      INCREMENTA_I:
      begin
        if (I < 16)
          estado_futuro = NOVA_COR;
        else
          estado_futuro = GANHOU;
      end

      PERDEU:
      begin
        if (B == POWER)
          estado_futuro = PREPARAR;
        else
          estado_futuro = PERDEU;
      end

      GANHOU:
      begin
        if (B == POWER)
          estado_futuro = PREPARAR;
        else
          estado_futuro = GANHOU;
      end
      default: estado_futuro = PREPARAR;
    endcase
  end

  // Setar saídas
  always @(*)
  begin
    START_1 = 0;
    START_2 = 0;
    VGA_FLAG = 0;
    VGA_LOSE = 0;
    VGA_WIN = 0;

    B_OUT = B;

    case (estado_atual)
      BLINK:
      begin
        case(J)
          0:  VGA = SEQ[1:0];
          1:  VGA = SEQ[3:2];
          2:  VGA = SEQ[5:4];
          3:  VGA = SEQ[7:6];
          4:  VGA = SEQ[9:8];
          5:  VGA = SEQ[11:10];
          6:  VGA = SEQ[13:12];
          7:  VGA = SEQ[15:14];
          8:  VGA = SEQ[17:16];
          9:  VGA = SEQ[19:18];
          10: VGA = SEQ[21:20];
          11: VGA = SEQ[23:22];
          12: VGA = SEQ[25:24];
          13: VGA = SEQ[27:26];
          14: VGA = SEQ[29:28];
          15: VGA = SEQ[31:30];
          default: VGA = SEQ[1:0];
        endcase
        START_1 = 1;
      end

      MOSTRA_COR_1:
        VGA_FLAG = 1;

      AGUARDANDO:
      begin
        START_2 = 1;
      end

      COMPARA_COR:
      begin
        case (B)
        BLUE: BTN_USUARIO = 2'b00;
        GREEN: BTN_USUARIO = 2'b01;
        RED: BTN_USUARIO = 2'b10;
        YELLOW: BTN_USUARIO = 2'b11;
        default: BTN_USUARIO = 2'b00;
        endcase
        
        VGA = BTN_USUARIO;
        START_1 = 1;
      end

      MOSTRA_COR_2:
        VGA_FLAG = 1;

      PERDEU:
        VGA_LOSE = 1;  // a flag será algo que demonstre derrota
      
      GANHOU:
        VGA_WIN = 1;  // flag pra dizer que ganhou
    endcase
  end

endmodule