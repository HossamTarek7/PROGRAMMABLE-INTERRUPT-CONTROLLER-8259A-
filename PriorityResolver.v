module Priority_Resolver (
    input [7:0] IRR /* Input from Interrupt Request Register */,
    input clear /* Input from Interrupt Service Register */,
    input set /* Input to set flags */,
    input reset /* Input to reset flags */,
    output reg [2:0] resolved_interrupt /* Output to Interrupt Service Register */
);

    reg [2:0] priority_status [0:7];  // Priority status array
    reg [2:0] selected;  // Selected interrupt to be serviced
    reg [2:0] iterator [0:7];  // Iterator array for priority rotation
    
    reg prevset = 0;  // Previous set flag
    reg prevreset = 1;  // Previous reset flag

    always @* begin
        // Initialize priority status
        if ((prevset == 0 && set == 1) || (prevreset == 1 && reset == 0)) begin
            // Set initial priority status
            priority_status[0] = 0; // Highest priority
            priority_status[1] = 1;
            priority_status[2] = 2;
            priority_status[3] = 3;
            priority_status[4] = 4;
            priority_status[5] = 5;
            priority_status[6] = 6;
            priority_status[7] = 7; // Lowest priority

            prevset = set; // Update previous set flag
            prevreset = reset; // Update previous reset flag
        end

        if (set || !reset) begin
            /* Automatic Rotation mode */
            // Determine priority based on current interrupt status
            iterator[0] = (priority_status[0] == 0) ? 0 : // Highest priority
                           (priority_status[1] == 0) ? 1 :
                           (priority_status[2] == 0) ? 2 :
                           (priority_status[3] == 0) ? 3 :
                           (priority_status[4] == 0) ? 4 :
                           (priority_status[5] == 0) ? 5 :
                           (priority_status[6] == 0) ? 6 : 7;
            iterator[1] = (priority_status[0] == 1) ? 0 :
                           (priority_status[1] == 1) ? 1 :
                           (priority_status[2] == 1) ? 2 :
                           (priority_status[3] == 1) ? 3 :
                           (priority_status[4] == 1) ? 4 :
                           (priority_status[5] == 1) ? 5 :
                           (priority_status[6] == 1) ? 6 : 7;
            iterator[2] = (priority_status[0] == 2) ? 0 :
                           (priority_status[1] == 2) ? 1 :
                           (priority_status[2] == 2) ? 2 :
                           (priority_status[3] == 2) ? 3 :
                           (priority_status[4] == 2) ? 4 :
                           (priority_status[5] == 2) ? 5 :
                           (priority_status[6] == 2) ? 6 : 7;
            iterator[3] = (priority_status[0] == 3) ? 0 :
                           (priority_status[1] == 3) ? 1 :
                           (priority_status[2] == 3) ? 2 :
                           (priority_status[3] == 3) ? 3 :
                           (priority_status[4] == 3) ? 4 :
                           (priority_status[5] == 3) ? 5 :
                           (priority_status[6] == 3) ? 6 : 7;
            iterator[4] = (priority_status[0] == 4) ? 0 :
                           (priority_status[1] == 4) ? 1 :
                           (priority_status[2] == 4) ? 2 :
                           (priority_status[3] == 4) ? 3 :
                           (priority_status[4] == 4) ? 4 :
                           (priority_status[5] == 4) ? 5 :
                           (priority_status[6] == 4) ? 6 : 7;
            iterator[5] = (priority_status[0] == 5) ? 0 :
                           (priority_status[1] == 5) ? 1 :
                           (priority_status[2] == 5) ? 2 :
                           (priority_status[3] == 5) ? 3 :
                           (priority_status[4] == 5) ? 4 :
                           (priority_status[5] == 5) ? 5 :
                           (priority_status[6] == 5) ? 6 : 7;
            iterator[6] = (priority_status[0] == 6) ? 0 :
                           (priority_status[1] == 6) ? 1 :
                           (priority_status[2] == 6) ? 2 :
                           (priority_status[3] == 6) ? 3 :
                           (priority_status[4] == 6) ? 4 :
                           (priority_status[5] == 6) ? 5 :
                           (priority_status[6] == 6) ? 6 : 7;
            iterator[7] = (priority_status[0] == 7) ? 0 :
                           (priority_status[1] == 7) ? 1 :
                           (priority_status[2] == 7) ? 2 :
                           (priority_status[3] == 7) ? 3 :
                           (priority_status[4] == 7) ? 4 :
                           (priority_status[5] == 7) ? 5 :
                           (priority_status[6] == 7) ? 6 : 7;

            // Choose interrupt based on iterator
            if (IRR[iterator[0]] == 1'b1) begin
                resolved_interrupt = 0; 
                selected = iterator[0];
            end else if (IRR[iterator[1]] == 1'b1) begin
                resolved_interrupt = 1; 
                selected = iterator[1];
            end else if (IRR[iterator[2]] == 1'b1) begin
                resolved_interrupt = 2; 
                selected = iterator[2];
            end else if (IRR[iterator[3]] == 1'b1) begin
                resolved_interrupt = 3; 
                selected = iterator[3];
            end else if (IRR[iterator[4]] == 1'b1) begin
                resolved_interrupt = 4; 
                selected = iterator[4];
            end else if (IRR[iterator[5]] == 1'b1) begin
                resolved_interrupt = 5; 
                selected = iterator[5];
            end else if (IRR[iterator[6]] == 1'b1) begin
                resolved_interrupt = 6; 
                selected = iterator[6];
            end else if (IRR[iterator[7]] == 1'b1) begin
                resolved_interrupt = 7;
                selected = iterator[7]; 
            end

            // Rotation
            priority_status[selected] = 7;               
            selected = (selected) > 0 ? (selected-1) : 7;         
            priority_status[selected] = 6;               
            selected = (selected) > 0 ? (selected-1) : 7;
            priority_status[selected] = 5;               
            selected = (selected) > 0 ? (selected-1) : 7;
            priority_status[selected] = 4;               
            selected = (selected) > 0 ? (selected-1) : 7;
            priority_status[selected] = 3;                
            selected = (selected) > 0 ? (selected-1) : 7;
            priority_status[selected] = 2;             
            selected = (selected) > 0 ? (selected-1) : 7;
            priority_status[selected] = 1;              
            selected = (selected) > 0 ? (selected-1) : 7;
            priority_status[selected] = 0;              
        end else begin
            // Fully nested mode
            if (IRR[0] == 1'b1) begin
                resolved_interrupt = 0;
            end else if (IRR[1] == 1'b1) begin
                resolved_interrupt = 1;
            end else if (IRR[2] == 1'b1) begin
                resolved_interrupt = 2;
            end else if (IRR[3] == 1'b1) begin
                resolved_interrupt = 3;
            end else if (IRR[4] == 1'b1) begin
                resolved_interrupt = 4;
            end else if (IRR[5] == 1'b1) begin
                resolved_interrupt = 5;
            end else if (IRR[6] == 1'b1) begin
                resolved_interrupt = 6;
            end else if (IRR[7] == 1'b1) begin
                resolved_interrupt = 7;
            end else begin 
                // Default: no interrupt
            end
        end

        if (clear) begin
            // Clear resolved interrupt when clear signal is active
            resolved_interrupt = 0;
        end
    end
endmodule
