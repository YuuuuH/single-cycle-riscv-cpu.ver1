// Please include verilog file if you write module in other file

`include "Branch_Ctrl.v"
`include "Decoder.v"
`include "Register_File.v"
`include "ALU_control.v"
`include "ALU.v"
`include "Immediate_Generator.v"

module CPU(
    input         clk,
    input         rst,
    output        instr_read,
    output [31:0] instr_addr,
    input  [31:0] instr_out,
    output        data_read,
    output        data_write,
    output [31:0] data_addr,
    output [31:0] data_in,
    input  [31:0] data_out
);

/* Add your design */

// signal from Decoder
wire [2:0]  ImmType;
wire        RegWrite;
wire [2:0]  ALUop;
wire        PCtoRegSrc;
wire        ALUSrc;
wire        RDSrc;
wire        MemRead;
wire        MemWrite;
wire        MemtoReg;
wire [1:0]  IsBJ;

// signal from Register_File
wire [31:0] rd_data;
wire [31:0] rs1_data;
wire [31:0] rs2_data;

// signal from ALU_Controller
wire [4:0]  ALU_Ctrl;

// signal from immediate generator
wire [31:0] imm;


wire [31:0] ALU_out;

wire        ZeroFlag;

//mux for pc input
parameter   PC_PLUS_4        = 2'b10,
            BRANCH_ADDR      = 2'b01,
            ALU_OUT_ADDR     = 2'b00;



wire    [31:0] pc_to_reg;
wire    [31:0] pc_out_imm;
wire    [31:0] pc_or_alu_out;
wire    [31:0] pc_out_4;


reg  [31:0] PC;

//PC input mux
wire [1:0] BranchCtrl;
always@(posedge clk)begin
    if(rst)begin
        PC <= 32'b0;
    end
    else begin
        case(BranchCtrl)
            PC_PLUS_4:begin
                PC <= PC + 32'd4;
            end
            BRANCH_ADDR:begin
                PC <= pc_out_imm;
            end
            ALU_OUT_ADDR:begin
                PC <= ALU_out;
            end
            default:PC <= PC + 32'd4;
        endcase
    end
end

assign instr_read = 1'b1; // It means we should always read in instruction memory
assign instr_addr = PC;


//Decoder
Decoder decoder(.opcode(instr_out[6:0]) ,
                .ImmType(ImmType) ,
                .RegWrite(RegWrite),
                .ALUop(ALUop),
                .PCtoRegSrc(PCtoRegSrc) ,
                .ALUSrc(ALUSrc) ,
                .RDSrc(RDSrc) ,
                .MemRead(MemRead) ,
                .MemWrite(MemWrite) ,
                .MemtoReg(MemtoReg) ,
                .IsBJ(IsBJ) );

//Register File
Register_File register_file (.reset(rst),
                             .clk(clk),
                             .RegWrite(RegWrite),
                             .rs1_addr(instr_out[19:15]) ,
                             .rs2_addr(instr_out[24:20]) ,
                             .rd_addr(instr_out[11:7]) ,
                             .rd_data(rd_data) ,
                             .rs1_data(rs1_data) ,
                             .rs2_data(rs2_data)); 
//ALU_Controller
ALU_control alu_control(.ALUop(ALUop),
                        .Func3(instr_out[14:12]),
                        .Func7(instr_out[31:25]),
                        .opcode(instr_out[6:0]),
                        .ALU_Ctrl(ALU_Ctrl));

//Immediate Generator
Immediate_Generator immediate_generator(.instr(instr_out[31:0]),
                                        .ImmType(ImmType),
                                        .imm(imm));





//rs2_data and Imm mux
wire [31:0]ALU_rs2_imm_input;
assign ALU_rs2_imm_input = (ALUSrc==1'b1)  ? rs2_data  : imm;


//ALU

ALU alu(.rs1_data(rs1_data),
        .ALU_rs2_imm_input(ALU_rs2_imm_input),
        .ALU_Ctrl(ALU_Ctrl),
        .ZeroFlag(ZeroFlag),
        .ALU_out(ALU_out));

//pc to reg mux
assign pc_out_imm = PC + imm;
assign pc_out_4   = PC + 32'd4;

assign pc_to_reg = (PCtoRegSrc==1'b1) ? pc_out_imm  : pc_out_4;


//Branch Controller
Branch_Ctrl branch_ctrl(.ZeroFlag(ZeroFlag),
                        .IsBJ(IsBJ),
                        .BranchCtrl(BranchCtrl));




//RDsrc mux
assign pc_or_alu_out = (RDSrc==1'b1) ? pc_to_reg  : ALU_out;


wire [31:0] mem_out;
//this section is for Data_Memory
assign data_read  = MemRead;
assign data_write = MemWrite;
assign data_addr  = ALU_out;
assign data_in    = rs2_data;
assign mem_out    = data_out;


assign rd_data = (MemtoReg == 1'b1) ? pc_or_alu_out : mem_out;





endmodule

