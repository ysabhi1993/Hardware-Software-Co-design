module count_M_X (clk, reset, data_in, data_out, s_valid, Addr_M, Wr_en_M, Addr_X, Wr_en_X, out_M, out_X, clr_acc, m_ready,mem_M,mem_X);
//Datapath_Mac(clk, reset, data_in, data_out, s_valid, addr_M, wr_en_M, addr_X, wr_en_X, clr_acc, m_ready);
input clk, reset, s_valid, m_ready, clr_acc;
input [7:0] data_in;
output logic [3:0] Addr_M,out_M;
output logic [1:0] Addr_X,out_X;
output logic Wr_en_M, Wr_en_X;
output logic [15:0]data_out;
output logic [0:8][7:0] mem_M;
 output logic [0:2][7:0] mem_X;


always_ff @(posedge clk)
begin
if (reset)
begin
	out_M   <= 0;
	Addr_M  <= 0;
	out_X   <= 0;
	out_M   <= 0;
	Wr_en_X <= 0;
	Wr_en_M <= 0;
end
else
if (Wr_en_X == 0 && s_valid == 1)
begin	
	if (out_M == 9)
	begin
	Wr_en_M <= 0;
	Wr_en_X <= 1;
	Addr_M <= 0;
	end
	else
	begin
	out_M <= out_M + 1;
	Addr_M <= out_M;
	Wr_en_M <= 1;
	end
end
end

always_ff @(posedge clk)
begin
if (Wr_en_X == 1 && s_valid == 1)
begin
	if (out_X == 3)
	begin
	Wr_en_X <= 0;
	Addr_X <= 0;
	end
	else
	begin
	out_X <= out_X + 1;
	Addr_X <= out_X;
	Wr_en_X <= 1;
	end
end
//else 
//if (Wr_en_X == 0 && Wr_en_M == 0)
//begin
//Addr_X <= Addr_X + 1;
//Addr_M <= Addr_M + 1;
//end
end

Datapath_Mac data_M(.clk(clk), .reset(reset), .data_in(data_in), .data_out(data_out), .s_valid(s_valid), .addr_M(Addr_M), .wr_en_M(Wr_en_M), .addr_X(Addr_X), 
.wr_en_X(Wr_en_X), .clr_acc(clr_acc), .m_ready(m_ready),.mem_M(mem_M),.mem_X(mem_X));
                    //clk, reset, data_in, data_out, cnt_en, Addr_M, Wr_en_M, Addr_X, Wr_en_X, out_M, out_X, clr_acc, m_ready);

endmodule

module Tbench ();
logic clk, reset, cnt_en;
logic [3:0]out_M, Addr_M;
logic [1:0]out_X, Addr_X;
logic Wr_en_M, Wr_en_X;

initial clk = 0;
always #5 clk = ~clk;



count_M_X dut(Wr_en_M, Addr_M, Wr_en_X, Addr_X, clk, reset, cnt_en, out_M, out_X);

initial 
begin
#1 reset = 1;
#5 reset = 0;
#5
cnt_en = 1;

#20
cnt_en = 0;

#10
cnt_en = 1;

#40
cnt_en= 0;
#10
cnt_en = 1;

end
endmodule











	  
	
