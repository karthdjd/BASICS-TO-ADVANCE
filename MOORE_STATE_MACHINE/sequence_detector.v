module sequence_detector(
  input clk, rst_n,
  input seq,
  output reg out
);

  localparam FSM_WIDTH          = 3;
  localparam FSM_IDLE           = 3'b000;
  localparam FSM_0_DETECT       = 3'b001;
  localparam FSM_01_DETECT      = 3'b010;
  localparam FSM_010_DETECT     = 3'b011;
  localparam FSM_011_DETECT     = 3'b100;
  localparam FSM_OUT_STATE      = 3'b101;
  localparam FSM_OUT_HOLD_STATE = 3'b110;

  reg [FSM_WIDTH-1 : 0] state;
  reg [FSM_WIDTH-1 : 0] next_state;

  // Sequential logic: state update
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      state <= FSM_IDLE;
    end else begin
      state <= next_state;
    end
  end

  // Combinational logic: next state transitions
  always @(*) begin
    case (state)
      FSM_IDLE: begin
        if (seq) next_state = FSM_IDLE;
        else next_state = FSM_0_DETECT;
      end

      FSM_0_DETECT: begin
        if (seq) next_state = FSM_01_DETECT;
        else next_state = FSM_IDLE;
      end

      FSM_01_DETECT: begin
        if (seq) next_state = FSM_011_DETECT;
        else next_state = FSM_010_DETECT;
      end

      FSM_010_DETECT: begin
        if (seq) next_state = FSM_OUT_STATE;
        else next_state = FSM_0_DETECT;
      end

      FSM_011_DETECT: begin
        if (seq) next_state = FSM_IDLE;
        else next_state = FSM_OUT_STATE;
      end

      FSM_OUT_STATE: begin
        next_state = FSM_OUT_HOLD_STATE;
      end
        
      FSM_OUT_HOLD_STATE:begin
        next_state = FSM_IDLE;
      end

      default: next_state = FSM_IDLE;  
    endcase
  end

  
  always @(*) begin
    case (state)
      FSM_IDLE: out = 0;
      FSM_0_DETECT: out = 0;
      FSM_01_DETECT: out = 0;
      FSM_010_DETECT: out=0;
      FSM_011_DETECT:out = 0;
      FSM_OUT_STATE: out = 1;  
      FSM_OUT_HOLD_STATE: out =1;
      default: out = 0;  
    endcase
  end

endmodule
