module Datapath_Mac(clk, reset, data_in, data_out, s_valid, addr_M, wr_en_M, addr_X, wr_en_X, clr_acc, m_ready,mem_M,mem_X);
parameter WIDTH=8, SIZE_M=9, LOGSIZE_M=4,SIZE_X=3, LOGSIZE_X=2;
 input clk, reset,clr_acc,m_ready;
 input [WIDTH-1:0] data_in;
 input [LOGSIZE_M-1:0] addr_M;
 input [LOGSIZE_X-1:0] addr_X;
 input wr_en_M,wr_en_X;
 input s_valid;
 
 output logic [15:0]data_out;
 
 logic [WIDTH-1:0] data_out_M,data_out_X;
 output logic [0:SIZE_M-1][WIDTH-1:0] mem_M;
 output logic [0:SIZE_X-1][WIDTH-1:0] mem_X;
 logic [15:0]add_out;
   
 //data_out is computed after 1 cycles, after reading the data from memory
always_ff @(posedge clk)
begin
if (reset)
begin
data_out   <= 0;
data_out_M <= 0;
data_out_X <= 0;
end
else if (clr_acc == 1)
data_out <= 0;
else if (wr_en_X == 0 && wr_en_M == 0)
data_out <= add_out;
else 
data_out <= 0;
end

//write/read data from memory
always_ff @(posedge clk) 
begin
if (wr_en_M)
 mem_M[addr_M] <= data_in;
 else if (wr_en_X)
 mem_X[addr_X] <= data_in;
 else if (wr_en_M == 0 && wr_en_X == 0)
begin
data_out_X <= mem_X[addr_X];
data_out_M <= mem_M[addr_M];
end
end

//execute MAC
always_comb
begin
if (m_ready == 0)
add_out = add_out;
else
add_out = data_out + (data_out_M*data_out_X);
end

endmodule
