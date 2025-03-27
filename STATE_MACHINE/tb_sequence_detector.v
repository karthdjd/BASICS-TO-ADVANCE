module tb_sequence_detector();

  reg clk;
  reg rst_n;
  reg seq;
  wire out;

  
  sequence_detector uut (
    .clk(clk),
    .rst_n(rst_n),
    .x(seq),
    .z(out)
  );

  
  always #5 clk = ~clk;

  
  initial begin
    
    clk = 0;
    rst_n = 0;
    seq = 0;
    
    
    #10 rst_n = 1; 
   // repeat(5)begin
    @(posedge clk);

    
    #10 seq = 0;
    #10 seq = 0;
    
    #10 seq = 1;
    #10 seq = 0;
   //0101 seq 
    #10 seq = 0;
    #10 seq = 1;
    #10 seq = 0;
    #10 seq = 1;
   //0101 seq 
    #10 seq = 0;
    #10 seq = 1;
    #10 seq = 0;
    #10 seq = 1;
    
    #10 seq = 1;
    #10 seq = 1;
    #10 seq = 0;
    #10 seq = 0;
    #10 seq = 0;
    #10 seq = 0;
    #10 seq = 0;
    //0110 seq 
    #10 seq = 0;
    #10 seq = 1;
    #10 seq = 1;
    #10 seq = 0;
    //0101 seq 
    #10 seq = 0;
    #10 seq = 1;
    #10 seq = 0;
    #10 seq = 1;
    
    #10 seq = 0;
      
      
    
   // end
    
    
    #200;
    $finish;
  end

  
  initial begin
    $monitor("Time=%0t | clk=%b | rst_n=%b | seq=%b | out=%b", $time, clk, rst_n, seq, out);
    $dumpfile("dump.vcd");
    $dumpvars();
  end

endmodule
