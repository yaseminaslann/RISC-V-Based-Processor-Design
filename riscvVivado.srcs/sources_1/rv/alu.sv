`include "config.sv"
`include "constants.sv"
module alu (
    input  [4:0]  alu_function,
    input  signed [31:0] operand_a,
    input  signed [31:0] operand_b,
    output logic [31:0] result,
    output  result_equal_zero
);
parameter ADD=5'b00001; parameter SUB=5'b00010;parameter SLL=5'b00011;parameter SRL=5'b00100;
parameter SRA=5'b00101;parameter SEQ=5'b00110;parameter SLT=5'b00111;parameter SLTU=5'b01000;
parameter alu_XOR=5'b01001;parameter alu_OR=5'b01010;parameter alu_AND=5'b01011;
logic REZ;
assign result_equal_zero=REZ;
always_latch begin
  case(alu_function)
      ADD:begin
        result=operand_a+operand_b;
        if(result==0)begin
          REZ=1;
        end else begin
         REZ=0;
        end
       end
       SUB:begin
         result=operand_a-operand_b;
          if(result==0)begin
          REZ=1;
        end else begin
         REZ=0;
        end
       end
       SLL:begin
        result=operand_a<<operand_b;
         if(result==0)begin
          REZ=1;
        end else begin
         REZ=0;
        end
       end
       SRA:begin
       result=operand_a>>>operand_b;
         if(result==0)begin
          REZ=1;
        end else begin
         REZ=0;
        end
       end
       SEQ:begin
       if(operand_a==operand_b)begin
          result=1;
          REZ=0;
        end else begin
         result=0;
         REZ=1;
        end
       end
       SLT:begin
       if(operand_a<operand_b)begin
          result=1;
          REZ=0;
        end else begin
         result=0;
         REZ=1;
        end
       end
       SLTU:begin
        if($unsigned(operand_a)<$unsigned(operand_b))begin
          result=1;
          REZ=0;
        end else begin
         result=0;
         REZ=1;
        end
       end
       alu_XOR:begin
         result=operand_a^operand_b;
        if(result==0)begin
          REZ=1;
        end else begin
         REZ=0;
        end
       end
        alu_OR:begin
         result=operand_a|operand_b;
        if(result==0)begin
          REZ=1;
        end else begin
         REZ=0;
        end
       end
       alu_AND:begin
       result=operand_a&operand_b;
       if(result==0)begin
          REZ=1;
        end else begin
         REZ=0;
        end
       end
    endcase

end
endmodule
