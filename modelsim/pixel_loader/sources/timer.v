module timer
#(parameter WIDTH=12)
(
    input clk_2K,   // 2 kHz clock
    // -----------------------------------------------
    input START,    // Input to activate the counter on the 2 kHz clock
    input RESET,    // Input to reset the counter to 0
    // -----------------------------------------------
    output [WIDTH - 1:0] COUNT, // Counter output
    output wire DONE,   // Output indicating if the time has elapsed
    output reg RST_OK   // Indicates if the counter has been successfully reset
);

    // Register to store the counter value
    reg [WIDTH - 1:0] r_count;

    // Increment the counter on the rising edge of the 2 kHz clock if START is
    // true
    always @ (posedge clk_2K)
    begin
        if (RESET)
        begin
            r_count <= 0;
            RST_OK <= 1;
        end

        // The ~& operator performs a NAND operation on the counter and returns
        // 0 if all its bits are 1
        else if ((START)&&(~&r_count))
        begin
            r_count <= r_count + 1;
            RST_OK <= 0;
        end
    end

    // Ternary assignment for the DONE output
    assign DONE = 1? ((START)&&(!RESET)&&(&r_count)): 0;

    // Assign the output as the value of the register
    assign COUNT = r_count;

endmodule
