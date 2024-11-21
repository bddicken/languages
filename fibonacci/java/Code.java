class Code {

    private static int fibonacci(int n) {
        if (n == 0) return 0;
        if (n == 1) return 1;
        return fibonacci(n-1) + fibonacci(n-2);
    }
    
    public static void main(String[] args) {
        int u = Integer.parseInt(args[0]);
        int r = 0;
        for (int i = 1; i < u; i++) {
            r += fibonacci(i);
        }
        System.out.printf("%d\n", r);
    }

}
