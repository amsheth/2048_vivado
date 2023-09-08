module title_rom (
	input logic clock,
	input logic [13:0] address,
	output logic [0:0] q
);

logic [0:0] memory [0:8479] /* synthesis ram_init_file = "./title/title.mif" */;

always_ff @ (posedge clock) begin
	q <= memory[address];
end

endmodule
