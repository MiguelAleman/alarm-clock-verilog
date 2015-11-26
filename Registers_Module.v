module registers_module(output [12:0] Q_r0, Q_r1, Q_r2, Q_r3, Q_r4, Q_r5, Q_r6, input [2:0] STO, input [12:0] data, input Clr, Clk, LD_R);
		
		// Decoder
		wire [7:0] RE;
		decoder_8bits decoder (RE, STO, LD_R);
		
		// Registers
		
		// Sunday
		wire [12:0] Q_nr0;
		register_13bits r0 (Q_r0, Q_nr0, data, Clr, Clk, RE[0]);
		
		// Monday
		wire [12:0] Q_nr1;
		register_13bits r1 (Q_r1, Q_nr1, data, Clr, Clk, RE[1]);
		
		// Tuesday
		wire [12:0] Q_nr2;
		register_13bits r2 (Q_r2, Q_nr2, data, Clr, Clk, RE[2]);
		
		// Wednesday
		wire [12:0] Q_nr3;
		register_13bits r3 (Q_r3, Q_nr3, data, Clr, Clk, RE[3]);
		
		// Thursday
		wire [12:0] Q_nr4;
		register_13bits r4 (Q_r4, Q_nr4, data, Clr, Clk, RE[4]);
		
		// Friday
		wire [12:0] Q_nr5;
		register_13bits r5 (Q_r5, Q_nr5, data, Clr, Clk, RE[5]);
		
		// Saturday
		wire [12:0] Q_nr6;
		register_13bits r6 (Q_r6, Q_nr6, data, Clr, Clk, RE[6]);
	
endmodule