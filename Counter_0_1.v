// COUNTER WITH CLR, CLOCK, ENABLE, LOAD AND UP
// Decidir si el LD va a ser activo bajo o activo alto
module counter_0_1(output reg COUNT, input IN_0, input LD, Up, Clr, Clk, Enable);
	initial begin
		COUNT <= 1'b0;
	end
	always @ (posedge Clk, negedge Clr)
		if (~Clr) COUNT <= 1'b0;
		else if (LD & Enable) begin
			COUNT <= IN_0;
		end
		else if (Up & Enable) begin
			COUNT <= COUNT + 1'b1;
		end
endmodule