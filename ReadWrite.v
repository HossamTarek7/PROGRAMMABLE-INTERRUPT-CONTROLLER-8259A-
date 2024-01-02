module bus_control_logic(
     input CS,
     input RD,
     input WR,
     input Address,
     input [7:0] Data_in,
     
     output reg [7:0] internal_data_bus,
     output  Icw1,
     output  Icw2,
     output  Icw3,
     output  Icw4,
     
     output  Ocw1,
     output  Ocw2,
     output  Ocw3,
     output  read    
);
     reg prev_WR;
     wire Write_flag;
     reg A0;

  always @* begin
    // CS is used as a clock enable
    if (~CS) begin
      // When CS is low, capture the value of WR
      prev_WR <= WR;
    end
  end

  always @* begin
    // CS is used as a clock enable
    if (~CS) begin
      // When CS is low, capture the value of Address[0]
      A0 <= Address;
    end
  end

  always @* begin
    // Data input logic
    if (~WR & ~CS) begin
      // When both WR and CS are low, update internal_data_bus
      internal_data_bus <= Data_in;
    end
  end

  // Write_flag logic
  assign Write_flag = ~prev_WR & ~WR;

  // Icw1, Icw2, Icw4 logic
  assign Icw1 = Write_flag & ~A0 & internal_data_bus[4];
  assign Icw2 = Write_flag & A0;
  assign Icw4 = Write_flag & A0 & internal_data_bus[0];

  // Ocw1, Ocw2, Ocw3 logic
  assign Ocw1 = Write_flag & A0;
  assign Ocw2 = Write_flag & ~A0 & ~internal_data_bus[4] & ~internal_data_bus[3];
  assign Ocw3 = Write_flag & ~A0 & ~internal_data_bus[4] & internal_data_bus[3] & internal_data_bus[7];

  assign read = ~CS & ~RD;
 

endmodule



`timescale 1ns/1ps

module bus_control_logic_tb;

  // Inputs
  reg CS, RD, WR;
  reg [7:0] Address, Data_in;

  // Outputs
  wire [7:0] internal_data_bus;
  wire Icw1, Icw2, Icw3, Icw4, Ocw1, Ocw2, Ocw3, read;

  // Instantiate the module
  bus_control_logic uut (
    .CS(CS),
    .RD(RD),
    .WR(WR),
    .Address(Address),
    .Data_in(Data_in),
    .internal_data_bus(internal_data_bus),
    .Icw1(Icw1),
    .Icw2(Icw2),
    .Icw3(Icw3),
    .Icw4(Icw4),
    .Ocw1(Ocw1),
    .Ocw2(Ocw2),
    .Ocw3(Ocw3),
    .read(read)
  );

  // Clock generation
  reg clk = 0;
  always #5 clk = ~clk;

  // Initial block for test stimulus
  initial begin
    // Initialize inputs
    CS = 1;
    RD = 1;
    WR = 1;
    Address = 8'h00;
    Data_in = 8'h00;

    // Apply some test vectors
    // Test case 1
    CS = 0;
    WR = 0;
    Address = 8'h01;
    Data_in = 8'h0A;
    #10;
    CS = 1;
    #10;
    // Observe outputs or add assertions as needed
    $display("Test Case 1: internal_data_bus = %h, Icw1 = %b, Icw2 = %b, Icw3 = %b, Icw4 = %b, Ocw1 = %b, Ocw2 = %b, Ocw3 = %b, read = %b",
             internal_data_bus, Icw1, Icw2, Icw3, Icw4, Ocw1, Ocw2, Ocw3, read);

    // Test case 2
    CS = 0;
    WR = 1;
    RD = 0;
    Address = 8'h02;
    Data_in = 8'h05;
    #10;
    CS = 1;
    #10;
    // Observe outputs or add assertions as needed
    $display("Test Case 2: internal_data_bus = %h, Icw1 = %b, Icw2 = %b, Icw3 = %b, Icw4 = %b, Ocw1 = %b, Ocw2 = %b, Ocw3 = %b, read = %b",
             internal_data_bus, Icw1, Icw2, Icw3, Icw4, Ocw1, Ocw2, Ocw3, read);

    // Add more test cases as needed

    // Stop simulation
    $stop;
  end

endmodule























