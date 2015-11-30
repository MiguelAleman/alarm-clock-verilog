module test_register_13bits();
	reg [2:0] CCE;	// Clear, Clock, Enable
	reg [12:0] D;
	wire [12:0] Q;
	wire [12:0] Q_n;
	parameter sim_time = 110;
	register_13bits reg1 (Q, Q_n, D, CCE[2], CCE[1], CCE[0]);		
	initial #sim_time $finish;				
	initial begin
		D = 13'b0000111111111;
		CCE = 3'b000;
		repeat (7) #10 CCE = CCE + 3'b001;
		#10;
		D = 13'b1111000111111;
		CCE = 3'b110;
		#10;
		CCE = 3'b111;
		#10;
		CCE = 3'b101;
		#10;
		CCE = 3'b110;
	end
	initial begin
		$display("TEST REGISTER 13 BITS");
		$display(" Clear  Clock  Enable D              Q            Q_n");			
		$monitor(" %b         %b         %b %b %b %b", CCE[2], CCE[1], CCE[0], D, Q, Q_n);	
	end
endmodule