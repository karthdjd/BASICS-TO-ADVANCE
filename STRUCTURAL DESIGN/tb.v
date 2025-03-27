module tb;
  reg clk, rst_n, x;
  wire z;

  // Instantiate the D Flip-Flop module
  dut_top uut (.clk(clk), .rst_n(rst_n), .x(x), .z(z));

  // Generate clock
  always #5 clk = ~clk;  // Toggle clock every 5 time units

  initial begin
    clk = 0;
    rst_n = 0; x = 0;
    #10 rst_n = 1;  // Release reset
    repeat(5)begin
      @(posedge clk);
    #10 x = 1;
    #10 x = 0;
    #10 x = 1;
    #10 x = 0;
    end
    #30 $finish;  // End simulation
  end
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars();
    $monitor("Time=%0t | clk=%b | rst_n=%b | x=%b | z=%b", $time, clk, rst_n, x, z);
  end
endmodule
