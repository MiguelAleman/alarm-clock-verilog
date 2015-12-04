// COUNTER WITH CLR, CLOCK, ENABLE, LOAD AND UP
// Decidir si el LD va a ser activo bajo o activo alto
module counter_0_5(output reg [2:0] COUNT, input IN_2, IN_1, IN_0, input LD, Up, Clr, Clk, Enable);
	initial begin
		COUNT <= 3'b000;
	end
	always @ (posedge Clk, negedge Clr, posedge LD)
		if (~Clr) COUNT <= 3'b000;
		else if (LD & Enable) begin
			COUNT[0] <= IN_0;
			COUNT[1] <= IN_1;
			COUNT[2] <= IN_2;
		end
		else if (Up & Enable) begin
			if(COUNT==3'b101) COUNT <= 3'b000;
			else COUNT <= COUNT + 3'b001;
		end
endmodule