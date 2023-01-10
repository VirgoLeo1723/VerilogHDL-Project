module counterv(CLK,RESET,Q);
	input CLK,RESET;
	output reg [4:0] Q;
	
	
	always@(posedge CLK) begin
		if(!RESET) Q<=0;
		else Q<=Q+1;
	end
	
endmodule
