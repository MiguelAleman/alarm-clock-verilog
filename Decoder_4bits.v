// Enable activo alto
module decoder_4bits(output reg [3:0] Y, input [1:0] S, input enable);
	always @ (S, enable)
		begin		
			if(enable)
				case(S)
					2'b00: Y = 4'b0001;
					2'b01: Y = 4'b0010;
					2'b10: Y = 4'b0100;
					2'b11: Y = 4'b1000;
				endcase
			else
				Y = 4'b0000;
		end
endmodule