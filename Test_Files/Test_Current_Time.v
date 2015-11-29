module test_register_module();
	// Clear, Clock, Enable
	reg [2:0] CCE;	
	reg  LD; 
	reg [14:0] CTI;
	wire [14:0] CTO;
	parameter sim_time = 1000;
	current_time_module ct_module (CTO, CTI, LD, CCE[2], CCE[1], CCE[0]);		
	initial #sim_time $finish;				
	initial begin
		CCE = 3'b001;
		LD = 1'b0;
		CTI = 15'b000000000000000;
		#10;
		CCE = 3'b111;
		repeat (20) #10 CCE[1] = ~CCE[1];
		// 2 8:43
		CTI = 15'b010010001000011;
		LD = 1'b1;
		#10;
		LD = 1'b0;
		repeat (100) #10 CCE[1] = ~CCE[1];
	end
	initial begin
		$display(" Clear  Clock  Enable  LD  CTI           Current_Time");			
		$monitor(" %b         %b         %b  %b %b %d %d : %d%d ", CCE[2], CCE[1], CCE[0],LD, CTI, CTO[14:12], CTO[11:7], CTO[6:4], CTO[3:0]);	
	end
endmodule