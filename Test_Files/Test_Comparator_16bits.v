module test_comparator_16bits();
	reg Clr, Clk;
	wire [15:0] COUNT;	
	parameter sim_time = 630;
	counter_16bits counter (COUNT, Clr, Clk);
	initial #sim_time $finish;				
	initial begin
		Clr = 1'b0;
		Clk = 3'b0;
		repeat (4) #10 Clk <= ~Clk;
		#10;
		Clr = 1'b1;
		repeat (20) #10 Clk <= ~Clk;
	end
	initial begin
		$display(" Clr   Clk  COUNT");
	    $monitor(" %b     %b   %b",Clr, Clk, COUNT);	
	end
endmodule