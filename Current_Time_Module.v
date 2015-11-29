module current_time_module(output [14:0] CTO, input [14:0] CTI, input LD_CT, Clr_CT, Clk, EN_CT);
	
	supply1 Vcc;
	
	// Clock Counter
	wire [15:0] clock_out;
	wire and_out_1;
	
	// Just for Debugging
	and (and_out_1, clock_out[0]);
	
	//and (and_out_1, clock_out[6], clock_out[5],  clock_out[4],  clock_out[3],  clock_out[2],  clock_out[1],  clock_out[0]);
	wire count_16_clr;
	or(count_16_clr, LD_CT, Clr_CT, and_out_1);
	counter_16bits clock (clock_out, count_16_clr, Clk);
		
	// Minutes
	// 0-9
	wire or_clk_1;
	or (or_clk_1, and_out_1, LD_CT);
	wire [3:0] min_out_1;
	counter_0_9 min_1 (min_out_1, CTI[3], CTI[2], CTI[1], CTI[0], LD_CT, Vcc, Clr_CT, or_clk_1, EN_CT);
	
	// 0-5
	wire and_out_2;
	wire min_out_1_neg_3, min_out_1_neg_2, min_out_1_neg_1, min_out_1_neg_0;
	not (min_out_1_neg_3, min_out_1[3]);
	not (min_out_1_neg_2, min_out_1[2]);
	not (min_out_1_neg_1, min_out_1[1]);
	not (min_out_1_neg_0, min_out_1[0]);
	and (and_out_2, min_out_1_neg_3, min_out_1_neg_2, min_out_1_neg_1, min_out_1_neg_0);
	wire or_clk_2;
	or (or_clk_2, and_out_2, LD_CT);
	wire [2:0] min_out_2;
	counter_0_5 min_2 (min_out_2, CTI[6], CTI[5], CTI[4], LD_CT, Vcc, Clr_CT, or_clk_2, EN_CT);
	
	// Hours
	wire and_out_3;
	wire min_out_2_neg_2, min_out_2_neg_1, min_out_2_neg_0;
	not (min_out_2_neg_2, min_out_2[2]);
	not (min_out_2_neg_1, min_out_2[1]);
	not (min_out_2_neg_0, min_out_2[0]);
	and (and_out_3, min_out_2_neg_2, min_out_2_neg_1, min_out_2_neg_0);
	wire or_clk_3;
	or (or_clk_3, and_out_3, LD_CT);
	wire [4:0] hour_out;
	counter_0_23 hour (hour_out, CTI[11], CTI[10], CTI[9], CTI[8], CTI[7], LD_CT, Vcc, Clr_CT, or_clk_3, EN_CT);
	
	// Days
	wire and_out_4;
	wire hour_out_neg_4, hour_out_neg_3, hour_out_neg_2, hour_out_neg_1, hour_out_neg_0;
	not (hour_out_neg_4, hour_out[4]);
	not (hour_out_neg_3, hour_out[3]);
	not (hour_out_neg_2, hour_out[2]);
	not (hour_out_neg_1, hour_out[1]);
	not (hour_out_neg_0, hour_out[0]);
	and (and_out_4, hour_out_neg_4, hour_out_neg_3, hour_out_neg_2, hour_out_neg_1, hour_out_neg_0);
	wire or_clk_4;
	or (or_clk_4, and_out_4, LD_CT);
	wire [2:0] days_out;
	counter_0_6 days (days_out, CTI[14], CTI[13], CTI[12], LD_CT, Vcc, Clr_CT, or_clk_4, EN_CT);
	
	// Assign bits to output
	
	// 0-9 Mins
	assign CTO[0] = min_out_1[0];
	assign CTO[1] = min_out_1[1];
	assign CTO[2] = min_out_1[2];
	assign CTO[3] = min_out_1[3];
	
	// 0-5 Mins
	assign CTO[4] = min_out_2[0];
	assign CTO[5] = min_out_2[1];
	assign CTO[6] = min_out_2[2];
	
	// 0-23 Hours
	assign CTO[7] = hour_out[0];
	assign CTO[8] = hour_out[1];
	assign CTO[9] = hour_out[2];
	assign CTO[10] = hour_out[3];
	assign CTO[11] = hour_out[4];
	
	// 0-6 Days
	assign CTO[12] = days_out[0];
	assign CTO[13] = days_out[1];
	assign CTO[14] = days_out[2];	
	
endmodule