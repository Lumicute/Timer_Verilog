module frequency_1hz (
    input wire clk_in,       // Input clock (50 MHz)
    input wire reset,        // Reset signal
    output reg clk_out       // Output clock (0.5s HIGH, 0.5s LOW)
);

    reg [25:0] counter; // 26-bit counter

initial 
begin
clk_out =1'b0;
counter =26'd0;
end 
    always @(posedge clk_in or posedge reset) begin
        if (reset) begin
            counter <= 26'd0;  // Reset the counter
            clk_out <= 1'b0;   // Reset the output clock
        end else begin
            if (counter == 26'd24999999) begin
                counter <= 26'd0;         // Reset the counter when it reaches 25 million
                clk_out <= ~clk_out;      // Toggle the output clock
            end else begin
                counter <= counter + 1'b1;   // Increment the counter
            end
        end
    end
endmodule

