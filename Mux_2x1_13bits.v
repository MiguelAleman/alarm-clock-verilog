// MULTIPLEXER 2x1 13 Bits

module mux_2x1_13bits(output reg [12:0] Y, input S, input [12:0] I1, I0);
	always @ (S, I1, I0)
		if(S) Y = I1;
		else Y = I0;
endmodule