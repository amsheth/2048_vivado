module tiles_rom (
	input logic clock,
	input logic [16:0] address,
	output logic [2:0] q
);

logic [2:0] memory [0:119999] /* synthesis ram_init_file = "./tiles/tiles.mif" */;
//initial $readmemh(".C:\Users\Arnav\Downloads\Final Proj\New folder\tiles\tiles.mif",  memory);
always_ff @ (posedge clock) begin
	q <= memory[address];
end

endmodule
