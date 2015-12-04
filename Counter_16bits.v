// COUNTER WITH CLR AND CLOCK
module counter_16bits(output reg [15:0] COUNT, input Clr, Clk);
	initial begin
		COUNT <= 16'b0000000000000000;
	end
	always @ (posedge Clk, negedge Clr)
		if (~Clr) COUNT <= 16'b0000000000000000;
		else COUNT <= COUNT + 16'b0000000000000001;
endmodule