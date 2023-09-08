module reg_11 (input  logic Clk, Reset, Load,
              input  logic [11:0]  D,
              output logic [11:0]  Data_Out);

    always_ff @ (posedge Clk)
    begin
	 	 if (Reset) //notice, this is a sycnrhonous reset, which is recommended on the FPGA
			  Data_Out <= 11'h0;
		 else if (Load)
			  Data_Out <= D;
	 end

endmodule

module flp 
(
	input		Clk, Load, Reset, D,
	output	logic Q
);


	always_ff @ (posedge Clk)
	begin
			if (Reset)
				Q <= 1'b0;
			else
				if (Load)
					Q<=D;
				else
					Q <= Q;
	end 
endmodule