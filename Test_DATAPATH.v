module test_DATAPATH();
	// INPUTS
	reg Next, Up, SetTime, SetAlarm, Snooze, Stop, Mute, Reset, Clk;
	// OUTPUTS
	wire [6:0] display_out, days;
	wire [3:0] segment_digit;
	wire am, pm, dblink, Sound;
	parameter sim_time = 150000;
	datapath datap (display_out, days, segment_digit, am, pm, dblink, Sound, Next, Up, SetTime, SetAlarm, Snooze, Stop, Mute, Reset, Clk);		
	initial #sim_time $finish;				
	initial begin
		Next = 1'b0;
		Up = 1'b0;
		SetTime = 1'b0; 
		SetAlarm = 1'b0;
		Snooze = 1'b0;
		Stop = 1'b0; 
		Mute = 1'b0;
		Reset = 1'b0; 
		Clk = 1'b0;
		#10;
		Reset = 1'b1;
		repeat (12) #10 Clk = ~Clk;
		Up = 1'b1;
		repeat (12) #10 Clk = ~Clk;
		Up = 1'b0;
		repeat (6) #10 Clk = ~Clk;
		Next = 1'b1;
		repeat (6) #10 Clk = ~Clk;
		Next = 1'b0;
		repeat (6) #10 Clk = ~Clk;
		Up = 1'b1;
		repeat (6) #10 Clk = ~Clk;
		Up = 1'b0;
		repeat (6) #10 Clk = ~Clk;
		Next = 1'b1;
		repeat (6) #10 Clk = ~Clk;
		Next = 1'b0;
		repeat (6) #10 Clk = ~Clk;
		Up = 1'b1;
		repeat (6) #10 Clk = ~Clk;
		Up = 1'b0;
		repeat (6) #10 Clk = ~Clk;
		Next = 1'b1;
		repeat (6) #10 Clk = ~Clk;
		Next = 1'b0;
		repeat (100) #10 Clk = ~Clk;
	end
	initial begin
		$display("TEST DATAPATH");
		$display(" Reset  Clock    A B C D   IM IH ID UPC CW1 Load LD_CT EN_ST   STO             CTO              days          display    segment_digit     Clear_St Clear");			
		$monitor(" %b         %b     %b %b %b %b   %b   %b   %b  %b   %b    %b   %b   %b   %b   %b   %b       %b         %b        %b     %b", Reset, Clk, datap.cu1.A, datap.cu1.B, datap.cu1.C, datap.cu1.D, datap.IM, datap.IH, datap.ID, datap.UPC, datap.CW1, datap.Load, datap.LD_CT, datap.EN_ST, datap.STO, datap.CTO, days, display_out, segment_digit, datap.Clear_St, datap.Clear );	
	end
endmodule