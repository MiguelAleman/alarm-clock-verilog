module hour_decoder(output reg A, AM_PM, output reg [3:0] B, input [4:0] H);
	always @ (H)
		begin
			A <= (~H[4] & ~H[3] & ~H[2] & ~H[1] & ~H[0]) | (H[3] & ~H[2] & H[1]) | (H[4] & H[2] & H[1]) | (H[3] & H[2] & ~H[1] & ~H[0]);
			B[3] <= (H[3] & ~H[2] & ~H[1]) | (H[4] & H[2] & ~H[1]);
			B[2] <= (H[4] & ~H[2]) | (~H[4] & ~H[3] & H[2]);
			B[1] <= (~H[4] & ~H[3] & ~H[2] & ~H[1] & ~H[0]) | (~H[3] & ~H[2] & H[1]) | (~H[4] & H[2] & H[1]) + (H[3] & H[2] & ~H[1] & ~H[0]);
			B[0] <= H[0];
			AM_PM <= (~H[4] & ~H[3]) | (~H[4] & ~H[2]);
		end
endmodule