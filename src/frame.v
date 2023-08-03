`timescale 1ns/1ps

module MemoryArray40x30(
  input logic clk,       // Clock input
  input logic rst_n,     // Reset input (active low)
  input logic [10:0] addr, // Address input (11 bits)
  input logic write_en,  // Write enable input
  input logic [1:0] data_in, // Data input (6 bits for each element)
  output logic [1:0] data_out // Data output (6 bits for each element)
);

// Declare the memory array as a register array
// The memory will have 40*30 = 1200 elements, each 3 bits wide
logic [1:0] memory[0:1199];

// Sequential read and write operations are synchronized to the clock
always@(posedge clk)
begin
  if (~rst_n) // Sync reset
  begin
    // Reset the entire memory array to 0 and 1 in a checkerboard pattern
    for (int i = 0; i < 1200; i++)
        memory[i] = 2'b01;
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
