module datapath(output [6:0] display_out, days, output [3:0] segment_digit, output am, pm, dblink, Sound, input Next, Up, SetTime, SetAlarm, Snooze, Stop, Mute, Clr, Clk_in);
	
	wire Clk;
	clock_converter conv(Clk, Clk_in, Clr);
	
	wire [6:0] hours1, hours0, mins1, mins0;
	
	// Main Control Unit
	wire LD_DAY_TIME, LD_O_F, SS0, INCR, UPC, Clear, SS1, Load, Clear_St, Load_SS;
	wire Count, SetDay, AlarmSet;
	control_unit_1 cu1(LD_DAY_TIME, LD_O_F, SS0, INCR, UPC, Clear, SS1, Load, Clear_St, Load_SS, Next, SetTime, Up, SetAlarm, Count, SetDay, AlarmSet, Clk, Clr);
	
	// Alarm/Sound Control Unit
	wire EN_SNZ, EN_STOP;
	wire C0, CS0, AA;
	control_unit_2 cu2(EN_SNZ, EN_STOP, Sound, C0, CS0, AA, Snooze, Stop, Mute, Clk, Clr);
	
	// Circuit
	wire [1:0] CW1, CW, S;
	wire LD_R, LD_CT, LD_TIME, TOF, ID, IH, IM;
	circuit cir (CW1, CW, S, AlarmSet, SetDay, CS0, C0, LD_R, LD_CT, LD_TIME, Count, TOF, ID, IH, IM, Load, Clear, UPC, SS0, SS1, Load_SS, INCR, EN_SNZ, EN_STOP, Clk);

	// 7 Registers
	wire [12:0] Q_r0, Q_r1, Q_r2, Q_r3, Q_r4, Q_r5, Q_r6;
	// SetTime output
	wire [15:0] STO;
	registers_module reg_module (Q_r6, Q_r5, Q_r4, Q_r3, Q_r2, Q_r1, Q_r0, STO[14:12], {STO[15], STO[11:0]}, Clear, Clk, LD_R);	
	
	// Comparator Module
	// CurrentTime output
	wire [14:0] CTO;
	comparators_module comp_module (AA, CTO[14:12], {1'b1,CTO[11:0]} , Q_r6, Q_r5, Q_r4, Q_r3, Q_r2, Q_r1, Q_r0);
	
	// CurrentTime
	supply1 Vcc;
	current_time_module ct_module (CTO, STO[14:0], LD_CT, (~Clear), Clk, Vcc);	
	
	// SetTime
	supply1 EN_ST;
	set_time_module set_time(STO, CTO, Q_r6, Q_r5, Q_r4, Q_r3, Q_r2, Q_r1, Q_r0, Clear, TOF, S0, ID, Clear_St, LD_DAY_TIME, LD_TIME, EN_ST, IH, IM, LD_O_F);
			
	// Display
	display_module display(hours1, hours0, mins1, mins0, days, am, pm, dblink, S, CW, CW1, CTO, STO, Clear, Clk);
	
	
	// New Display (FPGA)
	supply0 Gnd;
	wire[1:0] count_out;
	counter_0_3 counter (count_out, Vcc, Vcc, Gnd, Vcc, Vcc, Clk_in, Vcc);
	wire[3:0] dec_out;
	decoder_4bits dec_display(dec_out, count_out, Vcc);
	wire [6:0] mux_display_out;
	mux_4x1_7bits mux_display(mux_display_out, count_out, hours1, hours0, mins1, mins0);
	
	assign segment_digit = dec_out;
	assign display_out = mux_display_out;
	
endmodule