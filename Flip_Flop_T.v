// Flip Flop

// Enable activo alto
// Clr activo bajo

module flip_flop_t(output reg Q, output Q_n, input T, input Clr, Clk, Enable);
	assign Q_n = ~Q;
	initial begin
		Q <= 1'b0;
	end
	always @ (posedge Clk, negedge Clr)
		 if(!Clr) Q <= 1'b0;
		 else if(Enable & T) Q <= ~Q;
		 else Q <= Q;
endmodule
