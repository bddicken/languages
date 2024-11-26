with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Ada.Command_Line; 
with Ada.Text_IO;

procedure Fibonacci_Sum is
   function Fibonacci (N : Integer) return Integer is
   begin
      if N = 0 then
         return 0;
      elsif N = 1 then
         return 1;
      else
         return Fibonacci (N - 1) + Fibonacci (N - 2);
      end if;
   end Fibonacci;

   U : Integer;
   R : Integer := 0;

begin
   U := Integer'Value (Ada.Command_Line.Argument (1));

   for I in 1 .. U - 1 loop
      R := R + Fibonacci (I);
   end loop;

   Ada.Integer_Text_IO.Put(Item => R);
end Fibonacci_Sum;
