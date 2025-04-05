module led_7_segment(
    input [3:0] bcd,    // Input 4-bit BCD
    output reg [6:0] led // Output 7-bit LED segments
);
    always @(*) begin
        case (bcd)
            4'b0000: led= 7'b1000000; 
            4'b0001: led= 7'b1111001; 
            4'b0010: led= 7'b0100100; 
            4'b0011: led= 7'b0110000; 
            4'b0100: led= 7'b0011001; 
            4'b0101: led= 7'b0010010; 
            4'b0110: led= 7'b0000010; 
            4'b0111: led= 7'b1111000; 
            4'b1000: led= 7'b0000000; 
            4'b1001: led= 7'b0010000; 
            default: led= 7'b1111111; 
        endcase
    end
endmodule



