// COUNTER WITH CLR, CLOCK, ENABLE, LOAD AND UP
// Decidir si el LD va a ser activo bajo o activo alto
module counter_0_23(output reg [4:0] COUNT, input IN_4, IN_3, IN_2, IN_1, IN_0, input LD, Up, Clr, Clk, Enable);
	initial begin
		COUNT <= 5'b00000;
	end
	always @ (posedge Clk, negedge Clr)
		if (~Clr) COUNT <= 5'b00000;
		else if (Up & Enable) begin
			if(COUNT==5'b10111) COUNT <= 5'b00000;
			else COUNT <= COUNT + 5'b00001;
		end
	always @ (posedge LD)
		if (LD & Enable) begin
			COUNT[0] <= IN_0;
			COUNT[1] <= IN_1;
			COUNT[2] <= IN_2;
			COUNT[3] <= IN_3;
			COUNT[4] <= IN_4;
		end
endmodule