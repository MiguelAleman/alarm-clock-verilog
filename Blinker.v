module blinker(output reg B1, output reg [2:0] E, input [1:0] CW, CW1, S, input BLINK);
	always @* begin
		B1 <= (S[1] & S[0]) & ~CW[1];
		E[2] <= (S[1] & BLINK) & ((~S[0]) & CW1[1] & (~CW1[0]) | (S[0] & (~CW[1]) & (~CW[0])));
		E[1] <= (BLINK | (~S[1]) | S[0] | CW1[1] | (~CW1[0])) & (BLINK | (~S[1]) | (~S[0]) | CW[1] | (~CW[0])) & (BLINK + (~S[1]) | (~S[0]) | (~CW[1]) | (~CW[0]));
		E[0] <= (BLINK | (~S[1]) | S[0] | CW1[1] | (CW1[0])) & ((~S[1]) | (~S[0]) | CW[1] | (~CW[0])) &  ((~S[1]) | (~S[0]) | CW[1] | CW[0]) & (BLINK + (~S[1]) | (~S[0]) | (~CW[1]) | CW[0]);
	end
endmodule