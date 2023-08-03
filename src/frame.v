`timescale 1ns/1ps

module MemoryArray64x48(
  input logic clk,       // Clock input
  input logic rst_n,     // Reset input (active low)
  input logic [11:0] addr, // Address input (11 bits for 64x48 addressing)
  input logic write_en,  // Write enable input
  input logic [2:0] data_in, // Data input (6 bits for each element)
  output logic [2:0] data_out // Data output (6 bits for each element)
);

// Declare the memory array as a register array
// The memory will have 640x480 elements, each being 6 bits wide
logic [2:0] memory[0:3071];

// Sequential read and write operations are synchronized to the clock
always@(posedge clk)
begin
  if (~rst_n) // Asynchronous reset
  begin
    // Reset the entire memory array to 0 and 1 in a checkerboard pattern
    for (int i = 0; i < 3071; i++)
        memory[i] <= 3'b010;
  end
  else // Synchronous read and write
  begin
    if (write_en)
      memory[addr] <= data_in; // Write data_in to specified address
    else
      data_out <= memory[addr]; // Read data from specified address
  end
end

endmodule
