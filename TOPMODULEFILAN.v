module PIC(
   input [7:0] interrupt_request_pins,
   
   //Data Buffer
   input [7:0] INPUT_Data,
   output [7:0] OUTPUT_Data,
   
   //READ Write
   
   input wire RD,
   input wire WR,
   input wire A0,
   input wire CS,
   
   //Cascade 
   input [2:0] IN_CAS0_2,
   input wire SP_EN,
   output [2:0] OUT_CAS0_2,
   
   //Contol logic
   output INT,
   input wire INTAC
  );
  
  reg [7:0] interrupt_mask_request=8'b10000000; 
  reg[7:0] OUT_Interrupt_Request; 
  Interrupt_Request uut (
        .interrupt_request_pins(interrupt_request_pins), //From Processor
        .interrupt_mask_request(interrupt_mask_request), //From Control logic
        .IRR(OUT_Interrupt_Request; ), //OUT To Priority_Resolver
        .level_or_edge_triggered(OUT_L_E)// input from Control 
    );
    
reg[7:0] OUT_Priority_Resolver ; 
    Priority_Resolver dut (
        .IRR(OUT_Interrupt_Request; ), //input from Interrupt_Request
        .clear(clear),//input from Control
        .set((OUR_ROTATE_MODE)),//input from Control
        .reset(!OUR_ROTATE_MODE),//input from Control
        .resolved_interrupt(OUT_Priority_Resolver)//Out ISR
    );
  
reg[7:0] OUT_ISR_TO_CONTROL;
  Interrupt_In_Service  ISS (
  //input from Control
  .interrupt(OUT_Priority_Resolver ), //input from Priority_Resolver
  .latch_in_service(), //input from Control
  .end_of_interrupt()//input from Control
  .in_service_register(OUT_ISR_TO_CONTROL;) //OUTput to control logic
  );
reg [7:0] OUT_Bus_FROM_Data_BUFFER;
reg ICW1;
reg ICW2;
reg ICW3;
reg ICW4;
reg OCW1;
reg OCW2;
reg OCW3;

   bus_control_logic READWRITE(
      .CS(CS),
      .RD(RD),
      .WR(WR),
      //.Address(A0),
     .Data_in(INPUT_Data), 
     
   //OUTPUTS  
     .internal_data_bus(OUT_Bus_FROM_Data_BUFFER),
      .Icw1(ICW1;),
       .Icw2(ICW2);
     .  Icw3(ICW3),
       .Icw4(ICW4),
     
       .Ocw1(OCW1),
       .Ocw2(OCW2),
       .Ocw3(OCW3),
       .read(RD)    
);
reg INPIT_PROCESSOR_ACK;
reg[7:0] OUT_VECTOR_ADDRESS;
reg OUT_L_E;
reg ADE;
reg OUR_ROTATE_MODE;
reg OUT_SPE_OR_NON;
  ControlLogic control(
     //inputs from line 988
     .Icw1(ICW1),
     .Icw2(ICW2),
     .Icw3(ICW3),
     .Icw4(ICW4),
     
      .Ocw1(OCW1),
       .Ocw2(OCW2),
       .Ocw3(OCW3),
       .read(RD) ,
     .sp_en(SP_EN), //master or slave PIC
      .ACK(INPIT_PROCESSOR_ACK;), //input from Processor
     
   //input from ISR
     .end_of_interrupt(end_of_interrupt), //output to ISR
    .CasIn(IN_Cas0_2),
     .CasOut(OUT_CAS0_2),
     
     .highest_level_in_service(OUT_ISR_TO_CONTROL),//input from ISR

     
     .INTACK(INTACK) ,//input From Processor 
     .internal_data_bus(internal_data_bus),  //input from Data buffer
      .flagOfSend(flagOfSend),
  
     output reg [7:0]Slave,
     .interrupt_vector_address(OUT_VECTOR_ADDRESS),
    
    .level_or_edge_triggered(OUT_L_E), //0-->edge triggered     1-->level triggered //LTIM
    .call_address_interval(ADE),
    .auto_rotate_mode(OUR_ROTATE_MODE),
    .non_specific_end_of_interrupt(OUT_SPE_OR_NON)
);
  
endmodule

module CascadeTopModule(

)

