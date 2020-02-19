

module ALU(
    input      [31:0]   rs1_data,
    input      [31:0]   ALU_rs2_imm_input,
    input      [4:0]    ALU_Ctrl,
    output reg          ZeroFlag,
    output reg [31:0]   ALU_out
        );
// parameter for ALU_Ctrl 
parameter [4:0] ALU_ADD = 5'b00000,
                ALU_SUB = 5'b00001,
                ALU_SLL = 5'b00010,
                ALU_SLT = 5'b00011,
                ALU_SLTU= 5'b00100,
                ALU_XOR = 5'b00101,
                ALU_SRL = 5'b00110,
                ALU_SRA = 5'b00111,
                ALU_OR  = 5'b01000,
                ALU_AND = 5'b01001,
                ALU_BEQ = 5'b01010,
                ALU_BNE = 5'b01011,
                ALU_BLT = 5'b01100,
                ALU_BGE = 5'b01101,
                ALU_BLTU= 5'b01110,
                ALU_BGEU= 5'b01111,
                ALU_LUI = 5'b10000;
                
                
always @(*) begin
    ZeroFlag = 1'b0;
    ALU_out = 32'b0;
    case(ALU_Ctrl)
        ALU_ADD:    ALU_out = rs1_data + ALU_rs2_imm_input ;
        ALU_SUB:    ALU_out = rs1_data - ALU_rs2_imm_input ;
        ALU_SLL:    ALU_out = rs1_data << ALU_rs2_imm_input[4:0];
        ALU_SLT:    ALU_out = ($signed(rs1_data)<$signed(ALU_rs2_imm_input)) ? 1'b1 : 1'b0;
        ALU_SLTU:   ALU_out = rs1_data< ALU_rs2_imm_input ? 1'b1 : 1'b0;
        ALU_XOR:    ALU_out = rs1_data^ALU_rs2_imm_input;
        ALU_SRL:    ALU_out = rs1_data>>ALU_rs2_imm_input[4:0];
        ALU_SRA:    ALU_out = $signed(rs1_data)>>>$signed(ALU_rs2_imm_input[4:0]);
        ALU_OR:     ALU_out = rs1_data|ALU_rs2_imm_input;
        ALU_AND:    ALU_out = rs1_data&ALU_rs2_imm_input;
        ALU_BEQ:    ZeroFlag = (rs1_data == ALU_rs2_imm_input) ? 1'b1 : 1'b0;
        ALU_BNE:    ZeroFlag = (rs1_data != ALU_rs2_imm_input) ? 1'b1 : 1'b0;
        ALU_BLT:    ZeroFlag = ($signed(rs1_data) < $signed(ALU_rs2_imm_input)) ? 1'b1 : 1'b0;
        ALU_BGE:    ZeroFlag = ($signed(rs1_data) >= $signed(ALU_rs2_imm_input)) ? 1'b1 : 1'b0;
        ALU_BLTU:   ZeroFlag = (rs1_data < ALU_rs2_imm_input) ? 1'b1  : 1'b0;
        ALU_BGEU:   ZeroFlag = (rs1_data >= ALU_rs2_imm_input) ? 1'b1  : 1'b0;
        ALU_LUI:    ALU_out = ALU_rs2_imm_input;
        default:ALU_out=32'b0;
    endcase

end

endmodule
