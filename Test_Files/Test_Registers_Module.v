module test_register_32bits();
	// Clear, Clock, Enable
	reg [2:0] CCE;	
	reg [2:0] STO;
	// Data
	reg [12:0] D; 
	// 7 Registers Output
	wire [12:0] Q_r0, Q_r1, Q_r2, Q_r3, Q_r4, Q_r5, Q_r6;
	parameter sim_time = 110;
	registers_module reg_module (Q_r0, Q_r1, Q_r2, Q_r3, Q_r4, Q_r5, Q_r6, STO, D, CCE[2], CCE[1], CCE[0]);		
	initial #sim_time $finish;				
	initial begin
		D = 13'b0000111111111;
		CCE = 3'b101;
		STO = 3'b000;
		#10;
		CCE = 3'b111;
		#10;
		CCE = 3'b101;
		D = 13'b1100111111111;
		STO = 3'b001;
		#10;
		CCE = 3'b111;
		STO = 3'b010;
		D = 13'b1100110000011;
		#10;
		CCE = 3'b101;
		#10
		CCE = 3'b111;
		#10;
		STO = 3'b011;
		D = 13'b0000000000011;
		CCE = 3'b101;
		#10;
		CCE = 3'b111;
	end
	initial begin
		$display(" Clear  Clock  Enable  D              Q_r0            Q_r1          Q_r2          Q_r3          Q_r4            Q_r5            Q_r6");			
		$monitor(" %b         %b         %b %b %b %b %b %b %b %b %b", CCE[2], CCE[1], CCE[0], D, Q_r0, Q_r1, Q_r2, Q_r3, Q_r4, Q_r5, Q_r6);	
	end
endmodule