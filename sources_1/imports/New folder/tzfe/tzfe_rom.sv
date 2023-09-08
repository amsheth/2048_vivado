module tzfe_rom (
	input logic clock,
	input logic [17:0] address,
	output logic [0:0] q
);

logic [0:0] memory [0:230399] /* synthesis ram_init_file = "./tzfe/tzfe.mif" */;

always_ff @ (posedge clock) begin
	q <= memory[address];
end

endmodule
