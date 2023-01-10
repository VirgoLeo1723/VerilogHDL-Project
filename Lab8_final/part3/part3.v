module part3 (CLK, ADDRESS, DATA_IN, WREN, display_add0, display_add1, display_in, display_out);
	input		CLK, WREN;
	input		[4:0]ADDRESS;
	input		[3:0]DATA_IN;
	output	[6:0]display_in, display_out, display_add0, display_add1;
	
	reg		[3:0]RAM32X4[31:0];
	reg 		[3:0]DATA_OUT;
	
	always @(posedge CLK) 
		if (WREN) RAM32X4[ADDRESS] <= DATA_IN;
	
	always @(posedge CLK)
		if (WREN) DATA_OUT <= DATA_IN;
		else DATA_OUT <= {4{~WREN}} & RAM32X4[ADDRESS];
	
	control7SEG	data_in 	(.IN(DATA_IN), 	.OUT(display_in));
	control7SEG	data_out (.IN(DATA_OUT), 	.OUT(display_out));
	control7SEG	address0	(.IN(ADDRESS%16), .OUT(display_add0));
	control7SEG	address1	(.IN(ADDRESS/16), .OUT(display_add1));
	
endmodule

module control7SEG (IN,OUT);
  input [3:0] IN;
  output reg [6:0] OUT;
  always begin
    case(IN)
		0:OUT=7'b1000000;
      1:OUT=7'b1111001;
      2:OUT=7'b0100100;
      3:OUT=7'b0110000;
      4:OUT=7'b0011001;
      5:OUT=7'b0010010;
      6:OUT=7'b0000010;
      7:OUT=7'b1111000;
      8:OUT=7'b0000000;
      9:OUT=7'b0011000;
      10:OUT=7'b0001000;
      11:OUT=7'b0000011;
      12:OUT=7'b1000110;
      13:OUT=7'b0100001;
      14:OUT=7'b0000110;
      15:OUT=7'b0001110;
    endcase
  end
endmodule