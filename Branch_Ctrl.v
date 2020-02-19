
module Branch_Ctrl(
    input           ZeroFlag,
    input     [1:0] IsBJ,
    output reg[1:0] BranchCtrl
        );

//parameter for BranchCtrl
parameter [1:0] ALU_OUT  = 2'b00,
                PC_IMM   = 2'b01,
                PC_4     = 2'b10;
                
//parameter for IsBJ
parameter [1:0] ISB      = 2'b00,
                ISJ      = 2'b01,
                ISJR     = 2'b10,
                NOBJ     = 2'b11;
always@(*)begin
    case(IsBJ)
        NOBJ: BranchCtrl = PC_4;
        ISB : begin
            if(ZeroFlag)begin
                BranchCtrl = PC_IMM;
            end
            else begin
                BranchCtrl = PC_4;
            end
        end
        ISJ : BranchCtrl = PC_IMM;
        ISJR: BranchCtrl = ALU_OUT;
    endcase
end



endmodule
