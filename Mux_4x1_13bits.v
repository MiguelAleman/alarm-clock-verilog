// MULTIPLEXER 4x1 13 Bits

module mux_4x1_13bits(output reg[12:0] Y, input[1:0] S, input[12:0] I3, I2, I1, I0);
	always @ (S, I3, I2, I1, I0)
		if(S[1] && S[0]) Y = I3;
		else if(S[1]) Y = I2;
		else if(S[0]) Y = I1;
		else Y = I0;
endmodule