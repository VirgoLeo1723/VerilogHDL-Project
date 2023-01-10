module part6(SW,HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, HEX6, HEX7);
	input 	[2:0]SW;
	output 	[6:0]HEX0,HEX1,HEX2, HEX3, HEX4, HEX5, HEX6, HEX7;
	wire		[55:0]hex0,hex1,hex2,hex3,hex4,hex5,hex6,hex7;
	wire		[55:0]temp;

	assign hex0 = {7'b1111111,7'b1111111,7'b1111111,7'b1111111,7'b0100001,7'b0000110,7'b1111001,7'b1111111};
	assign hex1 = {7'b1111111,7'b1111111,7'b1111111,7'b0100001,7'b0000110,7'b1111001,7'b1111111,7'b1111111};
	assign hex2 = {7'b1111111,7'b1111111,7'b0100001,7'b0000110,7'b1111001,7'b1111111,7'b1111111,7'b1111111};
	assign hex3 = {7'b1111111,7'b0100001,7'b0000110,7'b1111001,7'b1111111,7'b1111111,7'b1111111,7'b1111111};
	assign hex4 = {7'b0100001,7'b0000110,7'b1111001,7'b1111111,7'b1111111,7'b1111111,7'b1111111,7'b1111111};
	assign hex5 = {7'b0000110,7'b1111001,7'b1111111,7'b1111111,7'b1111111,7'b1111111,7'b1111111,7'b0100001};
	assign hex6 = {7'b1111001,7'b1111111,7'b1111111,7'b1111111,7'b1111111,7'b1111111,7'b0100001,7'b0000110};
	assign hex7 = {7'b1111111,7'b1111111,7'b1111111,7'b1111111,7'b1111111,7'b0100001,7'b0000110,7'b1111001};
	
	assign temp = (SW==0)?hex0: 
					  (SW==1)?hex1:
					  (SW==2)?hex2:
					  (SW==3)?hex3:
					  (SW==4)?hex4:
					  (SW==5)?hex5:
					  (SW==6)?hex6:hex7;
					  
	assign HEX0 = temp[6:0];
	assign HEX1 = temp[13:7];
	assign HEX2 = temp[20:14];
	assign HEX3 = temp[27:21];
	assign HEX4 = temp[34:28];
	assign HEX5 = temp[41:35];
	assign HEX6 = temp[48:42];
	assign HEX7 = temp[55:49];
	
endmodule