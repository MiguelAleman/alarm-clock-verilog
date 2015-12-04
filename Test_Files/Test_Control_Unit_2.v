module test_control_unit_2();
	// INPUTS
	reg C0, CS0, AA, Snooze, Stop, Mute, Clk, Reset;
	// OUTPUTS
	wire  EN_SNZ, EN_STOP, Sound;
	parameter sim_time = 1000;
	control_unit_2 cont_unit (EN_SNZ, EN_STOP, Sound, C0, CS0, AA, Snooze, Stop, Mute, Clk, Reset);		
	initial #sim_time $finish;				
	initial begin
		C0 = 1'b0;
		CS0 = 1'b0;
		AA = 1'b0;
		Snooze = 1'b0;
		Stop = 1'b0;
		Mute = 1'b0;
		Clk = 1'b0;
		Reset = 1'b0;
		#10;
		Reset = 1'b1;
		repeat (12) #10 Clk = ~Clk;
		AA = 1'b1;
		repeat (10) #10 Clk = ~Clk;
		Stop = 1'b1;
		repeat (6) #10 Clk = ~Clk;
		C0 = 1'b1;
		repeat (10) #10 Clk = ~Clk;
		Stop = 1'b0;
		Snooze = 1'b1;
		repeat (10) #10 Clk = ~Clk;
		CS0 = 1'b1;
		repeat (2) #10 Clk = ~Clk;
	end
	initial begin
		$display("TEST CONTROL UNIT 2");
		$display(" Clock   A    B    C");			
		$monitor("  %b      %b    %b    %b", Clk, cont_unit.A, cont_unit.B, cont_unit.C);	
	end
endmodule