import java.util.Random

@main def code(u: Int): Unit =
  val r: Int = (new Random).nextInt(10000)
  val a = new Array[Int](10000)
  
  0 until 10000 foreach:
    i => 0 until 100000 foreach:
         a(i) += _ % u
    a(i) += r

  println(a(r))



