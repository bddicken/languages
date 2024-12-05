program code;
{$MODE OBJFPC}
{$OPTIMIZATION LEVEL4}
{$INLINE ON}
{$RANGECHECKS OFF}
{$OVERFLOWCHECKS OFF}
{$R-}
{$Q-}
{$O+}
uses
  SysUtils;

function Fibonacci(n: Cardinal): Cardinal; register;
begin
  if n <= 1 then
    Fibonacci := n
  else
    Fibonacci := Fibonacci(n-1) + Fibonacci(n-2);
end;

function ParseCommandLine: Cardinal;
var
  s: string;
  code: Integer;
  value: Cardinal;
begin
  s := ParamStr(1);
  Val(s, value, code);
  if code <> 0 then
  begin
    WriteLn('Usage: ', ParamStr(0), ' <number>');
    Halt(1);
  end;
  ParseCommandLine := value;
end;

var
  u: Cardinal;
  r: Cardinal;
  i: Cardinal;
begin
  if ParamCount < 1 then
  begin
    WriteLn('Usage: ', ParamStr(0), ' <number>');
    Halt(1);
  end;

  u := ParseCommandLine;
  r := 0;

  for i := 1 to u - 1 do
  begin
    r := r + Fibonacci(i);
  end;

  WriteLn(r);
end.
