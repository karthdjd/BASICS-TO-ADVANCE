module sequence_detector (
    input wire clk,
    input wire rst_n,  
    input wire x,
    output reg z
);

    
    localparam S0 = 3'b000,
               S1 = 3'b001,
               S2 = 3'b010,
               S3 = 3'b011,
               S4 = 3'b100;

    reg [2:0] state, next_state;
    reg hold_flag;
    reg hold_counter;  // Counter to hold 2 cycles

    
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            state <= S0;
            hold_flag <= 1'b0;
            hold_counter <= 1'b0;
        end else begin
            state <= next_state;
        end
    end

    
    always @(*) begin
        next_state = state;
        case (state)
            S0: if (x == 0) next_state = S1;
                else next_state = S0;
            S1: if (x == 1) next_state = S2;
                else next_state = S1;
            S2: if (x == 0) next_state = S3;
                else next_state = S4;
            S3: if (x == 1) next_state = S0;
                else next_state = S1;
            S4: next_state = S0;
            default: next_state = S0;
        endcase
    end

    
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            hold_flag <= 1'b0;
            hold_counter <= 1'b0;
        end else if ((state == S3 && x == 1) || (state == S4 && x == 0)) begin
            hold_flag <= 1'b1;  
            hold_counter <= 1'b1;  
        end else if (hold_counter) begin
            hold_counter <= 1'b0;  
        end else begin
            hold_flag <= 1'b0;  
        end
    end

   
    always @(*) begin
        z = hold_flag;
    end

endmodule
