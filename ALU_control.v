module ALU_control(
        input  [2:0]ALUop,
        input  [2:0]Func3,
        input  [6:0]Func7,
        input  [6:0]opcode,
        output reg [4:0]ALU_Ctrl
        );

//parameter for ALUOP
parameter [1:0] ALUOP_ADD = 2'b00,
                ALUOP_SUB = 2'b01,
                ALUOP_FUNC= 2'b10,
                ALUOP_LUI = 2'b11;
//parameter for ALU_Ctrl
parameter [4:0] ALU_ADD   =5'b00000,
                ALU_SUB   =5'b00001,
                ALU_SLL   =5'b00010,
                ALU_SLT   =5'b00011,
                ALU_SLTU  =5'b00100,
                ALU_XOR   =5'b00101,
                ALU_SRL   =5'b00110,
                ALU_SRA   =5'b00111,
                ALU_OR    =5'b01000,
                ALU_AND   =5'b01001,
                ALU_BEQ   =5'b01010,
                ALU_BNE   =5'b01011,
                ALU_BLT   =5'b01100,
                ALU_BGE   =5'b01101,
                ALU_BLTU  =5'b01110,
                ALU_BGEU  =5'b01111,
                ALU_LUI   =5'b10000;

always@(*)begin
    case(ALUop)
        ALUOP_ADD:ALU_Ctrl = ALU_ADD;
        ALUOP_SUB:begin
            case(Func3)
                3'b000:ALU_Ctrl = ALU_BEQ;
                3'b001:ALU_Ctrl = ALU_BNE;
                3'b100:ALU_Ctrl = ALU_BLT;
                3'b101:ALU_Ctrl = ALU_BGE;
                3'b110:ALU_Ctrl = ALU_BLTU;
                3'b111:ALU_Ctrl = ALU_BGEU;
                default: ALU_Ctrl = ALU_BEQ;
            endcase
        end
        ALUOP_FUNC:begin
            case(Func3)
                3'b000:begin
                    if(opcode==7'b0110011)begin
                        if(Func7==7'b0000000)begin
                            ALU_Ctrl = ALU_ADD;
                        end
                        else begin
                            ALU_Ctrl = ALU_SUB;
                        end
                    end
                    else begin
                        ALU_Ctrl = ALU_ADD;
                    end
                end
                3'b001:ALU_Ctrl = ALU_SLL;
                3'b010:ALU_Ctrl = ALU_SLT;
                3'b011:ALU_Ctrl = ALU_SLTU;
                3'b100:ALU_Ctrl = ALU_XOR;
                3'b101:begin
                    if(Func7==7'b0000000)begin
                        ALU_Ctrl = ALU_SRL;
                    end
                    else begin
                        ALU_Ctrl = ALU_SRA;
                    end
                end 
                3'b110:ALU_Ctrl = ALU_OR;
                3'b111:ALU_Ctrl = ALU_AND;
            endcase
        end
        ALUOP_LUI:ALU_Ctrl = ALU_LUI;
    endcase
end

endmodule



