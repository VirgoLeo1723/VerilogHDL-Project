module part4_t();
	reg	[10:0]value;
	wire 	[3:0]x_bus,y_bus,sum_bus;
	wire	[3:0]multi_bus, seg7_0_in_bus, seg7_0_out_bus;
	wire	[6:0]hex0_bus, hex1_bus;
	wire 	carry_bus, a_out_bus;
	wire	com_bus, select_bus;
	
	assign x_bus = value[4:0];
	assign y_bus = value[9:5];
	
//	circuitA 		inst0	(.A_in(x_bus), .A_out(a_out_bus));
//	comparew9 		inst1	(.com_in(x_bus), .com_out(com_out_bus));
//	
//	or select_char_1 		(select_bus,carry_bus,com_out_bus);
//	
//	multi_4bits 	inst4	(.out(seg7_0_in_bus), .in0(x_bus), .in1(a_out_bus), .s(select_bus));
//	one_to_4bits 	inst5	(.out(seg7_1_in_bus), .in(select_bus));
//	
//	seg7_control 	inst6	(.SEG7_IN(seg7_0_in_bus), .SEG7_OUT(hex0_bus));
//	seg7_control 	inst7	(.SEG7_IN(seg7_1_in_bus), .SEG7_OUT(hex1_bus));
	part4 			inst0 (.X(x_bus), .Y(y_bus), .HEX0(hex0_bus), .HEX1(hex1_bus));
	
	//initial $monitor("%t: X:%d, HEX:%b", $time, x_bus, hex0_bus);
	//initial $monitor("%t: X:%d, SUM:%d", $time, x_bus, sum_bus);
	initial $monitor("%t: X:%d, Y:%d, HEX0=%b, HEX1=%b", $time, x_bus, y_bus ,hex0_bus, hex1_bus);
	//initial $monitor("%t: IN:%d, OUT:%b", $time, x_bus, hex0_bus);
	//initial $monitor("%t: num:%d, carry:%d, -> HEX0=%b, HEX1=%b", $time, x_bus, carry, hex0_bus, hex1_bus);
	//initial $monitor("%t: num:%d carry:%d-> com_out:%d -> select:%d -> 1to4:%b", $time, x_bus, carry, com_bus, select_bus, multi_bus);
	//initial $monitor ("%t: num:%d, carry:%d -> +6:%d, comw9:%d -> select:%d ->seg7_0in:%d, seg7_1in:%d ->hex0:%b, hex1:%b",$time, x_bus, carry_bus, a_out_bus, com_out_bus, select_bus, seg7_0_in_bus, seg7_1_in_bus, hex0_bus, hex1_bus);
	//initial $monitor("%t: num:%d, carry:%d, -> HEX0=%b, HEX1=%b", $time, x_bus, carry, hex0_bus, hex1_bus);
	initial #20000 $finish;
	initial begin
		for (value=0; value<1024; value=value+1) begin #5; end
	end

endmodule