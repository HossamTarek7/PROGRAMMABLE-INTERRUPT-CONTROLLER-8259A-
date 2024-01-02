
  module Interrupt_In_Service (
    // Inputs
    input   wire   [2:0]    priority_rotate,
    input   wire   [7:0]    interrupt_special_mask,
    input   wire   [7:0]    interrupt,
    input   wire            latch_in_service,
    input   wire   [7:0]    end_of_interrupt,

    // Outputs
    output  reg   [7:0]    in_service_register,
    output  reg   [7:0]    highest_level_in_service
);

    // In service register
    reg   [7:0]   next_in_service_register;
    
    in_service_register = 8'b00000000;

    always @* begin
        // Logic to set or clear bits based on conditions
            next_in_service_register <= (in_service_register & ~end_of_interrupt)
                                       | (latch_in_service ? (interrupt) : 8'b00000000);
        // Synchronize the output with the next_in_service_register
        in_service_register <= next_in_service_register;
    end

endmodule

