program RandomArrayCalculation;

uses
  SysUtils;

var
  u, r, i, j: LongInt; // LongInt supports larger values
  a: array[0..9999] of LongInt;

begin
  if ParamCount < 1 then
  begin
    Writeln('Usage: <program> <integer>');
    Halt(1);
  end;

  // Get the input number from the command line
  u := StrToInt(ParamStr(1));

  // Get a random number 0 <= r < 10000
  Randomize;
  r := Random(10000);

  // Initialize the array with zeros
  for i := 0 to 9999 do
    a[i] := 0;

  // Nested loop to perform calculations
  for i := 0 to 9999 do
  begin
    for j := 0 to 99999 do
      a[i] := a[i] + j mod u; // Simple sum

    a[i] := a[i] + r; // Add the random value
  end;

  // Print a specific element from the array
  Writeln(a[r]);
end.
