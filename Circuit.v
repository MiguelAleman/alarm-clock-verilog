module circuit(output [1:0] CW1, CW, S, output reg AlarmSet, SetDay, CS0, C0, LD_R, LD_CT, LD_TIME, Count, TOF, ID, IH, IM , input Load, CClr, UPC, SS0, SS1, Load_SS, INCR, EN_SNZ, EN_STOP, Clk);
	supply1 Vcc;
	supply0 Gnd;
	wire [1:0] S_neg;
	// Snooze/Stop Counter
	wire [15:0] clock_out;
	wire [15:0] clock_out_2;
	
	wire and_out_1;
	wire and_out_2;
		
	// 1 minute //1110101001100000
	and (and_out_1, clock_out[15],clock_out[14],clock_out[13],~clock_out[12],clock_out[11],~clock_out[10],clock_out[9],~clock_out[8],~clock_out[7],clock_out[6],clock_out[5],~clock_out[4], ~clock_out[3], ~clock_out[2], ~clock_out[1], ~clock_out[0]);
	
	// 3 seconds
	and (and_out_2, clock_out_2[9], clock_out_2[8], clock_out_2[7], clock_out_2[6], clock_out_2[5], (~clock_out_2[4]), clock_out_2[3], (~clock_out_2[2]), (~clock_out_2[1]), (~clock_out_2[0]));
	
	wire [1:0] reg_out;
	register_2bits reg_SS (reg_out, S_neg, {SS1,SS0}, Vcc, (Clk & Load_SS), Vcc);	
	assign S = reg_out;
	counter_0_3 counter_SA (CW, Gnd, Gnd, Gnd, Vcc, (~CClr), (UPC & S[1] & S[0]), Vcc);
	counter_0_2 counter_ST (CW1, Gnd, Gnd, Gnd, Vcc, (~CClr), (UPC & S[1] & (~S[0])), Vcc);
	counter_16bits counter_snz (clock_out, (~(EN_SNZ | CClr)) , Clk);
	counter_16bits counter_stop (clock_out_2, (~(EN_STOP | CClr)), Clk);
	
	always @* begin
		CS0 <= clock_out[10];
		C0 <= clock_out_2[9];
		SetDay <= S[1] & S[0] & ~CW[1] & ~CW[0];
		TOF <= S[1] & S[0] & ~CW[1] & CW[0] & INCR;
		ID <= (S[1] & INCR) & ((~S[0] & CW1[1] & ~CW1[0]) | (S[0] & ~CW[1] & ~CW[0]));
		IH <= (S[1] & INCR) & ((~S[0] & ~CW1[1] & CW1[0]) | (S[0] & CW[1] & CW[0]));
		IM <= (S[1] & INCR) & ((~S[0] & ~CW1[1] & ~CW1[0]) | (S[0] & CW[1] & ~CW[0]));
		Count <= (CW1[1] | CW1[0] | CW[1] | CW[0]);
		LD_R <= (S[1] & S[0] & Load);
		LD_CT <= (S[1] & ~S[0] & Load);
		AlarmSet <= (S[1] & S[0]);
		LD_TIME <= (S[1] & S[0] & UPC & ~CW[1] & CW[0]);
	end
endmodule