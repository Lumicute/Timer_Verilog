module timer_group3ok (
    input wire Clk,
    input wire set_time_increase,
    input wire set_time_decrease,
    input wire start,
    input wire pause,
    input wire reset,
    output wire [7:0] Init_minvalue,
    output wire [7:0] Init_secvalue,
    output wire [7:0] Countmin,
    output wire [7:0] Countsec,
    output wire [1:0] carrymin,
    output wire [1:0] carrysec,
    output wire blink_led
);

    // Internal registers
    reg [3:0] Int_min1value, Int_min0value;
    reg [3:0] Int_sec1value, Int_sec0value;
    reg blink_signal;
    reg Set_clk;
    reg stop;
    wire trigger_start;
    wire UpOrDown = 1'b0; // Always count down

    // Initialization
    initial begin
        Int_min1value = 4'b0000;
        Int_min0value = 4'b0000;
        Int_sec1value = 4'b0000;
        Int_sec0value = 4'b0000;
        stop = 1'b0;
        Set_clk = 1'b1;
        blink_signal = 1'b0;
    end

    assign blink_led = blink_signal;
assign trigger_start = (start && (|Int_min1value || |Int_min0value)) ? 1 : 0;


      always @(posedge Clk) begin
		if (!start && !stop) begin 
        if (set_time_increase==1'b0 ) begin
           
            if (Int_min0value < 4'b1001) begin
                Int_min0value <= Int_min0value + 1'b1;
            end else if (Int_min1value < 4'b0101) begin
                Int_min0value <= 4'b0000;
                Int_min1value <= Int_min1value + 1'b1;
            end else begin
                Int_min0value <= 4'b0000;
                Int_min1value <= 4'b0000;
            end
            Set_clk <= 1'b1;
        end else if (set_time_decrease==1'b0 ) begin
        
            if (Int_min0value > 4'b0000) begin
                Int_min0value <= Int_min0value - 1'b1;
            end else if (Int_min1value > 4'b0000) begin
                Int_min1value <= Int_min1value - 1'b1;
                Int_min0value <= 4'b1001;
            end else begin
                Int_min1value <= 4'b0000;
                Int_min0value <= 4'b0000;
            end
            Set_clk <= 1'b1;
        end else begin
            Set_clk <= 1'b0;
        end
		  end 
    end

  // Countdown logic and blink signal
always @(posedge Clk or posedge reset) begin
    if (reset) begin
        blink_signal <= 1'b0;
        stop <= 1'b0;
    end else if (trigger_start) begin
        if (Countmin==8'b00000000 && Countsec==8'b00000001 ) begin
            // Stop the timer when the countdown reaches zero
            blink_signal <= 1'b1;
            stop <= 1'b1; 
        end 
    end
end


    // Second timer module
    hope_timer60 seccount (
        .Clk(Clk),
        .set_time(Set_clk),
        .UpOrDown(UpOrDown),
        .start(trigger_start),
        .stop(stop),
        .reset(reset),
        .pause(pause),
        .Init_unitvalue(Int_sec0value),
        .Init_dozenvalue(Int_sec1value),
        .Init_value60(Init_secvalue),
        .Count60(Countsec),
        .carry60(carrysec)
    );

    // Minute timer module
    hope_timer60 mincount (
        .Clk(carrysec[1]),
        .set_time(Set_clk),
        .UpOrDown(UpOrDown),
        .start(trigger_start),
        .stop(stop),
        .reset(reset),
        .pause(pause),
        .Init_unitvalue(Int_min0value),
        .Init_dozenvalue(Int_min1value),
        .Init_value60(Init_minvalue),
        .Count60(Countmin),
        .carry60(carrymin)
    );

endmodule
