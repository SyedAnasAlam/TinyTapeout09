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
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [63:0] _RAND_3;
`endif // RANDOMIZE_REG_INIT
  reg [5:0] fprev; // @[PWM_Generator.scala 31:22]
  reg [5:0] fnext; // @[PWM_Generator.scala 32:22]
  reg  pwm_out; // @[PWM_Generator.scala 34:24]
  reg [35:0] pwm_cnt; // @[PWM_Generator.scala 35:24]
  wire [33:0] _GEN_5 = {{31'd0}, io_ui_in[7:5]}; // @[PWM_Generator.scala 39:34]
  wire [33:0] _pwm_threshold_T_2 = _GEN_5 << io_ui_in[4:0]; // @[PWM_Generator.scala 39:34]
  wire [33:0] _GEN_6 = {{31'd0}, io_uio_in[7:5]}; // @[PWM_Generator.scala 40:29]
  wire [33:0] _pwm_top_T_2 = _GEN_6 << io_uio_in[4:0]; // @[PWM_Generator.scala 40:29]
  wire [35:0] _pwm_cnt_T_1 = pwm_cnt + 36'h1; // @[PWM_Generator.scala 42:22]
  wire [35:0] pwm_threshold = {{2'd0}, _pwm_threshold_T_2}; // @[PWM_Generator.scala 36:34 39:17]
  wire [35:0] pwm_top = {{2'd0}, _pwm_top_T_2}; // @[PWM_Generator.scala 37:28 40:11]
  wire [5:0] _fnext_T_1 = fnext + fprev; // @[PWM_Generator.scala 48:20]
  wire [6:0] _io_uo_out_T = {io_ena,fnext}; // @[PWM_Generator.scala 55:23]
  assign io_uo_out = {_io_uo_out_T,pwm_out}; // @[PWM_Generator.scala 55:32]
  assign io_uio_out = 8'h0; // @[PWM_Generator.scala 28:14]
  assign io_uio_oe = 8'h0; // @[PWM_Generator.scala 29:13]
  always @(posedge clock) begin
    if (reset) begin // @[PWM_Generator.scala 31:22]
      fprev <= 6'h0; // @[PWM_Generator.scala 31:22]
    end else if (pwm_cnt == pwm_top) begin // @[PWM_Generator.scala 44:29]
      if (fnext == 6'h37) begin // @[PWM_Generator.scala 49:26]
        fprev <= 6'h0; // @[PWM_Generator.scala 50:15]
      end else begin
        fprev <= fnext; // @[PWM_Generator.scala 47:11]
      end
    end
    if (reset) begin // @[PWM_Generator.scala 32:22]
      fnext <= 6'h1; // @[PWM_Generator.scala 32:22]
    end else if (pwm_cnt == pwm_top) begin // @[PWM_Generator.scala 44:29]
      if (fnext == 6'h37) begin // @[PWM_Generator.scala 49:26]
        fnext <= 6'h1; // @[PWM_Generator.scala 51:15]
      end else begin
        fnext <= _fnext_T_1; // @[PWM_Generator.scala 48:11]
      end
    end
    if (reset) begin // @[PWM_Generator.scala 34:24]
      pwm_out <= 1'h0; // @[PWM_Generator.scala 34:24]
    end else begin
      pwm_out <= pwm_cnt <= pwm_threshold; // @[PWM_Generator.scala 43:11]
    end
    if (reset) begin // @[PWM_Generator.scala 35:24]
      pwm_cnt <= 36'h0; // @[PWM_Generator.scala 35:24]
    end else if (pwm_cnt == pwm_top) begin // @[PWM_Generator.scala 44:29]
      pwm_cnt <= 36'h0; // @[PWM_Generator.scala 45:13]
    end else begin
      pwm_cnt <= _pwm_cnt_T_1; // @[PWM_Generator.scala 42:11]
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
  fprev = _RAND_0[5:0];
  _RAND_1 = {1{`RANDOM}};
  fnext = _RAND_1[5:0];
  _RAND_2 = {1{`RANDOM}};
  pwm_out = _RAND_2[0:0];
  _RAND_3 = {2{`RANDOM}};
  pwm_cnt = _RAND_3[35:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
