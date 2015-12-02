// MULTIPLEXER 2x1 16 Bits
module mux_2x1_16bits(output reg [15:0] Y, input S, input [15:0] I1, I0);
	always @ (S, I1, I0)
		if(S) Y = I1;
		else Y = I0;
endmodule