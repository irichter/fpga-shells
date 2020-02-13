package sifive.fpgashells.shell

import chisel3._
import chisel3.experimental.{Analog, attach}
import chisel3.util.HasBlackBoxInline

class AnalogToUInt(w: Int = 1) extends BlackBox with HasBlackBoxInline {
  val io = IO(new Bundle {
    val a = Analog(w.W)
    val b = Output(UInt(w.W))
  })
  setInline(s"AnalogToUInt.v",
    s"""module AnalogToUInt (a, b);
       |  inout [${w - 1}:0] a;
       |  output [${w - 1}:0] b;
       |  assign b = a;
       |endmodule
       |""".stripMargin)
}

object AnalogToUInt {
  def apply(a: Analog): UInt = {
    val a2b = Module(new AnalogToUInt(w = a.getWidth))
    attach(a, a2b.io.a)
    a2b.io.b
  }
}

class UIntToAnalog(w: Int = 1) extends BlackBox with HasBlackBoxInline {
  val io = IO(new Bundle {
    val a = Analog(w.W)
    val b = Input(UInt(w.W))
    val b_en = Input(Bool())
  })
  require(w >= 1)
  setInline(s"UIntToAnalog.v",
    s"""module UIntToAnalog(a, b, b_en);
       |  inout [${w - 1}:0] a;
       |  input [${w - 1}:0] b;
       |  input b_en;
       |  assign a = b_en ? b : $w'b${"z"*w};
       |endmodule
       |""".stripMargin)
}

object UIntToAnalog {
  def apply(b: UInt, a: Analog, b_en: Bool): Unit = {
    val a2b = Module(new UIntToAnalog(w = a.getWidth))
    attach(a, a2b.io.a)
    a2b.io.b := b
    a2b.io.b_en := b_en
  }
}
