module control_unit_2(output reg EN_SNZ, EN_STOP, Sound, input C0, CS0, AA, Snooze, Stop, Mute, Clk, Reset);
	wire A, A_neg, B, B_neg, C, C_neg;
	supply1 Vcc;
	reg Da, Db, Dc;
	flip_flop flipflopA (A, A_neg, Da, Reset, Clk, Vcc);
	flip_flop flipflopB (B, B_neg, Db, Reset, Clk, Vcc);
	flip_flop flipflopC (C, C_neg, Dc, Reset, Clk, Vcc);
	always @* begin
		Da <= (~Stop & C) | (Snooze & A & B) | (~CS0 & A & B_neg) | (A & C);
		Db <= (~C0 & A_neg & B) | (A_neg & C);
		Dc <= (~Mute & AA & A_neg & B_neg & C_neg) | (CS0 & A & C_neg) | (A & B);
		Sound <= (A_neg & B_neg & C) | (A & B & C_neg);
		EN_SNZ <= A & B_neg & C;
		EN_STOP <= A_neg & B_neg & C;
	end
endmodule