program FibonacciPascal;

uses
  SysUtils;

function Fibonacci(n: UInt32): UInt32; inline;
begin
  if n = 0 then
    Fibonacci := 0
  else if n = 1 then
    Fibonacci := 1
  else
    Fibonacci := Fibonacci(n - 1) + Fibonacci(n - 2);
end;

var
  u, r, i: UInt32;
begin
  u := StrToInt(ParamStr(1));
  r := 0;
  for i := 1 to u - 1 do
  begin
    r := r + Fibonacci(i);
  end;
  WriteLn(r);
end.
