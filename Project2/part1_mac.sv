module part1_mac(clk, reset,valid_in, a, b, f,valid_out);
   input                      clk, reset, valid_in;
   input signed [7:0]         a, b;
   output logic signed [15:0] f;
   output logic               valid_out;

   // Internal connections
   logic                      en_ab, en_f;
   logic signed [7:0]         ffAOut, ffBOut;
   logic signed [15:0]        adderOut;

   // Registers
   always_ff @(posedge clk) begin
      if (reset == 1) begin
         ffAOut <= 0;
         ffBOut <= 0;
         f      <= 0;
      end
      else begin
         if (en_ab) begin
            ffAOut <= a;
            ffBOut <= b;
         end
         if (en_f) begin
            f <= adderOut;
         end
      end
   end

   // Combinational multiplication and addition
   always_comb begin
      adderOut = f + (ffAOut * ffBOut);
   end

   // Combinational control logic: en_ab
   assign en_ab = valid_in;

   // Sequential control
   // - en_f is en_ab delayed one cycle
   // - valid_out is en_f delayed one cycle
   always_ff @(posedge clk) begin
      if (reset == 1) begin
         en_f        <= 0;
         valid_out   <= 0;
      end
      else begin
         en_f        <= en_ab;
         valid_out   <= en_f;
      end
   end
   
endmodule 