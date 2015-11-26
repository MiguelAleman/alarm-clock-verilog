module test_register_32bits();
	reg [2:0] CCE;	// Clear, Clock, Enable
	reg [1:0] D;
	wire [1:0] Q;
	wire [1:0] Q_n;
	parameter sim_time = 110;
	register_2bits reg1 (Q, Q_n, D, CCE[2], CCE[1], CCE[0]);		
	initial #sim_time $finish;				
	initial begin
		D = 2'b01;
		CCE = 3'b000;
		#10;
		CCE = 3'b101;
		#10;
		CCE = 3'b111;
		#10;
		CCE = 3'b101;
		#10;
		D = 2'b11;
		#10;
		CCE = 3'b101;
		#10;
		CCE = 3'b111;
	end
	initial begin
		$display(" Clear  Clock  Enable  D    Q   Q_n");			
		$monitor(" %b         %b         %b %b   %b   %b", CCE[2], CCE[1], CCE[0], D, Q, Q_n);	
	end
endmodule