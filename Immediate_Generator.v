module Immediate_Generator(            
		input [31:0]instr,
        input [2:0]ImmType,
        output reg [31:0] imm);




parameter [2:0] IMM_R   =3'b000,
                IMM_I   =3'b001,
                IMM_S   =3'b010,
                IMM_B   =3'b011,
                IMM_U   =3'b100,
                IMM_J   =3'b101;


always @(*) begin
    case(ImmType)
        IMM_R:begin
            imm = 32'b0;
        end
        IMM_I:begin
            imm = {{20{instr[31]}},instr[31:20]};
        end
        IMM_S:begin
            imm = {{20{instr[31]}},instr[31:25],instr[11:7]};
        end
        IMM_B:begin
            imm = {{19{instr[31]}},instr[31],instr[7],instr[30:25],instr[11:8],1'b0};
        end
        IMM_U:begin
            imm = {instr[31:12],12'b0};
        end
        IMM_J:begin
            imm = {{11{instr[31]}},instr[31],instr[19:12],instr[20],instr[30:21],1'b0};
        end
    endcase
end

endmodule