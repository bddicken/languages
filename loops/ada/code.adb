with Ada.Text_IO;
with Ada.Integer_Text_IO;
with Ada.Command_Line;
with Ada.Numerics.Float_Random;

procedure Main is
   U : Integer;
   R : Integer;
   A : array(1..10000) of Integer := (others => 0);
   Gen : Ada.Numerics.Float_Random.Generator;
   Rand_Value : Integer;
begin
   U := Integer'Value(Ada.Command_Line.Argument(1));

   -- Generate a random integer between 0 and 9999
   Ada.Numerics.Float_Random.Reset(Gen);
   Rand_Value := Integer(Ada.Numerics.Float_Random.Random(Gen) * 10000.0);

   for I in 1..10000 loop
      for J in 0..99999 loop
         A(I) := A(I) + (J mod U);
      end loop;
      A(I) := A(I) + Rand_Value;
   end loop;

   R := Rand_Value;
   Ada.Integer_Text_IO.Put(Item => A(R), Width => 0);
end Main;
