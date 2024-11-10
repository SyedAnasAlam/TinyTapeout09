import chisel3._
import chisel3.util._

/* 
* All IOs used as inputs only
* fout = fin/(pwm_top+1) 
* duty_cycle = (pwm_threshold+1)/(pwm_top+1)
* 
* pwm_top set by ui_uio_in
* pwm_threshold set by ui_in
* 
* pwm_top and pwm_threshold encoded as follows: base << shift_amount
* base is 3 bits wide and shift amount is 5 bits wide
*/
class PWM_Generator() extends Module {
  val io = IO(new Bundle {
    val ui_in = Input(UInt(8.W))      // Dedicated inputs
    val uo_out = Output(UInt(8.W))    // Dedicated outputs

    val uio_in = Input(UInt(8.W))     // IOs: Input path
    val uio_out = Output(UInt(8.W))   // IOs: Output path
    val uio_oe = Output(UInt(8.W))    // IOs: Enable path (active high: 0=input, 1=output)

    val ena = Input(Bool())           // will go high when the design is enabled
  })
  
  // use all bidirectionals as inputs
  io.uio_out := 0.U
  io.uio_oe := 0.U

  val fprev = RegInit(0.U(6.W))
  val fnext = RegInit(1.U(6.W))

  val pwm_out = RegInit(false.B)
  val pwm_cnt = RegInit(0.U(36.W))
  val pwm_threshold = WireDefault(0.U(36.W))
  val pwm_top = WireDefault(0.U(36.W))

  pwm_threshold := io.ui_in(7,5) << io.ui_in(4,0)
  pwm_top := io.uio_in(7,5) << io.uio_in(4,0)

  pwm_cnt := pwm_cnt + 1.U
  pwm_out := pwm_cnt <= pwm_threshold
  when(pwm_cnt === pwm_top) {
    pwm_cnt := 0.U

    fprev := fnext
    fnext := fnext + fprev
    when(fnext === 55.U) {
        fprev := 0.U
        fnext := 1.U
    }
  }

  io.uo_out := io.ena ## fnext ## pwm_out
}

object PWM_Generator extends App {
  emitVerilog(new PWM_Generator(), Array("--target-dir", "src"))
}