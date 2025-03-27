`timescale 1ns / 1ps

module top_tb;
    reg [3:0] x, y;  
    wire [7:0] p;    
    
    
    top uut (
        .x0(x[0]), .x1(x[1]), .x2(x[2]), .x3(x[3]),
        .y0(y[0]), .y1(y[1]), .y2(y[2]), .y3(y[3]),
        .p0(p[0]), .p1(p[1]), .p2(p[2]), .p3(p[3]),
        .p4(p[4]), .p5(p[5]), .p6(p[6]), .p7(p[7])
    );
    
    initial begin
        
        $monitor("Time=%0t | x=%b, y=%b => p=%b", $time, x, y, p);
        
        
        x = 4'b0000; y = 4'b0000; #10;
        x = 4'b0001; y = 4'b0001; #10;
        x = 4'b0011; y = 4'b0010; #10;
        x = 4'b0101; y = 4'b0011; #10;
        x = 4'b0110; y = 4'b0100; #10;
        x = 4'b1010; y = 4'b0101; #10;
        x = 4'b1111; y = 4'b1111; #10;
        
        
        $finish;
    end
      initial begin
        $dumpfile("dump.vcd");
            $dumpvars();
       end
endmodule
