with Ada.Text_IO;      use Ada.Text_IO;
with Ada.Command_Line; use Ada.Command_Line;

procedure Code is

   function Fibonacci (N : Natural) return Natural is
   begin
      if N = 0 then
         return 0;
      end if;

      if N = 1 then
         return 1;
      end if;

      return Fibonacci (N - 1) + Fibonacci (N - 2);
   end Fibonacci;

   U : constant Natural := Natural'Value (Argument (1));
   R : Natural := 0;

begin
   for I in 1 .. U - 1 loop
      R := R + Fibonacci (I);
   end loop;

   Put_Line (R'Image);
end Code;
