module mvm3_part1(clk, reset, s_valid, m_ready, data_in, m_valid, s_ready, data_out);
 input clk, reset, s_valid, m_ready;
 input signed [7:0] data_in;
 output logic signed [15:0] data_out;
 output logic m_valid, s_ready;
 logic wr_en_X, wr_en_M, clr_acc;
 logic [3:0]addr_X;
 logic [1:0]addr_M;

Control_Mac  Ctrl_part1(clk, reset, s_valid, m_ready, data_in, wr_en_X, wr_en_M, m_valid, s_ready, clr_acc, addr_X, addr_M, data_out,countx,countm);


endmodule
