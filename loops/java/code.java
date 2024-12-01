package jvm;

import java.util.Random;

public class code {

    public static void main(String[] args) {
        var u = Integer.parseInt(args[0]); // Get an input number from the command line
        var r = new Random().nextInt(10000); // Get a random number 0 <= r < 10k
        var a = new int[10000]; // Array of 10k elements initialized to 0
        for (var i = 0; i < 10000; i++) { // 10k outer loop iterations
            for (var j = 0; j < 100000; j++) { // 100k inner loop iterations, per outer loop iteration
                a[i] = a[i] + j % u; // Simple sum
            }
            a[i] += r; // Add a random value to each element in array
        }
        System.out.println(a[r]); // Print out a single element from the array
    }
}
