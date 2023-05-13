module Rand(input Clk,input Reset,
				output logic [12:0]randCount);
always_ff @ (posedge Clk)
	begin
		if (Reset)
			randCount <=0;
		else if (randCount == 11'b11111111111)
			randCount <=0;
		else randCount <= randCount + 1;
	
	end
endmodule