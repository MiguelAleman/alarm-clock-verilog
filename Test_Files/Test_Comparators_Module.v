module test_comparator_module();
	reg [12:0] CT, Q_r0, Q_r1, Q_r2, Q_r3, Q_r4, Q_r5, Q_r6;	
	// Activate Alarm Output
	wire AA;
	parameter sim_time = 110;
	comparators_module comp_module (AA, CT, Q_r0, Q_r1, Q_r2, Q_r3, Q_r4, Q_r5, Q_r6);		
	initial #sim_time $finish;				
	initial begin
		Q_r0 = 13'b1111111111111;
		Q_r1 = 13'b1111111111110;
		Q_r2 = 13'b1111111111101;
		Q_r3 = 13'b1111111111011;
		Q_r4 = 13'b1111111110111;
		Q_r5 = 13'b1111111101111;
		Q_r6 = 13'b1111111011111;
		CT = 13'b1111111111111;
		#10;
		CT = 13'b1111111111110;
		#10;
		CT = 13'b1000111111111;
		#10;
		CT = 13'b1111000111111;
		#10;
		CT = 13'b1111111111011;
		#10;
		CT = 13'b1111111110111;
		#10;
		CT = 13'b1111111101111;
		#10;
		CT = 13'b1000001111111;
	end
	initial begin
		$display(" CT             R0           R1            R2            R3            R4            R5            R6           AA");			
		$monitor(" %b %b %b %b %b %b %b %b %b", CT, Q_r0, Q_r1, Q_r2, Q_r3, Q_r4, Q_r5, Q_r6, AA);	
	end
endmodule