module PWM_Generator(
  input        clock,
  input        reset,
  input  [7:0] io_ui_in,
  output [7:0] io_uo_out,
  input  [7:0] io_uio_in,
  output [7:0] io_uio_out,
  output [7:0] io_uio_oe,
  input        io_ena
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [63:0] _RAND_1;
`endif // RANDOMIZE_REG_INIT
  reg  pwm_out; // @[Fibonacci.scala 30:24]
  reg [35:0] pwm_cnt; // @[Fibonacci.scala 31:24]
  wire [33:0] _GEN_1 = {{31'd0}, io_ui_in[7:5]}; // @[Fibonacci.scala 35:34]
  wire [33:0] _pwm_threshold_T_2 = _GEN_1 << io_ui_in[4:0]; // @[Fibonacci.scala 35:34]
  wire [33:0] _GEN_2 = {{31'd0}, io_uio_in[7:5]}; // @[Fibonacci.scala 36:29]
  wire [33:0] _pwm_top_T_2 = _GEN_2 << io_uio_in[4:0]; // @[Fibonacci.scala 36:29]
  wire [35:0] _pwm_cnt_T_1 = pwm_cnt + 36'h1; // @[Fibonacci.scala 38:22]
  wire [35:0] pwm_threshold = {{2'd0}, _pwm_threshold_T_2}; // @[Fibonacci.scala 32:34 35:17]
  wire [35:0] pwm_top = {{2'd0}, _pwm_top_T_2}; // @[Fibonacci.scala 33:28 36:11]
  assign io_uo_out = {7'h0,pwm_out}; // @[Fibonacci.scala 44:25]
  assign io_uio_out = 8'h0; // @[Fibonacci.scala 27:14]
  assign io_uio_oe = 8'h0; // @[Fibonacci.scala 28:13]
  always @(posedge clock) begin
    if (reset) begin // @[Fibonacci.scala 30:24]
      pwm_out <= 1'h0; // @[Fibonacci.scala 30:24]
    end else begin
      pwm_out <= pwm_cnt <= pwm_threshold; // @[Fibonacci.scala 39:11]
    end
    if (reset) begin // @[Fibonacci.scala 31:24]
      pwm_cnt <= 36'h0; // @[Fibonacci.scala 31:24]
    end else if (pwm_cnt == pwm_top) begin // @[Fibonacci.scala 40:29]
      pwm_cnt <= 36'h0; // @[Fibonacci.scala 41:13]
    end else begin
      pwm_cnt <= _pwm_cnt_T_1; // @[Fibonacci.scala 38:11]
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  pwm_out = _RAND_0[0:0];
  _RAND_1 = {2{`RANDOM}};
  pwm_cnt = _RAND_1[35:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
