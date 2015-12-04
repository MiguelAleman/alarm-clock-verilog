module test_control_unit_1();
	// INPUTS
	reg Next, SetTime, Up, SetAlarm, Count, SetDay, AlarmSet, Clk, Reset;
	// OUTPUTS
	wire LD_DAY_TIME, LD_O_F, SS0, INCR, UPC, Clear, SS1, Load, Clear_St, Load_SS;
	parameter sim_time = 1000;
	control_unit_1 cont_unit (LD_DAY_TIME, LD_O_F, SS0, INCR, UPC, Clear, SS1, Load, Clear_St, Load_SS, Next, SetTime, Up, SetAlarm, Count, SetDay, AlarmSet, Clk, Reset);		
	initial #sim_time $finish;				
	initial begin
		Next = 1'b0;
		SetTime = 1'b0;
		Up = 1'b0;
		SetAlarm = 1'b0;
		Count = 1'b0;
		SetDay = 1'b0;
		AlarmSet = 1'b0;
		Clk = 1'b0;
		Reset = 1'b0;
		#10;
		Reset = 1'b1;
		repeat (12) #10 Clk = ~Clk;
		// Good so far (0000 -> 0100-> 0101 -> 0100)
		
		//Next = 1'b1;
		//repeat (6) #10 Clk = ~Clk;
		//Problem (0000 -> 0100 -> 0111)
		
		//Next = 1'b0;
		//Count = 1'b1;
		//repeat (10) #10 Clk = ~Clk;
		// Good so far
		
		//Next = 1'b0;
		//repeat (10) #10 Clk = ~Clk;
		//SetTime = 1'b1;
		//repeat (8) #10 Clk = ~Clk;
		
		//SetAlarm = 1'b1;
		//repeat (8) #10 Clk = ~Clk;
		
			
		Up = 1'b1;
		repeat (6) #10 Clk = ~Clk;
		// Good so far (0000 -> 0100 -> 1101 -> 1100)
		
		Up = 1'b0;
		AlarmSet = 1'b1;
		SetDay = 1'b1;
		repeat (8) #10 Clk = ~Clk;
		// Good so far	
	end
	initial begin
		$display("TEST CONTROL UNIT 1");
		$display(" Clock   A    B    C    D");			
		$monitor("  %b      %b    %b    %b    %b ", Clk, cont_unit.A, cont_unit.B, cont_unit.C, cont_unit.D );	
	end
endmodule