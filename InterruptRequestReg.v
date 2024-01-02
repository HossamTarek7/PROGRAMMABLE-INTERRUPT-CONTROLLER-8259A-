module Interrupt_Request (
    input [7:0] interrupt_request_pins,
    input [7:0] interrupt_mask_request,
    output reg [7:0] IRR,
    input level_or_edge_triggered
);

    reg [7:0] interrupt_previous_request;

    always @* begin
        if (level_or_edge_triggered) begin  // level triggered
            // Set the interrupt requests in interrupt request register
            IRR[0] <= interrupt_request_pins[0] & ~interrupt_mask_request[0];
            IRR[1] <= interrupt_request_pins[1] & ~interrupt_mask_request[1];
            IRR[2] <= interrupt_request_pins[2] & ~interrupt_mask_request[2];
            IRR[3] <= interrupt_request_pins[3] & ~interrupt_mask_request[3];
            IRR[4] <= interrupt_request_pins[4] & ~interrupt_mask_request[4];
            IRR[5] <= interrupt_request_pins[5] & ~interrupt_mask_request[5];
            IRR[6] <= interrupt_request_pins[6] & ~interrupt_mask_request[6];
            IRR[7] <= interrupt_request_pins[7] & ~interrupt_mask_request[7];
        end
        else begin  // edge triggered
            IRR[0] <= (interrupt_request_pins[0] & ~interrupt_mask_request[0]) & ~interrupt_previous_request[0];
            IRR[1] <= (interrupt_request_pins[1] & ~interrupt_mask_request[1]) & ~interrupt_previous_request[1];
            IRR[2] <= (interrupt_request_pins[2] & ~interrupt_mask_request[2]) & ~interrupt_previous_request[2];
            IRR[3] <= (interrupt_request_pins[3] & ~interrupt_mask_request[3]) & ~interrupt_previous_request[3];
            IRR[4] <= (interrupt_request_pins[4] & ~interrupt_mask_request[4]) & ~interrupt_previous_request[4];
            IRR[5] <= (interrupt_request_pins[5] & ~interrupt_mask_request[5]) & ~interrupt_previous_request[5];
            IRR[6] <= (interrupt_request_pins[6] & ~interrupt_mask_request[6]) & ~interrupt_previous_request[6];
            IRR[7] <= (interrupt_request_pins[7] & ~interrupt_mask_request[7]) & ~interrupt_previous_request[7];
        end
    end

endmodule


`timescale 1ns / 1ps  // Adjust the timescale as needed

module tb_Interrupt_Request;

    // Inputs
    reg [7:0] interrupt_request_pins;
    reg [7:0] interrupt_mask_request;
    reg level_or_edge_triggered;

    // Outputs
    wire [7:0] IRR;

    // Instantiate the module under test
    Interrupt_Request uut (
        .interrupt_request_pins(interrupt_request_pins),
        .interrupt_mask_request(interrupt_mask_request),
        .IRR(IRR),
        .level_or_edge_triggered(level_or_edge_triggered)
    );

    // Initial block for stimulus and monitoring
    initial begin
        // Apply stimulus
        interrupt_request_pins = 8'b11000111;  // Set your test values
        interrupt_mask_request = 8'b10000001;  // Set your test values
        level_or_edge_triggered = 1'b1;  // 0 for edge-triggered, 1 for level-triggered

        // Monitor outputs
        $monitor("Time=%0t => IRR=%b", $time, IRR);

        // Add more test scenarios as needed

        // End simulation after a certain time
        #100 $finish;
    end

endmodule



