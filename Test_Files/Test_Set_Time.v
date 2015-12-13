module test_set_time(output[6:0] display, days, output[3:0] segment, output Vcc_out, input TOF, ID, IH, IM, Clk);
	supply1 Vcc;
	supply0 Gnd;
	assign Vcc_out = Vcc;
	wire Clk_sys;
	frequency_converter conv (Clk_sys, Clk, Vcc);
	
	wire [15:0] STO;
	set_time_module set_module (STO, 15'd1, 13'd0, 13'd0, 13'd0, 13'd0, 13'd0, 13'd0, 13'd0, Gnd, TOF, Gnd, ID, Gnd, Gnd, Gnd, Vcc, IH, IM, Gnd, Clk_sys);	
	wire[6:0] out3, out2, out1, out0;
	wire AM, PM, DBlink;
	display_module disp(out3, out2, out1, out0, days, AM, PM, DBlink, 2'b10, 2'b01, 2'b01, 15'd1, STO, Vcc, Clk_sys);
	
	
	wire[1:0] count_out;
	
	counter_0_3_display counter (count_out, Vcc, Vcc, Gnd, Vcc, Vcc, Clk_sys, Vcc);
	
	wire[3:0] dec_out;
	
	decoder_4bits dec_display(dec_out, count_out, Vcc);
	
	assign segment = ~dec_out;
	
	
	wire[6:0] mux_display_o;
	
	mux_4x1_7bits mux_display(mux_display_o, count_out, out3, out2, out1, out0);
	
	assign display = ~mux_display_o; 
endmodule