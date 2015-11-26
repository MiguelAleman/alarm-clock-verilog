// REGISTER 13 Bits

// Enable activo alto
// Clr activo bajo

module register_13bits(output reg [12:0] Q, output [12:0] Q_n, input [12:0] D, input Clr, Clk, Enable);
	assign Q_n = ~Q;
	initial begin
		Q <= 13'b0000000000000;
	end
	always @ (posedge Clk, negedge Clr)
		 if(!Clr) Q <= 13'b0000000000000;
		 else if(Enable) Q <= D;
endmodule
