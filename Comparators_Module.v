module comparators_module( output reg AA, input [12:0] CT, Q_r0, Q_r1, Q_r2, Q_r3, Q_r4, Q_r5, Q_r6);
	wire [6:0] EQ;
	comparator_13bits comp1 (EQ[0], CT, Q_r0);
	comparator_13bits comp2 (EQ[1], CT, Q_r1);
	comparator_13bits comp3 (EQ[2], CT, Q_r2);
	comparator_13bits comp4 (EQ[3], CT, Q_r3);
	comparator_13bits comp5 (EQ[4], CT, Q_r4);
	comparator_13bits comp6 (EQ[5], CT, Q_r5);
	comparator_13bits comp7 (EQ[6], CT, Q_r6);
	always @* begin
    	if (EQ==7'b0000000) begin
        	AA <= 1'b0;
    	end
      	else begin
        	AA <= 1'b1;
      	end
    end
endmodule