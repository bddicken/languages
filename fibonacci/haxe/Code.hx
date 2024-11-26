class Code {
    
    static function fibonacci(n:Int):Int {
        if (n == 0)
            return 0;
			
        if (n == 1)
            return 1;
			
        return fibonacci(n - 1) + fibonacci(n - 2);
    }

    static function main() {
        var u:Int = Std.parseInt(Sys.args()[0]);
        var r:Int = 0;
        
        for (i in 1...u) {
            r += fibonacci(i);
        }

        Sys.println(r);
    }
}