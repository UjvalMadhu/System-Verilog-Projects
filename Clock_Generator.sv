//This is a simple SV code that can generate a clock signal by specifying the period and duty cycle for the clock signal

//Author: UJVAL MADHU
//DATE: 20 June 2023

`timescale 1ns/1ps

module tb();

// Initializing Variables
  reg clk;
  real period;
  real ton;
  real toff;
  
// Task for calculating the On duration and off duration of the clock signal   
  task t_calc( input real period, input real duty_cycle, output real ton, output real toff);
    
    ton = period * duty_cycle;
    toff = period - ton;
    
  endtask

// Task for generating the clock signal for a specified On and OFF duration   
  task clk_gen(input real ton, input real toff);       
    while(1)
      begin
        clk = 1;
        #ton;
        clk = 0;
        #toff;
      end
    endtask

// Generating the clock signal for a period of 40 ns and duty cyccle of 0.4
  initial begin
    t_calc(40,0.4,ton,toff);
    clk_gen(ton,toff);
  end
   
// Terminating the program after 200ns
  initial begin
    #200
    $finish();
  end
 
// This code was executed on EDA Playground website, which requires the following code block for displaying the waveform
  initial 
    begin
      $dumpfile("dump.vcd");
      $dumpvars;
    end
  
  endmodule
