program Levenshtein;

{$MODE OBJFPC}
{$OPTIMIZATION LEVEL4}
{$INLINE ON}
{$RANGECHECKS OFF}
{$OVERFLOWCHECKS OFF}
{$R-}
{$Q-}
{$O+}

uses
  SysUtils, Math;

function Levenshtein(const S1, S2: string): Integer;
var
  M, N, I, J: Integer;
  DeletionCost, InsertionCost, SubstitutionCost: Integer;
  PrevRow, CurrRow: array of Integer;

  procedure Swap(var P1, P2: Pointer); inline;
  var
    Temp: Pointer;
  begin
    Temp := P1;
    P1 := P2;
    P2 := Temp;
  end;

begin
  M := Length(S1);
  N := Length(S2);

  if S1 = S2 then Exit(0);
  if S1 = '' then Exit(N);
  if S2 = '' then Exit(M);

  if M > N then Exit(Levenshtein(S2, S1));

  SetLength(PrevRow, M + 1);
  SetLength(CurrRow, M + 1);

  for I := 0 to M do
    PrevRow[I] := I;

  for J := 1 to N do
  begin
    CurrRow[0] := J;

    for I := 1 to M do
    begin
      DeletionCost := PrevRow[I] + 1;
      InsertionCost := CurrRow[I - 1] + 1;

      SubstitutionCost := PrevRow[I - 1];
      if S1[I] <> S2[J] then
        Inc(SubstitutionCost);

      CurrRow[I] := Min(Min(DeletionCost, InsertionCost), SubstitutionCost);
    end;

    Swap(Pointer(PrevRow), Pointer(CurrRow));
  end;

  Levenshtein := PrevRow[M];

  SetLength(PrevRow, 0);
  SetLength(CurrRow, 0);
end;

var
  Args: array of string;
  MinDistance, Distance, Comparisons, I, J: Integer;
  NumArgs: Integer;

begin
  NumArgs := ParamCount;

  if NumArgs < 2 then
  begin
    Writeln('Please provide at least two strings as arguments.');
    Exit;
  end;

  SetLength(Args, NumArgs);
  for I := 1 to NumArgs do
    Args[I - 1] := ParamStr(I);

  MinDistance := MaxInt;
  Comparisons := 0;

  for I := 0 to NumArgs - 1 do
  begin
    for J := 0 to NumArgs - 1 do
    begin
      if I <> J then
      begin
        Distance := Levenshtein(Args[I], Args[J]);
        MinDistance := Min(MinDistance, Distance);
        Inc(Comparisons);
      end;
    end;
  end;

  Writeln('times: ', Comparisons);
  Writeln('min_distance: ', MinDistance);
end.
