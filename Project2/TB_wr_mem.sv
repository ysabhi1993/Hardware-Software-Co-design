module TB_wr_mem();
 logic clk, reset, wr_en_X, wr_en_M,clr_acc,m_ready,s_valid;
 logic [7:0] data_in;
 logic [15:0]data_out;
 logic [7:0] data_out_X,data_out_M;
 logic [3:0] Addr_M;
 logic [1:0] Addr_X;
 logic [3:0] out_M;
 logic [1:0] out_X; 
 logic [0:8][7:0] mem_M;
 logic [0:2][7:0] mem_X;
 
initial clk = 0;
   always #5 clk = ~clk;

count_M_X dut(clk, reset, data_in, data_out, s_valid, Addr_M, Wr_en_M, Addr_X, Wr_en_X, out_M, out_X, clr_acc, m_ready,mem_M,mem_X);

int a;

initial 
begin
#1 reset = 1;
#10
reset = 0;
#10 
clr_acc = 1;
m_ready = 1;
#10
clr_acc = 0;
s_valid = 1;

for (a=0;a<7;a++)
begin
@(posedge clk);
#1
data_in = a*2;
end
s_valid = 0;
#10
s_valid = 1;
for (a=0;a<5;a++)
begin
@(posedge clk);
#1
data_in = a*2;
end
s_valid = 0;
end
endmodule



