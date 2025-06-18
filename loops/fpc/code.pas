program LoopsPascal;

uses
  SysUtils;

var
  u: UInt32;
  a: array[0..9999] of UInt32;
  i, j, r: UInt32;

begin
  u := StrToInt(ParamStr(1));          // Get an input number from the command line
  Randomize;                           // Fix random seed
  r := Random(10000);                  // Get a random integer 0 <= r < 10k
  for i := 0 to 9999 do                // 10k outer loop iterations
  begin
    a[i] := 0;                         // Array of 10k elements initialized to 0
    for j := 0 to 99999 do             // 100k inner loop iterations, per outer loop iteration
      a[i] := a[i] + j mod u;          // Simple sum
    a[i] := a[i] + r;                  // Add a random value to each element in array
  end;
  WriteLn(a[r]);                       // Print out a single element from the array
end.