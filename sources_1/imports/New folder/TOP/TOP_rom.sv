module TOP_rom (
	input logic clock,
	input logic [9:0] address,
	output logic [0:0] q
);

logic [0:0] memory [0:879] /* synthesis ram_init_file = "./TOP/TOP.mif" */;

always_ff @ (posedge clock) begin
	q <= memory[address];
end

endmodule
