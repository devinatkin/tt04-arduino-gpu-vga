`timescale 1ns/1ps

module MemoryArray640x480(
  input logic clk,       // Clock input
  input logic rst_n,     // Reset input (active low)
  input logic [9:0] addr, // Address input (10 bits for 640x480 addressing)
  input logic write_en,  // Write enable input
  input logic [5:0] data_in, // Data input (6 bits for each element)
  output logic [5:0] data_out // Data output (6 bits for each element)
);

// Declare the memory array as a register array
// The memory will have 640x480 elements, each being 6 bits wide
logic [5:0] memory[0:639][0:479];

// Sequential read and write operations are synchronized to the clock
always@(posedge clk or negedge rst_n)
begin
  if (!rst_n) // Asynchronous reset
  begin
    // Reset the entire memory array to 0 and 1 in a checkerboard pattern
    for (int i = 0; i < 640; i++)
      for (int j = 0; j < 480; j++)
        memory[i][j] <= (i ^ j) & 1 ? 6'b1 : 6'b0;
  end
  else // Synchronous read and write
  begin
    if (write_en)
      memory[addr[9:6]][addr[5:0]] <= data_in; // Write data_in to specified address
    else
      data_out <= memory[addr[9:6]][addr[5:0]]; // Read data from specified address
  end
end

endmodule
