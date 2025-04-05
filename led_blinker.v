module led_blinker (
    input wire divided_clk,  // Input clock (already divided, e.g., 1 Hz)
    input wire enable,       // Enable signal (1 = blink, 0 = off)
    output reg led_out       // Output LED signal
);

    always @(posedge divided_clk ) begin
        if (enable) begin
            led_out <= ~led_out;  // Toggle LED when enabled
        end else begin
            led_out <= 1'b0;  // Turn off LED when not enabled
        end
    end
endmodule

