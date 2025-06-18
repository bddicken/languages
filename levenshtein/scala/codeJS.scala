//> using scala 3.6.2
//> using file base.scala

import scala.scalajs.js
import scala.scalajs.js.annotation.JSGlobal

@js.native
@JSGlobal("process")
object NodeProcess extends js.Object {
  val argv: js.Array[String] = js.native
}

object MainJS {
  def main(args: Array[String]): Unit = {
    val params = NodeProcess.argv.drop(2)
    LevenshteinDistance.run(params.toArray)
  }
}
