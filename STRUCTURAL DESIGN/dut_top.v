module dut_top(
  input clk,rst_n,x,
  output reg z
);
  wire x_bar,q_1,q_2,q_3,q_1_bar,q_2_bar,q_3_bar,a_1,a_2,a_3,d_3,a_5,a_6,out;
  
        not_gate I1(.a(x),.out(x_bar));
        nand_gate_three_in G2( .a (x_bar),.b (q_1),.c (q_3_bar),.out(a_2));
  nand_gate_three_in G1( .a (q_1),.b (q_2),.c (q_3),.out(a_1));
        nand_gate_three_in G3( .a (x),.b (q_1_bar),.c (q_2_bar),.out(a_3));
        nand_gate_three_in G4( .a (a_1),.b (a_2),.c (a_3),.out(d_3));
        d_flip_flop FF3(.clk(clk),.rst_n (rst_n),.d (d_3),.q (q_3),.q_bar(q_3_bar));
        d_flip_flop FF2(.clk(clk),.rst_n (rst_n),.d (q_1),.q (q_2),.q_bar(q_2_bar));
        d_flip_flop FF1(.clk(clk),.rst_n (rst_n),.d (q_2_bar),.q (q_1),.q_bar(q_1_bar));
        nand_gate G5(.a(x),.b(q_3),.out(a_5));
        nand_gate G6(.a(x_bar),.b(q_3_bar),.out(a_6));
        nand_gate G7(.a(a_5),.b(a_6),.out(out));
  
  always@(*)begin
    if(!rst_n) z=0;
      else
       z=out;
  end
endmodule

module not_gate(
  input a,
  output reg out
);
  always@(*)
    begin
      out= !a;
    end
endmodule

module nand_gate(
  input a,b,
  output reg out
);
  
  always@(*)
  begin
    out= !(a & b);
  end
  endmodule

module nand_gate_three_in(
  input a,b,c,
  output reg out
);
  
  always@(*)
  begin
    out= !(a & b & c);
  end
  endmodule

module d_flip_flop (
  input clk,         
  input rst_n,       
  input d,           
  output reg q,q_bar      
);

  always @(posedge clk or negedge rst_n) begin
    if (!rst_n)
      begin
     q <= 0;
     q_bar <=1;
     end
    else
      begin
      q <= d;        
      q_bar <= ~d;
      end
  end
endmodule
