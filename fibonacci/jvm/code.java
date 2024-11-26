package jvm;

public class code {

    private static int fibonacci(int n) {
        return fibonacciAccumulator(n,0,1);
    }
    private static int fibbonaciAccumulator(int n, int acc1, int acc2) {
      if (n == 0) {
          return acc1;
      }
      return fibbonaciAccumulator(n - 1, acc2, acc1 + acc2);
    }

    public static void main(String[] args) {
        var u = Integer.parseInt(args[0]);
        var r = 0;
        for (var i = 1; i < u; i++) {
            r += fibonacci(i);
        }
        System.out.println(r);
    }
}
