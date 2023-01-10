module part3(M,U,V,W,X,S_1,S_0);
	input 	[1:0]U,V,W,X;
	input		S_1,S_0;
	output	[1:0]M;
	
//	assign 	M=	(S_0==0 && S_1==0)? U:
//					(S_0==1 && S_1==0)? V:
//					(S_0==0 && S_1==1)? W:X;
	assign 	M= ({2{S_0&S_1}}&X)|
					({2{~S_0&S_1}}&W)|
					({2{S_0&~S_1}}&V)|
					({2{~S_0&~S_1}}&U);
	
endmodule