program LoopsPascal;

uses
  SysUtils;

var
  u, r, i, j: Int32;
  a: array[0..9999] of Int32;

begin
  if ParamCount < 1 then
  begin
    WriteLn('Usage: ', ParamStr(0), ' <number>');
    Exit;
  end;

  u := StrToInt(ParamStr(1));          // Get an input number from the command line
  Randomize;
  r := Random(10000);                  // Get a random integer 0 <= r < 10k

  for i := 0 to 9999 do                // 10k outer loop iterations
  begin
    for j := 0 to 99999 do             // 100k inner loop iterations, per outer loop iteration
    begin
      a[i] := a[i] + j mod u;          // Simple sum
    end;
    a[i] := a[i] + r;                  // Add a random value to each element in array
  end;

  WriteLn(a[r]);                       // Print out a single element from the array
end.