module hope_timer60 (
    input wire Clk,
    input wire set_time,
    input wire UpOrDown, 
    input wire start, 
    input wire stop,
    input wire reset,
    input wire pause,
    input wire [3:0] Init_unitvalue,
    input wire [3:0] Init_dozenvalue,
    output wire [7:0] Init_value60,
    output wire [7:0] Count60,
    output wire [1:0] carry60
);
    // Wires for lower and upper counters
    wire [3:0] count_lower, count_upper;
    wire carry_lower, carry_upper;
    
    // Assign combined outputs
    assign Init_value60 = {Init_dozenvalue, Init_unitvalue};
    assign Count60 = {count_upper, count_lower};
    assign carry60 = {carry_upper, carry_lower};

    // Instantiate lower timer (Units)
    hope_timer10 #(.N(4'b1001)) Unit (
        .Clk(Clk),
        .set_time(set_time),
        .start(start),
        .stop(stop),
        .reset(reset),
        .pause(pause),
        .UpOrDown(UpOrDown),
        .Init_value(Init_unitvalue),
        .Count(count_lower),
        .carry(carry_lower)
    );

    // Instantiate upper timer (Dozens) with carry_lower as clock
    hope_timer10 #(.N(4'b0101)) Dozen ( // Dozen counter wraps at 5 (0–59 counting)
        .Clk(carry_lower), // Use carry_lower as clock
        .set_time(set_time),
        .start(start),
        .stop(stop),
        .reset(reset),
        .pause(pause),
        .UpOrDown(UpOrDown),
        .Init_value(Init_dozenvalue),
        .Count(count_upper),
        .carry(carry_upper)
    );

endmodule
