`timescale 1ns/1ps

module tb_glitch_free_mux;
  reg clk_1, clk_2, rst_n, sel;
  wire clk_out;
  
  glitch_free_mux uut (
    .clk_1(clk_1),
    .clk_2(clk_2),
    .rst_n(rst_n),
    .sel(sel),
    .clk_out(clk_out)
  );

  // Generate clock 1 (period = 10 ns -> 100 MHz)
  initial begin
    clk_1 = 0;
    forever #5 clk_1 = ~clk_1;
  end

  // Generate clock 2 (period = 16 ns -> 62.5 MHz)
  initial begin
    clk_2 = 0;
    forever #8 clk_2 = ~clk_2;
  end

  // Stimulus
  initial begin
    // Initialize
    rst_n = 0;
    sel = 0;
    #20;
    rst_n = 1;
    
    // Select clk_1
    #100;
    sel = 1; // switch to clk_2
    #200;
    sel = 0; // switch back to clk_1
    #200;
    
    // Switch multiple times
    sel = 1;
    #300;
    sel = 0;
    #300;
    
    $finish;
  end

  // Monitor
  initial begin
    $dumpfile("glitch_free_mux.vcd");
    $dumpvars(0, tb_glitch_free_mux);
    $monitor($time, " sel=%b clk_out=%b clk1=%b clk2=%b", sel, clk_out, clk_1, clk_2);
  end
endmodule
