module comparators_module( output AA, input [2:0] CD, input [12:0] CT, Q_r0, Q_r1, Q_r2, Q_r3, Q_r4, Q_r5, Q_r6);
	wire [12:0] mux_out;
	// 7th input is not used
	mux_8x1_13bits mux1 (mux_out, CD, Q_r6, Q_r6, Q_r5, Q_r4, Q_r3, Q_r2, Q_r1, Q_r0);			
	comparator_13bits comp1 (AA, CT, mux_out);
endmodule