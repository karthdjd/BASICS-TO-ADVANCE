module right_shift_reg_tb;

  reg clk, rst_n, a, shift_en;
  wire [3:0] shift_out;

  // Instantiate the DUT (Device Under Test)
  right_shift_reg dut (
    .a(a),
    .shift_en(shift_en),
    .clk(clk),
    .rst_n(rst_n),
    .shift_out(shift_out)
  );

  // Generate clock with 10ns period
  always #5 clk = ~clk;

  initial begin
    // Initialize signals
    clk = 0;
    rst_n = 0;
    a = 0;
    shift_en = 0;

    // Reset sequence
    #10 rst_n = 1;   // Deassert reset after 10ns

    // Test sequence
    #10 shift_en = 1; a = 1;  // Apply first input
    #10 a = 1;               // Next input
    #10 a = 1;
    #10 a = 1;
    #10 shift_en = 0;
    #10 a = 0;
    
    
    

    // End simulation
    #50 $finish;
  end

  // Monitor output
  initial begin
    $monitor("Time=%0t | a=%b | shift_en=%b | shift_out=%b", 
             $time, a, shift_en, shift_out);
  end
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
  end

endmodule
