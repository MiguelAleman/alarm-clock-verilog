module frequency_converter_display(output Y,input clock,input reset);
	reg elapsed;
	reg [25:0] state;
	always @(posedge clock)
		if (reset == 0) state <= 0;
		else if (state == 250) state <= 0;
		else state <= state + 1;
	always @(state)
		if (state == 250) elapsed = 1;
		else elapsed = 0;
	assign Y = elapsed;
endmodule