module datapath(output [6:0] hours1, hours0, mins1, mins0, days, output am, pm, dblink, sound, input Next, Up, SetTime, SetAlarm, Snooze, Stop, Mute, Reset, Clr, Clk);
	
	// Main Control Unit
	wire LD_DAY_TIME, LD_O_F, SS0, INCR, UPC, Clear, SS1, Load, Clear_St, Load_SS;
	wire Count, SetDay, AlarmSet;
	control_unit_1 cu1(LD_DAY_TIME, LD_O_F, SS0, INCR, UPC, Clear, SS1, Load, Clear_St, Load_SS, Next, SetTime, Up, SetAlarm, Count, SetDay, AlarmSet, Clk, Clr);
	
	// Alarm/Sound Control Unit
	wire EN_SNZ, EN_STOP, Sound;
	wire C0, CS0, AA;
	control_unit_2 cu2(EN_SNZ, EN_STOP, Sound, C0, CS0, AA, Snooze, Stop, Mute, Clk, Clr);
	
	
	
	
endmodule