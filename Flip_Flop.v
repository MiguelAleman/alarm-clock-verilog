// Flip Flop

// Enable activo alto
// Clr activo bajo

module flip_flop(output reg Q, output Q_n, input D, input Clr, Clk, Enable);
	assign Q_n = ~Q;
	initial begin
		Q <= 1'b0;
	end
	always @ (posedge Clk, negedge Clr)
		 if(!Clr) Q <= 1'b0;
		 else if(Enable) Q <= D;
endmodule
