program code;
{$APPTYPE CONSOLE}
{$O+}
{$R-}
{$Q-}
uses
  SysUtils;

var
  u: Cardinal;
  r: Cardinal;
  i, j: Cardinal;
  a: array[0..9999] of Cardinal;

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

begin
  if ParamCount < 1 then
  begin
    WriteLn('Usage: ', ParamStr(0), ' <number>');
    Halt(1);
  end;

  u := ParseCommandLine;
  r := Random(10000);

  for i := 0 to 9999 do
  begin
    a[i] := 0;  
    for j := 0 to 99999 do
    begin
      a[i] := a[i] + j mod u;
    end;
    a[i] := a[i] + r;
  end;

  WriteLn(a[r]);
end.
