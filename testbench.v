module tb_mealy_machine;
    reg clk;
    reg reset;
    reg in;
    wire out;
    mealy_machine uut (
        .clk(clk),
        .reset(reset),
        .in(in),
        .out(out)
    );
    always #5 clk = ~clk;
    initial begin
        clk = 0;
        reset = 1;
        in = 0;
        #10 reset = 0;
        #10 in = 1'b0;		// Test Case 1: From s0 -> s1 (input 0) // s0 -> s1
        #10 in = 1'b1;  	// Test Case 2: From s1 -> s2 (input 1)// s1 -> s2
        #10 in = 1'b0; 		// Test Case 3: From s2 -> s3 (input 0)// s2 -> s3
        #10 in = 1'b1; 		// Test Case 4: From s3 -> s2 (input 1, with output 1)// s3 -> s2, out = 1
        #10 in = 1'b0;  	// Test Case 5: From s3 -> s1 (input 0)// s2 -> s3       
        #10 in = 1'b0;  	// Test Case 6: From s1 -> stay in s1 (input 0)// stay in s1       
        #10 in = 1'b1;  	// Test Case 7: From s2 -> s0 (input 1)// s2 -> s0        
        #10 in = 1'b1;		// Test Case 8: From s0 -> stay in s0 (input 1) // stay in s0      
        #10 reset = 1; 		// Test Case 9: Reset and test again
        #10 reset = 0;
        #10 in = 1'b0;
        #10 in = 1'b1;
        #10 in = 1'b1;
        #10 in = 1'b0;
        #10 $finish;
    end
	initial begin
      $dumpfile("dumpfile.vcd");
      $dumpvars(1);
    end
    initial begin
        $monitor("Time = %0t, Reset = %b, Input = %b, Output = %b, Current State = %b", $time, reset, in, out, uut.current_state);
    end
endmodule
