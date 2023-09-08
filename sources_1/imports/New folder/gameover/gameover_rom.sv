module gameover_rom (
	input logic clock,
	input logic [16:0] address,
	output logic [0:0] q
);

logic [0:0] memory [0:76799] /* synthesis ram_init_file = "./gameover/gameover.mif" */;

always_ff @ (posedge clock) begin
	q <= memory[address];
end

endmodule
