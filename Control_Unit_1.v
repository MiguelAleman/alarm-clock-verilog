module control_unit_1(output reg LD_DAY_TIME, LD_O_F, SS0, INCR, UPC, Clear, SS1, Load, Clear_St, Load_SS, input Next, SetTime, Up, SetAlarm, Count, SetDay, AlarmSet, Clk, Reset);
wire A, A_neg, B, B_neg, C, C_neg, D, D_neg;
supply1 Vcc;
reg Da, Db, Dc, Dd;
	always @ *
		begin
			Da <= (A_neg & B_neg & D) | (~Next & ~Count & A_neg & C & D_neg) | ((A & B & C_neg) & (Up | (~Up & AlarmSet & SetDay)) | (SetAlarm & A & B & D) | (A & B & C_neg & D) | (Up & A_neg & B & C_neg & D_neg));
			Db <= (A_neg & (~SetTime | B | D_neg)) | (A & (C_neg & (A | D) | B_neg));
			Dc <= A_neg & ((C_neg & Next) | (C & (Next | (~Next & ~Count) | D)) | (B_neg & D));
			Dd <= A_neg & ((B_neg & D) | ((B & C_neg) & (Next | D_neg))) | (A & B & C);
			SS0 <= A & B_neg & C_neg & D;
			SS1 <= (A & B_neg & D) | (A_neg & B_neg & C_neg & D_neg);
			INCR <= A & B & C_neg & D;
			Clear <= A_neg & B_neg & C_neg & D_neg;
			UPC <= A_neg & B & C & D;
			Load <= A & B & C & D_neg;
			LD_DAY_TIME <= A & B_neg & C & D;
			Clear_St <= A & B & C & D;
			Load_SS <= (A_neg & B_neg & C_neg & D_neg) | (A_neg & B_neg & C_neg & D) | (A & B_neg & D);
			LD_O_F <= A & B_neg & C_neg;
		end
		flip_flop flipflopA (A, A_neg, Da, Reset, Clk, Vcc);
		flip_flop flipflopB (B, B_neg, Db, Reset, Clk, Vcc);
		flip_flop flipflopC (C, C_neg, Dc, Reset, Clk, Vcc);
		flip_flop flipflopD (D, D_neg, Dd, Reset, Clk, Vcc);
endmodule