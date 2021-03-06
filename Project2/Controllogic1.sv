module Control_Mac(clk, reset, s_valid, m_ready, data_in, wr_en_X, wr_en_M, m_valid, s_ready, clr_acc, addr_X, addr_M, data_out,countx,countm);
input clk, reset, s_valid, m_ready;
input [7:0] data_in;
output logic wr_en_X, wr_en_M, m_valid, s_ready, clr_acc;
output logic [3:0]addr_X;
output logic [1:0]addr_M;
output logic [15:0] data_out;
output logic countx,countm;


always_ff @(posedge clk)
begin
if (reset == 1)
    begin
	addr_X  <= 0;
	addr_M  <= 0;
	wr_en_X <= 0;
	wr_en_M <= 0;
	clr_acc <= 0;
	countx  <= 0;
	countm  <= 0;
	s_ready <= 1;
    end
else
if (s_valid == 1 && s_ready == 1)
   begin
//write to memory X,M
	if (countx == 8)
	begin
	    wr_en_X <= 0;
		if (countm == 2)
		    wr_en_M <= 0;    
		else
		begin
		wr_en_M <= 1;
		countm  <= countm + 1;
		addr_M <= addr_M + 1;
		end
	end
	else
	begin
	   wr_en_X <= 1;
  	   countx <= countx + 1;
	   addr_X <= addr_X + 1;
	end	   
   end
else
//read from memory X,M
   begin
	wr_en_X <= 0;
	wr_en_M <= 0;
	addr_X <= addr_X + 1;
	addr_M <= addr_M + 1;
   end
end

//	 Datapath_Mac(clk, reset, data_in, data_out, addr_X, wr_en_X, addr_M, wr_en_M, clr_acc, m_ready);
Datapath_Mac DP_part1(clk, reset, data_in, data_out, addr_X, wr_en_X, addr_M, wr_en_M, clr_acc, m_ready);

endmodule
