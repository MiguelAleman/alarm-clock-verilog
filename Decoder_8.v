// Enable activo alto
module decoder_8(output reg [7:0] Y, input [2:0] S, input enable);
	always @ (S, enable)
		begin		
			if(enable)
				case(S)
					3'b000: Y = 8'b00000001;
					3'b001: Y = 8'b00000010;
					3'b010: Y = 8'b00000100;
					3'b011: Y = 8'b00001000;
					3'b100: Y = 8'b00010000;
					3'b101: Y = 8'b00100000;
					3'b110: Y = 8'b01000000;
					3'b111: Y = 8'b10000000;
				endcase
			else
				Y = 8'b00000000;
		end
endmodule