module frequency_converter(output Y,input clock,input reset);
	reg elapsed;
	reg [25:0] state;
	always @(posedge clock)
		if (reset == 0) state <= 0;
		else if (state == 50000) state <= 0;
		else state <= state + 1;
	always @(state)
		if (state == 50000) elapsed = 1;
		else elapsed = 0;
	assign Y = elapsed;
endmodule