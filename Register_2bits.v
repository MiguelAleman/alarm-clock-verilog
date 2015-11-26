// REGISTER 2 Bits

// Enable activo alto
// Clr activo bajo

module register_2bits(output reg [1:0] Q, output [1:0] Q_n, input [1:0] D, input Clr, Clk, Enable);
	assign Q_n = ~Q;
	initial begin
		Q <= 2'b00;
	end
	always @ (posedge Clk, negedge Clr)
		 if(!Clr) Q <= 2'b00;
		 else if(Enable) Q <= D;
endmodule
