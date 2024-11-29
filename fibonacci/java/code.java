package jvm;

public class code {

    private static int fibonacci(int n) {
        if (n == 0) {
            return 0;
        }
        if (n == 1) {
            return 1;
        }
        return fibonacci(n - 1) + fibonacci(n - 2);
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
