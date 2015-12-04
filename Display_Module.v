module display_module(output [6:0] out3, out2, out1, out0, days, output AM, PM, DBlink, input [1:0] S, CW, CW1, input [14:0] CT, input [15:0] ST,  input Clr, Clk);

	// Decidir Frecuencia
	wire and_out_1;
	wire [15:0] counter_out;
	and (and_out_1, counter_out[8], counter_out[7], counter_out[6], counter_out[5], counter_out[4], (~counter_out[3]), counter_out[2], (~counter_out[1]), (~counter_out[0]));
	
	wire count_16_clr;
	or(count_16_clr, (~Clr), and_out_1);
	counter_16bits counter (counter_out, count_16_clr, Clk);
	
	wire BLINK, toggle_out_neg;
	supply1 Vcc;
	// Clear Activo Alto
	flip_flop_t toggle (BLINK, toggle_out_neg, and_out_1, ~Clr, Clk, Vcc);
	
	wire B1;
	wire [2:0] E;
	blinker blink(B1, E, CW, CW1, S, BLINK);
	assign DBlink = E[2];
	
	wire [15:0] mux_out;
	mux_2x1_16bits mux1 (mux_out, S[1], ST, {CT[14],CT});		
	
	// Day Decoder
	wire [7:0] DEC_OUT;
	decoder_8bits decoder (DEC_OUT, mux_out[14:12], Vcc);
	assign days = DEC_OUT[6:0];	
	
	wire A, AM_PM;
	wire [3:0] B;
	hour_decoder hour_dec(A, AM_PM, B, mux_out[11:7]);
	assign AM = AM_PM;
	assign PM = ~AM_PM;
	
	wire [6:0] out_1_temp;
	segment_7_dec segment_7_1 (out_1_temp, {1'b0, mux_out[6:4]}, E[0]);
	assign out1 = out_1_temp;
	
	wire [6:0] out_0_temp;
	segment_7_dec segment_7_0 (out_0_temp, mux_out[3:0], E[0]);
	assign out0 = out_0_temp;
	
	reg [7:0] activate, deactivate;
	initial begin
		activate = 8'b10101100;
		deactivate = 8'b11011110;
	end
	
	wire [7:0] mux_hours_out;
	mux_4x1_8bits mux_hour (mux_hours_out, {B1, mux_out[15]}, activate, deactivate, {3'b000, A, B[3:0]}, {3'b000, A, B[3:0]});
	
	wire [6:0] out_3_temp;
	segment_7_dec segment_7_3 (out_3_temp, mux_hours_out[7:4], E[1]);
	assign out3 = out_3_temp;
	
	wire [6:0] out_2_temp;
	segment_7_dec segment_7_2 (out_2_temp, mux_hours_out[3:0], E[1]);
	assign out2 = out_2_temp;
endmodule