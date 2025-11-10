module glitch_free_mux(

input clk_1,
  input clk_2,
  input rst_n,
   input sel,
  output clk_out
);
  wire sel_cnt1;
  wire sel_cnt2;
  reg clk1_p;
  reg clk1_n;
  reg clk2_p;
  reg clk2_n;
  
  assign sel_cnt1 = sel & !clk2_n;
  assign sel_cnt2 = !sel & !clk1_n;
  
  always@(posedge clk_1 or negedge rst_n) //expecting rst from rst_sync with no glitches
    begin
      if(!rst_n)
        clk1_p <=0;
      else 
        clk1_p <= sel_cnt1;
    end
  
  always@(negedge clk_1 or negedge rst_n)
    begin
      if(!rst_n)
        clk1_n <= 0;
      else 
        clk1_n <= clk1_p;
    end
  
  
  always@(posedge clk_2 or negedge rst_n) //expecting rst from rst_sync with no glitches
    begin
      if(!rst_n)
        clk2_p <=0;
      else 
        clk2_p <= sel_cnt2;
    end
  
  always@(negedge clk_2 or negedge rst_n)
    begin
      if(!rst_n)
        clk2_n <= 0;
      else 
        clk2_n <= clk2_p;
    end     
  
  assign clk_out = (clk1_n & clk_1) || (clk2_n & clk_2);
 endmodule
    
