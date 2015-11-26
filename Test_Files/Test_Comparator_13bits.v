module test_comparator_13bits();
	reg [12:0] A,B;
	// EQ = 1 (inputs are equal)
	wire EQ;	
	parameter sim_time = 630;
	comparator_13bits comparator (EQ, A, B);
	initial #sim_time $finish;				
	initial begin
		A = 13'b0000000000000;
		B = 13'b0000000000000;
		#10;
		B = 13'b0000000000100;
		#10;
		A = 13'b1111111111111;
		B = 13'b1111111111111;
		#10;
	end
	initial begin
		$display(" A               B              EQ");
	    $monitor(" %b   %b   %b", A, B, EQ);	
	end
endmodule