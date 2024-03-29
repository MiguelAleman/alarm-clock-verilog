module display_module(output [6:0] out3, out2, out1, out0, days, output AM, PM, DBlink, input [1:0] S, CW, CW1, input [14:0] CT, input [15:0] ST,  input Clr, Clk);
	supply1 Vcc;
	wire conv_out;
	frequency_converter_display conv (conv_out, Clk, Vcc);
	wire BLINK, toogle_out_neg;

	flip_flop_t toggle(BLINK, toogle_out_neg, conv_out, (~Clr), Clk, Vcc);
	
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
	//segment_7_dec segment_7_1 (out_1_temp, {1'b0, mux_out[6:4]}, Vcc);
	assign out1 = out_1_temp;
	
	wire [6:0] out_0_temp;
	segment_7_dec segment_7_0 (out_0_temp, mux_out[3:0], E[0]);
	//segment_7_dec segment_7_0 (out_0_temp, mux_out[3:0], Vcc);
	assign out0 = out_0_temp;
	
	reg [7:0] activate, deactivate;
	initial begin
		activate = 8'b10101100;
		deactivate = 8'b11011110;
	end
	
	wire [7:0] mux_hours_out;
	mux_4x1_8bits mux_hour (mux_hours_out, {B1, mux_out[15]}, activate, deactivate, {3'b000, A, B[3:0]}, {3'b000, A, B[3:0]});
	
	wire [6:0] out_3_temp;
	//segment_7_dec segment_7_3 (out_3_temp, mux_hours_out[7:4], Vcc);
	segment_7_dec segment_7_3 (out_3_temp, mux_hours_out[7:4], E[1]);
	assign out3 = out_3_temp;
	
	wire [6:0] out_2_temp;
	//segment_7_dec segment_7_2 (out_2_temp, mux_hours_out[3:0], Vcc);
	segment_7_dec segment_7_2 (out_2_temp, mux_hours_out[3:0], E[1]);
	assign out2 = out_2_temp;
endmodule