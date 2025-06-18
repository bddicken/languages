import std::io;
import std::math;

fn int main(String[] args) {
    int u = args[1].to_int()!!;
    int r = rand(10000);
    int[10000] a;
    for (int i = 0; i < 10000; ++i) {
        for (int j = 0; j < 100000; ++j) {
            a[i] = a[i] + j%u;
        }
        a[i] += r;
    }
    io::printn(a[r]);
    return 0;
}