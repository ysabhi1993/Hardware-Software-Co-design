module Control_Mac1(clk, reset, s_valid, m_ready, data_in, wr_en_X, wr_en_M, m_valid, s_ready, clr_acc, addr_X, addr_M, data_out);
input clk, reset, s_valid, m_ready;
input [7:0] data_in;
output logic wr_en_X, wr_en_M, m_valid, s_ready, clr_acc;
output logic [3:0]addr_X;
output logic [1:0]addr_M;
output logic [15:0] data_out;

always_ff @(posedge clk)
begin
if (reset == 1)
    begin
	addr_X  <= 0;
	addr_M  <= 0;
	wr_en_X <= 0;
	wr_en_M <= 0;
    end
else
if (s_valid == 1 && s_ready == 1)
   begin
	addr_X  <= 0;
	addr_M  <= 0;
	wr_en_X <= 1;
	wr_en_M <= 0;
   end
   else 
   begin 
	wr_en_X <= 0;
	wr_en_M <= 0;
   end
end

always_ff @(posedge clk)
begin
//write the matrix into 'X' memory
if (wr_en_X == 1)
   begin
   	if (addr_X == 8)
	begin
	   addr_X  <= 0;
	   wr_en_M <= 1;
	   wr_en_X <= 0;
	end
	else 
	addr_X <= addr_X + 1;     
   end
else 
//write the column vector values into 'M' memory
if (wr_en_M == 1)
   begin
   	if (addr_M == 2)
   	begin
    	   addr_M  <= 0;
	   wr_en_M <= 0;
        end
        else 
   	addr_M <= addr_M + 1;
   end
else 
//read the values from the memories 'X' and 'M'
if (wr_en_M == 0 && wr_en_X == 0)
   begin
	   if (addr_X == 8)
	   begin
	      addr_X  <= 0;
		if (m_ready == 1)
		    s_ready <= 1;
		else
		    s_ready <= 0;	
	   end
	   else 
	   if (addr_M == 2)
	   begin
	      addr_M  <= 0;
	      m_valid <= 1;
	   end
	   else
	   begin
		if (m_ready == 1)
		begin
		   addr_X <= addr_X + 1;   
		   addr_M <= addr_M + 1;
		end
		else
		begin
		   addr_X <= addr_X;
		   addr_M <= addr_M;
		end
	    end
   end
end


Datapath_Mac DP_part1(clk, reset, data_in, data_out, addr_X, wr_en_X, addr_M, wr_en_M, clr_acc, m_ready);


	   

endmodule
