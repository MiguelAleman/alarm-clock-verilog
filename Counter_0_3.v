// COUNTER WITH CLR, CLOCK, ENABLE, LOAD AND UP
// Decidir si el LD va a ser activo bajo o activo alto
module counter_0_3(output reg [1:0] COUNT, input IN_1, IN_0, input LD, Up, Clr, Clk, Enable);
	initial begin
		COUNT <= 2'b00;
	end
	always @( posedge Clk, negedge Clr)
		if (~Clr) COUNT <= 2'b00;
		else if (LD & Enable) begin
			COUNT[0] <= IN_0;
			COUNT[1] <= IN_1;
		end
		else if (Up & Enable) begin
			if(COUNT==2'b11) COUNT <= 2'b00;
			else COUNT <= COUNT + 2'b01;
		end
endmodule