/*****MASTER******/
reg[7:0] INPUT_DATA=8'b11111111;
reg[7:0] OUTPUT_DATA
reg [7:0]interrupt_request_pins=8'b1110001;
reg [2:0]OUTCASCAD_FROM_MASTER;

reg ACK=1; 
reg OUTINT;
 PIC master(  
  .interrupt_request_pins(interrupt_request_pins), 
   //Data Buffer
   .INPUT_Data(INPUTDATA),
   .OUTPUT_Data(OUTPUT_DATA),
   //READ Write
   .RD(),
   .WR(),
   .A0(),
   .CS(),
   //Cascade 
   //.IN_CAS0_2(),
   .SP_EN(1),
   .OUT_CAS0_2(OUTCASCAD_FROM_MASTER),
   //Contol logic
   .INT(),
   .INTAC()
  );
   PIC slave1(  
  .interrupt_request_pins(), 
   //Data Buffer
   .INPUT_Data(),
   .OUTPUT_Data(),
   //READ Write
   .RD(1),
   .WR(),
   .A0(),
   .CS(0),
   //Cascade 
   .IN_CAS0_2(),
   .SP_EN(0),
   .OUT_CAS0_2(),
   //Contol logic
   .INT(),
   .INTAC()
  );
  
  PIC slave2(  
  .interrupt_request_pins(), 
   //Data Buffer
   .INPUT_Data(),
   .OUTPUT_Data(),
   //READ Write
   .RD(),
   .WR(),
   .A0(),
   .CS(0),
   //Cascade 
   .IN_CAS0_2(),
   .SP_EN(),
   .OUT_CAS0_2(),
   //Contol logic
   .INT(),
   .INTAC()
  );
  PIC slave3(  
  .interrupt_request_pins(), 
   //Data Buffer
   .INPUT_Data(),
   .OUTPUT_Data(),
   //READ Write
   .RD(),
   .WR(),
   .A0(),
   .CS(0),
   //Cascade 
   .IN_CAS0_2(),
   .SP_EN(),
   .OUT_CAS0_2(),
   //Contol logic
   .INT(),
   .INTAC()
  );
  PIC slave4(  
  .interrupt_request_pins(), 
   //Data Buffer
   .INPUT_Data(),
   .OUTPUT_Data(),
   //READ Write
   .RD(),
   .WR(),
   .A0(),
   .CS(0),
   //Cascade 
   .IN_CAS0_2(),
   .SP_EN(),
   .OUT_CAS0_2(),
   //Contol logic
   .INT(),
   .INTAC()
  );
  PIC slave5(  
  .interrupt_request_pins(), 
   //Data Buffer
   .INPUT_Data(),
   .OUTPUT_Data(),
   //READ Write
   .RD(),
   .WR(),
   .A0(),
   .CS(0),
   //Cascade 
   .IN_CAS0_2(),
   .SP_EN(),
   .OUT_CAS0_2(),
   //Contol logic
   .INT(),
   .INTAC()
  );
  PIC slave6(  
  .interrupt_request_pins(), 
   //Data Buffer
   .INPUT_Data(),
   .OUTPUT_Data(),
   //READ Write
   .RD(),
   .WR(),
   .A0(),
   .CS(0),
   //Cascade 
   .IN_CAS0_2(),
   .SP_EN(),
   .OUT_CAS0_2(),
   //Contol logic
   .INT(),
   .INTAC()
  );
  
  PIC slave7(  
  .interrupt_request_pins(), 
   //Data Buffer
   .INPUT_Data(),
   .OUTPUT_Data(),
   //READ Write
   .RD(),
   .WR(),
   .A0(),
   .CS(0),
   //Cascade 
   .IN_CAS0_2(),
   .SP_EN(),
   .OUT_CAS0_2(),
   //Contol logic
   .INT(),
   .INTAC()
  );
  PIC slave8(  
  .interrupt_request_pins(), 
   //Data Buffer
   .INPUT_Data(),
   .OUTPUT_Data(),
   //READ Write
   .RD(),
   .WR(),
   .A0(),
   .CS(0),
   //Cascade 
   .IN_CAS0_2(),
   .SP_EN(),
   .OUT_CAS0_2(),
   //Contol logic
   .INT(),
   .INTAC()
  );
end module
