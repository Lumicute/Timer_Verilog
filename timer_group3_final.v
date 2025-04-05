module timer_group3_final 
(
input wire sys_clk,
input wire set_time_increase,
input wire set_time_decrease,
input wire start,
input wire pause,
input wire reset,
output wire [6:0] min1_led,
output wire [6:0] min0_led,
output wire [6:0] sec1_led,
output wire [6:0] sec0_led,
output wire blink_led
);

wire clk_1hz;
wire [7:0] Init_minvalue ;
wire [7:0] Init_secvalue ;
wire [7:0] Countmin ;
wire [7:0] Countsec ;
wire [1:0] carrymin ;
wire [1:0] carrysec ; 
wire enable_led ;

frequency_1hz Clk_block (.clk_in(sys_clk),.reset(reset),.clk_out(clk_1hz));
timer_group3ok FPGA_timer (
.Clk(clk_1hz),
.set_time_increase(set_time_increase),
.set_time_decrease(set_time_decrease),
.start(start),
.pause(pause),
.reset(reset),
.Init_minvalue(Init_minvalue),
.Init_secvalue(Init_secvalue),
.Countmin(Countmin),
.Countsec(Countsec),
.carrymin(carrymin),
.carrysec(carrysec),
.blink_led(enable_led)
);

led_7_segment leg1_min (
.bcd(Countmin[7:4]),
.led(min1_led)
);

led_7_segment leg0_min (
.bcd(Countmin[3:0]),
.led(min0_led)
);

led_7_segment leg1_sec (
.bcd(Countsec[7:4]),
.led(sec1_led)
);

led_7_segment leg0_sec (
.bcd(Countsec[3:0]),
.led(sec0_led)
);

led_blinker toggle_led (
.divided_clk(clk_1hz),
.enable(enable_led),
.led_out(blink_led)
);

endmodule 





