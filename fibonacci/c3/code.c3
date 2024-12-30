import std::io;

fn int fibonacci(int n) {
    if (n == 0) {
        return 0;
    } else if (n == 1) {
        return 1;
    }
    return fibonacci(n - 1) + fibonacci(n - 2);
}

fn int main(String[] args) {
    int u = args[1].to_int()!!;
    int r = 0;
    
    for (int i = 1; i < u; ++i) {
        r += fibonacci(i);
    }

    io::printn(r);
    return 0;
}