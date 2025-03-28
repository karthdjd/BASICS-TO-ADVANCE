module left_shift_reg(

input a,
input shift_en,
input clk,rst_n,
 output reg [3:0]shift_out
);
  
  always@(posedge clk)begin
    if(!rst_n) shift_out <= 0;
    else 
      if(shift_en)
        shift_out <= {a,shift_out[3:1]};
  end
  
endmodule
    
      
