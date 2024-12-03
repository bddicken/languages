with Ada.Text_IO;      use Ada.Text_IO;
with Ada.Command_Line; use Ada.Command_Line;
with Ada.Numerics.Discrete_Random;

procedure Code is
   subtype Random_Range is Integer range 0 .. 9999;
   package Rand is new Ada.Numerics.Discrete_Random (Random_Range);
   use Rand;

   Gen : Generator;
   
   U : constant Integer := Integer'Value (Argument (1));
   R : Random_Range;
   A : array (1 .. 10000) of Integer := [others => 0];

begin
   Reset (Gen);
   R := Random (Gen);

   for I in 1 .. 10000 loop
      for J in 0 .. 99999 loop
         A (I) := A (I) + (J rem U);
      end loop;

      A (I) := A (I) + R;
   end loop;

   Put_Line (A (R)'Image);
end Code;
