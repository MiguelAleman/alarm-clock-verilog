module segment_7_dec (output reg [6:0] display, input [3:0] bcd, input enable);
always @* begin
	if(enable) begin
  		case(bcd)
  		4'b0000: display = 7'b1111110;
  		4'b0001: display = 7'b0110000;
  		4'b0010: display = 7'b1101101;
  		4'b0011: display = 7'b1111001;
  		4'b0100: display = 7'b0110011;
  		4'b0101: display = 7'b1011011;
  		4'b0110: display = 7'b1011111;
  		4'b0111: display = 7'b1110000;
  		4'b1000: display = 7'b1111111;
  		4'b1001: display = 7'b1111011;
  		4'b1010: display = 7'b1110111;
  		4'b1011: display = 7'b0011111;
  		4'b1100: display = 7'b1001110;
  		4'b1101: display = 7'b0111101;
  		4'b1110: display = 7'b1001111;
  		4'b1111: display = 7'b1000111;
  		default: display = 7'b0000000; 
  		endcase
  		//display = ~display; 
  	end
  	else display = 7'b0000000;
end
endmodule