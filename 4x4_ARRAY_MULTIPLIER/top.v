module top(
input x0,x1,x2,x3,y0,y1,y2,y3,
output reg p0,p1,p2,p3,p4,p5,p6,p7
);
  wire x1y0,x0y1,x2y0,x1y1,x3y0,x2y1,x3y1,c10,c11,c12,c13,s10,s11,s12,s13,x0y2,x1y2,x2y2,x3y2,c20,c21,c22,s20,s21,s22,s23,c23,x0y3,x1y3,x2y3,x3y3,s30,s31,s32,s33,c30,c31,c32,c33,out;
  
  
  
  and_gate gate_x0y0( .a(x0), .b(y0), .y(out));
  and_gate gate_x1y0( .a(x1), .b(y0), .y(x1y0));
  and_gate gate_x0y1( .a(x0), .b(y1), .y(x0y1));
  and_gate gate_x2y0( .a(x2), .b(y0), .y(x2y0));
  and_gate gate1_x1y1( .a(x1), .b(y1), .y(x1y1));
  and_gate gate1_x1y0( .a(x3), .b(y0), .y(x3y0));
  and_gate gate1_x2y1( .a(x2), .b(y1), .y(x2y1));
  and_gate gate1_x3y1( .a(x3), .b(y1), .y(x3y1));
  half_adder adder_half_s10( .a(x1y0), .b(x0y1), .sum(s10), .cout(c10));
  full_adder adder_full_s11( .a(x2y0), .b(x1y1), .cin(c10), .sum(s11), .cout(c11));
  full_adder adder_full_s12( .a(x3y0), .b(x2y1), .cin(c11), .sum(s12), .cout(c12));
  half_adder adder_half_s13( .a(x3y1), .b(c12), .sum(s13), .cout(c13));
  and_gate gate1_x0y2( .a(x0), .b(y2), .y(x0y2));
  and_gate gate1_x1y2( .a(x1), .b(y2), .y(x1y2));
  and_gate gate1_x2y2( .a(x2), .b(y2), .y(x2y2));
  and_gate gate1_x3y2( .a(x3), .b(y2), .y(x3y2));
  half_adder adder_half_s20( .a(s11), .b(x0y2), .sum(s20), .cout(c20));
  full_adder adder_full_s21( .a(s12), .b(x1y2), .cin(c20), .sum(s21), .cout(c21));
  full_adder adder_full_s22( .a(s13), .b(x2y2), .cin(c21), .sum(s22), .cout(c22));
  full_adder adder_full_s23( .a(c13), .b(x3y2), .cin(c22), .sum(s23), .cout(c23));
  and_gate gate1_x0y3( .a(x0), .b(y3), .y(x0y3));
  and_gate gate1_x1y3( .a(x1), .b(y3), .y(x1y3));
  and_gate gate1_x2y3( .a(x2), .b(y3), .y(x2y3));
  and_gate gate1_x3y3( .a(x3), .b(y3), .y(x3y3));
  half_adder adder_half_s30( .a(s21), .b(x0y3), .sum(s30), .cout(c30));
  full_adder adder_full_s31( .a(s22), .b(x1y3), .cin(c30), .sum(s31), .cout(c31));
  full_adder adder_full_s32( .a(s23), .b(x2y3), .cin(c31), .sum(s32), .cout(c32));
  full_adder adder_full_s33( .a(c23), .b(x3y3), .cin(c32), .sum(s33), .cout(c33));
  
  always@(*)
    begin
      assign p0 = out;
      assign p1 = s10;
      assign p2 = s20;
      assign p3 = s30;
      assign p4 = s31;
      assign p5 = s32;
      assign p6 = s33;
      assign p7 = c33;
    end
endmodule
  
  
  
  
module and_gate (
    input wire a,    
    input wire b,    
    output wire y    
);

    assign y = a & b; 

endmodule

module half_adder (
    input wire a,      
    input wire b,      
    output wire sum,   
    output wire cout   
);

    assign sum  = a ^ b;   
    assign cout = a & b;   

endmodule

module full_adder (
    input wire a,      
    input wire b,      
    input wire cin,    
    output wire sum,   
    output wire cout   
);

    assign sum  = a ^ b ^ cin;     
    assign cout = (a & b) | (b & cin) | (a & cin);  

endmodule
