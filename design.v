module mealy_machine (
    input wire clk,        
    input wire reset,    
    input wire in,         
    output reg out      
);
    parameter s0 = 2'b00, s1 = 2'b01, s2 = 2'b10, s3 = 2'b11;
    reg [1:0] current_state, next_state;
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= s0; 
        end else begin
            current_state <= next_state;  
        end
    end
    always @(*) begin
        case (current_state)
            s0: begin
                if (in == 1'b0) begin
                    next_state = s1;
                    out = 1'b0;
                end else begin
                    next_state = s0;
                    out = 1'b0;
                end
            end
            s1: begin
                if (in == 1'b0) begin
                    next_state = s1;
                    out = 1'b0;
                end else begin
                    next_state = s2;
                    out = 1'b0;
                end
            end
            s2: begin
                if (in == 1'b0) begin
                    next_state = s3;
                    out = 1'b0;
                end else begin
                    next_state = s0;
                    out = 1'b0;
                end
            end
            s3: begin
                if (in == 1'b0) begin
                    next_state = s1;
                    out = 1'b0;
                end else begin
                    next_state = s2;
                    out = 1'b1;  
                end
            end
            default: begin
                next_state = s0;
                out = 1'b0;
            end
        endcase
    end
endmodule
