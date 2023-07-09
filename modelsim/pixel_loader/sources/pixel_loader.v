module pixel_loader
(
    // ----- Inputs -----
    input RESET,
    input CLK,
    input [47:0] DATA_IN,
    input INTERFACE_EN,

    // ----- Outputs ----
    output [3:0] MEM_ADDR,
    output reg MEM_CLK,
    output [23:0] RGB
);

parameter MAX_ADDR = 32;  // 65536

reg [47:0] P;  // 48 bits, 2 pixels
reg [23:0] tmp; // 24 bits, 1 pixel

// State register
reg [2:0] A_State, F_State;

// Address holder
reg [3:0] r_Addr;

// Encoding of states
parameter INICIO = 0,
          PREPARAR = 1,
          ATIVAR = 2,
          SUSPENDER = 3,
          LER = 4,
          INCREMENTAR = 5;

// Clocked block
always @(posedge CLK)
begin
    if (RESET)
    begin
        A_State <= INICIO;
        r_Addr <= 0;
    end else
    begin
        A_State <= F_State;

        if (F_State == INCREMENTAR)
            r_Addr <= r_Addr + 1;

        if (F_State == INICIO)
            r_Addr <= 0;
    end
end

// Next state decoder
always @(*)
begin
    case (A_State)
        INICIO:
            if (RESET)
                F_State = INICIO;
            else
                F_State = PREPARAR;

        PREPARAR:
            if (r_Addr == MAX_ADDR)
                F_State = INICIO;
            else
                F_State = ATIVAR;

        ATIVAR:
            if (INTERFACE_EN)
                F_State = LER;
            else
                F_State = SUSPENDER;

        SUSPENDER:
            if (INTERFACE_EN)
                F_State = LER;
            else
                F_State = SUSPENDER;

        LER:
            F_State = INCREMENTAR;

        INCREMENTAR:
            F_State = PREPARAR;

        default:
            F_State = INICIO;
    endcase
end

// Output decoder
always @(*)
begin
    // State outputs
    MEM_CLK = 0;

    case (A_State)
        INICIO:
        begin
            MEM_CLK = 0;
            P = 0;
            tmp = 0;
        end

        PREPARAR:
            tmp = P[23:0];

        ATIVAR:
            MEM_CLK = 1;

        SUSPENDER:
            P = DATA_IN;

        LER:
        begin
            P = DATA_IN;
            tmp = DATA_IN[47:24];
        end

        INCREMENTAR:
            P = DATA_IN;
    endcase
end

assign RGB = tmp;
assign MEM_ADDR = r_Addr;
endmodule
