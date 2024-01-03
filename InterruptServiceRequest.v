  module Interrupt_In_Service (
    // Inputs
    input   wire   [2:0]    interrupt,
    input   wire            latch_in_service,
    input   wire   [2:0]    end_of_interrupt,

    // Outputs
    output  reg   [2 :0]    in_service_register
   
);


    always @* begin
        // Logic to set or clear bits based on conditions
            in_service_register <= (latch_in_service) ? (interrupt & ~end_of_interrupt) : 8'b000;
                                        
    end

endmodule

`timescale 1ns/1ps

module Interrupt_In_Service_tb;

  // Parameters
  parameter PERIOD = 10;

  // Inputs
  reg [2:0] interrupt;
  reg latch_in_service;
  reg [2:0] end_of_interrupt;

  // Outputs
  wire [2:0] in_service_register;

  // Instantiate the module
  Interrupt_In_Service uut (
    .interrupt(interrupt),
    .latch_in_service(latch_in_service),
    .end_of_interrupt(end_of_interrupt),
    .in_service_register(in_service_register)
  );

  // Clock generation
  reg clk = 0;
  always #((PERIOD / 2)) clk = ~clk;

  // Testbench behavior
  initial begin
    // Initialize inputs
    interrupt = 3'b000;
    latch_in_service = 1;
    end_of_interrupt = 3'b000;

    // Apply some test cases
    #10 interrupt = 3'b001;  // Set some interrupt bits
    #10 latch_in_service = 1; // Enable latch
    #10 end_of_interrupt = 3'b010; // Set some end_of_interrupt bits
    #10; // Wait for some time
    #10; // Wait for some time

    // Add more test cases as needed

    // Stop the simulation
    #10 $stop;
  end

  // Clock generation
  always #5 clk = ~clk;

endmodule

