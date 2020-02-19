wvResizeWindow -win $_nWave1 1920 23 1920 1137
wvRestoreSignal -win $_nWave1 \
           "/home/yuhong/computer_organization/computer_organization/computer_organization_hw/hw4/src/signal.rc" \
           -overWriteAutoAlias on
wvGetSignalOpen -win $_nWave1
wvGetSignalClose -win $_nWave1
wvSetCursor -win $_nWave1 4664206.513679 -snap {("G2" 0)}
wvSelectSignal -win $_nWave1 {( "G1" 3 )} 
wvCut -win $_nWave1
wvSetPosition -win $_nWave1 {("G2" 0)}
wvSetPosition -win $_nWave1 {("G1" 3)}
wvSelectSignal -win $_nWave1 {( "G1" 3 )} 
wvSetCursor -win $_nWave1 4665907.814971 -snap {("G2" 0)}
wvSetCursor -win $_nWave1 4712713.383075 -snap {("G2" 0)}
wvSetCursor -win $_nWave1 4720141.739298 -snap {("G2" 0)}
wvSetCursor -win $_nWave1 4721674.888718 -snap {("G2" 0)}
wvSelectGroup -win $_nWave1 {G2}
wvSetPosition -win $_nWave1 {("G2" 0)}
wvSelectGroup -win $_nWave1 {G1}
wvGetSignalOpen -win $_nWave1
wvGetSignalSetScope -win $_nWave1 "/top_tb"
wvGetSignalSetScope -win $_nWave1 "/top_tb/TOP"
wvGetSignalSetScope -win $_nWave1 "/top_tb/TOP/i_CPU"
wvGetSignalSetScope -win $_nWave1 "/top_tb/TOP/i_CPU"
wvGetSignalSetScope -win $_nWave1 "/top_tb/TOP/i_DM"
wvGetSignalSetScope -win $_nWave1 "/top_tb/TOP/i_CPU/register_file"
wvSetPosition -win $_nWave1 {("G2" 1)}
wvSetPosition -win $_nWave1 {("G2" 1)}
wvAddSignal -win $_nWave1 -clear
wvAddSignal -win $_nWave1 -group {"G1" \
{/top_tb/TOP/instr_addr\[31:0\]} \
{/top_tb/TOP/instr_out\[31:0\]} \
{/top_tb/TOP/i_CPU/data_in\[31:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G2" \
{/top_tb/TOP/i_CPU/register_file/Register_File_data\[0:31\]} \
}
wvAddSignal -win $_nWave1 -group {"G3" \
}
wvSelectSignal -win $_nWave1 {( "G2" 1 )} 
wvSetPosition -win $_nWave1 {("G2" 1)}
wvSetPosition -win $_nWave1 {("G2" 1)}
wvSetPosition -win $_nWave1 {("G2" 1)}
wvAddSignal -win $_nWave1 -clear
wvAddSignal -win $_nWave1 -group {"G1" \
{/top_tb/TOP/instr_addr\[31:0\]} \
{/top_tb/TOP/instr_out\[31:0\]} \
{/top_tb/TOP/i_CPU/data_in\[31:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G2" \
{/top_tb/TOP/i_CPU/register_file/Register_File_data\[0:31\]} \
}
wvAddSignal -win $_nWave1 -group {"G3" \
}
wvSelectSignal -win $_nWave1 {( "G2" 1 )} 
wvSetPosition -win $_nWave1 {("G2" 1)}
wvGetSignalClose -win $_nWave1
wvSelectSignal -win $_nWave1 {( "G2" 1 )} 
wvExpandBus -win $_nWave1 {("G2" 1)}
wvSelectSignal -win $_nWave1 {( "G2" 9 )} 
wvSelectSignal -win $_nWave1 {( "G2" 11 )} 
wvSelectSignal -win $_nWave1 {( "G2" 10 )} 
wvSetCursor -win $_nWave1 4547439.130713 -snap {("G2" 10)}
wvSetCursor -win $_nWave1 4553779.445412 -snap {("G3" 0)}
wvSetCursor -win $_nWave1 4554036.618863 -snap {("G3" 0)}
wvSetCursor -win $_nWave1 4772495.574303 -snap {("G2" 10)}
