module comparator_13bits(output reg EQ, input wire [12:0] A, input wire [12:0] B);
	always @* begin
    	if (A==B) begin
        	EQ <= 1'b1;
    	end
      	else begin
        	EQ <= 1'b0;
      	end
    end
endmodule