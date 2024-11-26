import haxe.ds.Vector;

class Code {
	public static function main() {
		var u:Int = Std.parseInt(Sys.args()[0]); // Command line input number
		var r:Int = Std.random(10000);
		var a = new Vector<Int>(10000); // Initialize a vector with 10,000 elements

		for (i in 0...10000) { // Outer loop with 10k iterations
			#if !java
			a[i] = 0; // Set all VectorData to 0, this part is unnecessary since the JVM target already fills the values with 0.
			#end
			
			for (j in 0...100000) { // 100k inner loop iterations
				a[i] = a[i] + j % u; // Simple sum operation
			}
			a[i] += r; // Add random number to each element
		}

		// Print out a single element from the vector (indexed by r)
		Sys.println(a[r]);
	}
}