// COUNTER WITH CLR, CLOCK, ENABLE, LOAD AND UP
// Decidir si el LD va a ser activo bajo o activo alto
module counter_0_9(output reg [3:0] COUNT, input IN_3, IN_2, IN_1, IN_0, input LD, Up, Clr, Clk, Enable);
	initial begin
		COUNT <= 4'b0000;
	end
	always @ (posedge Clk, negedge Clr)
		if (!Clr) COUNT <= 4'b0000;
		else if (LD & Enable) begin
			COUNT[0] = IN_0;
			COUNT[1] = IN_1;
			COUNT[2] = IN_2;
			COUNT[3] = IN_3;
		end
		else if (Up & Enable) begin
			if(COUNT==4'b1001) COUNT <= 4'b0000;
			else COUNT = COUNT + 4'b0001;
		end
endmodule