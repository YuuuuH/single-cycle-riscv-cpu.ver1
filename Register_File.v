
module Register_File (
        input         reset,
        input         clk,
        input         RegWrite,    
        input  [4:0]  rs1_addr,
        input  [4:0]  rs2_addr,
        input  [4:0]  rd_addr,
        input  [31:0] rd_data,
        output [31:0] rs1_data,
        output [31:0] rs2_data
        );

reg [31:0]  Register_File_data[0:31];
integer  i;

always@(posedge clk)begin
    if(reset)begin
        for(i=0;i<32;i=i+1)begin
            Register_File_data[i] <= 32'b0;
        end
    end
    else begin
        if(RegWrite&&rd_addr!=5'b0)begin
            Register_File_data[rd_addr] <= rd_data;
        end
    end
end

assign rs1_data = (rs1_addr==5'b00000) ? 32'b0 : Register_File_data[rs1_addr];
assign rs2_data = (rs2_addr==5'b00000) ? 32'b0 : Register_File_data[rs2_addr];

endmodule
