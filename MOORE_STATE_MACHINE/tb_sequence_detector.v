
`timescale 1ns/1ps

module tb_sequence_detector();

  reg clk;
  reg rst_n;
  reg seq;
  wire out;

  // Instantiate the module
  sequence_detector uut (
    .clk(clk),
    .rst_n(rst_n),
    .seq(seq),
    .out(out)
  );

  // Generate a clock signal (50% duty cycle, 10ns period)
  always #5 clk = ~clk;

  
  initial begin
    // Initialize signals
    clk = 0;
    rst_n = 0;
    seq = 0;
    
    // Apply reset
    #10 rst_n = 1; 
    repeat(5)begin
    @(posedge clk);

    // Apply test sequence: 0 -> 01 -> 010 -> 011 -> 0101 -> 0110
    #10 seq = 0;
    #10 seq = 1;
    #10 seq = 0;
    #10 seq = 1;
    #10 seq = 1;
    #10 seq = 0;
    #10 seq = 1;
    #10 seq = 0;
    #10 seq = 1;
    end
    
    // Wait and finish simulation
    #200;
    $finish;
  end

  // Monitor and wave dump
  initial begin
    $monitor("Time=%0t | clk=%b | rst_n=%b | seq=%b | out=%b", $time, clk, rst_n, seq, out);
    $dumpfile("dump.vcd");
    $dumpvars();
  end

endmodule
