package jvm;

import java.util.Random;

import jdk.incubator.vector.IntVector;
import jdk.incubator.vector.VectorOperators;

public class code {
    public static void main(String[] args) {
        var u = Integer.parseInt(args[0]); // Get an input number from the command line
        var r = new Random().nextInt(10000); // Get a random number 0 <= r < 10k
        var rv = IntVector.SPECIES_PREFERRED.broadcast(r); // Broadcast scalar to vector
        var a = new int[10000]; // Array of 10k elements initialized to 0
        for (var i = 0; i < 10000; i += IntVector.SPECIES_PREFERRED.length()) { // 10k outer loop iterations
            var av = IntVector.SPECIES_PREFERRED.fromArray(a, i); // Load vector from array
            for (var j = 0; j < 100000; j ++) { // 100k inner loop iterations, per outer loop iteration
                var jv = IntVector.SPECIES_PREFERRED.broadcast(j % u);  // Broadcast modulo of scalar to vector
                av = av.add(jv); // Vectorized addition
            }
            av = av.add(rv); // Add a random value to each element in array
            av.reinterpretAsInts().intoArray(a, i); // Store vector back to array
        }
        System.out.println(a[r]); // Print out a single element from the array
    }
}
