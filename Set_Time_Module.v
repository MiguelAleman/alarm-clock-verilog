module set_time_module(output [15:0] STO, input [14:0] CTI, input [12:0] Q_r6, Q_r5, Q_r4, Q_r3, Q_r2, Q_r1, Q_r0, input CLEAR, TOF, S0, LD_ID, CLEAR_ST, LD_DAY, LD_TIME, EN_ST, IH, IM, LD_O_F, Clk);
	wire [12:0] mux_out;
	// 8th input is not used
	mux_8x1_13bits mux1 (mux_out, STO[14:12], Q_r6, Q_r6, Q_r5, Q_r4, Q_r3, Q_r2, Q_r1, Q_r0);
	
	wire [11:0] mux_2_out;
	mux_2x1_12bits mux2 (mux_2_out, S0, mux_out[11:0], CTI[11:0]);
	
	// On/Off Counter
	supply1 Vcc;
	wire on_off_out;
	counter_0_1 counter_on_off(on_off_out, mux_out[12],  (~LD_O_F), Vcc, (~CLEAR), Clk, (LD_O_F | TOF));
	assign STO[15] = on_off_out;
	
	wire or_t_d;
	or (or_t_d, LD_TIME, LD_DAY);
	
	wire or_clear_clr_st;
	or (or_clear_clr_st, CLEAR, CLEAR_ST);
		
	// Minutes
	// 0-9
	wire or_clk_1;
	or (or_clk_1, or_t_d, IM);
	wire [3:0] min_out_1;
	counter_0_9 min_1 (min_out_1, mux_2_out[3], mux_2_out[2], mux_2_out[1], mux_2_out[0], or_t_d, Vcc, (~or_clear_clr_st), Clk, or_clk_1);
	assign STO[3:0] = min_out_1[3:0];
	
	// 0-5
	wire and_out_2;
	wire min_out_1_neg_3, min_out_1_neg_2, min_out_1_neg_1, min_out_1_neg_0;
	not (min_out_1_neg_3, min_out_1[3]);
	not (min_out_1_neg_2, min_out_1[2]);
	not (min_out_1_neg_1, min_out_1[1]);
	not (min_out_1_neg_0, min_out_1[0]);
	and (and_out_2, min_out_1[3], min_out_1_neg_2, min_out_1_neg_1, min_out_1[0], IM);
	wire or_clk_2;
	or (or_clk_2, or_t_d, and_out_2);
	wire [2:0] min_out_2;
	counter_0_5 min_2 (min_out_2, mux_2_out[6], mux_2_out[5], mux_2_out[4], or_t_d, Vcc, (~or_clear_clr_st), Clk, or_clk_2);
	assign STO[6:4] = min_out_2[2:0];
	
	// Hours	
	wire clock_hour;
	or (clock_hour, or_t_d, IH);
	wire [4:0] hour_out;
	counter_0_23 hour (hour_out, mux_2_out[11], mux_2_out[10], mux_2_out[9], mux_2_out[8], mux_2_out[7], or_t_d, Vcc, (~or_clear_clr_st), Clk, clock_hour);
	assign STO[11:7] = hour_out[4:0];


	// Days
	wire clock_day;
	or (clock_day, LD_ID, LD_DAY);
	wire [2:0] days_out;
	counter_0_6 days (days_out, CTI[14], CTI[13], CTI[12], LD_DAY, Vcc,  (~or_clear_clr_st), Clk, clock_day);
	assign STO[14:12] = days_out[2:0];
	
endmodule