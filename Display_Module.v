module display_module(output [6:0] out3, out2, out1, out0, days, output AM, PM, DBlink, input [1:0] S, CW, CW1, input [14:0] CT, input [15:0] ST,  input Clr, Clk);
	
	// Counter
	// Clear Activo Alto
	wire [15:0] counter_out;
	counter_16bits counter (counter_out, ~Clr, Clk);
	
	// Decidir Frecuencia
	wire and_out_1;
	and (and_out_1, counter_out[0]);
	
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
endmodule