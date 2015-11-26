module test_decoder_8bits();
	reg [2:0] S;
	reg enable;
	wire [7:0] Y;	
	parameter sim_time = 630;
	decoder_8bits dec (Y, S, enable);
	initial #sim_time $finish;				
	initial begin
		enable = 1'b0;
		S = 3'b000;
		repeat (7) #10 S = S + 3'b001;
		#10;
		enable = 1'b1;
		S = 3'b000;
		repeat (7) #10 S = S + 3'b001;
	end
	initial begin
		$display(" S2   S1  S0  Enable     Y");
	    $monitor(" %b     %b   %b     %b   %b ", S[2], S[1], S[0], enable, Y);	
	end
endmodule