// MULTIPLEXER 2x1 12 Bits
module mux_2x1_12bits(output reg [11:0] Y, input S, input [11:0] I1, I0);
	always @ (S, I1, I0)
		if(S) Y = I1;
		else Y = I0;
endmodule