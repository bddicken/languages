with Ada.Text_IO;         use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Ada.Command_Line;    use Ada.Command_Line;

procedure Code is
   type Matrix_Type is array (Natural range <>, Natural range <>) of Integer;

   Min_Distance : Integer := -1;
   Times        : Natural := 0;
   Distance     : Integer := 0;

   ---------
   -- Min --
   ---------

   function Min (A, B, C : Natural) return Natural is
      Min : Natural := A;
   begin
      if B < Min then
         Min := B;
      end if;

      if C < Min then
         Min := C;
      end if;

      return Min;
   end Min;

   -----------------
   -- Levenshtein --
   -----------------

   function Levenshtein_Distance
     (Str1 : in String; Str2 : in String) return Natural
   is
      M : Natural := Str1'Length;
      N : Natural := Str2'Length;

      Matrix : Matrix_Type (0 .. M + 1, 0 .. N + 1) :=
        (others => (others => 0));

      Cost : Natural := 0;
   begin
      for I in Matrix'Range(1) loop
         Matrix (I, 0) := I;
      end loop;

      for J in Matrix'Range(2) loop
         Matrix (0, J) := J;
      end loop;

      for I in 1 .. M loop
         for J in 1 .. N loop

            if Str1 (I) = Str2 (J) then
               Cost := 0;
            else
               Cost := 1;
            end if;

            Matrix (I, J) :=
              Min
                (Matrix (I - 1, J) + 1,
                 Matrix (I, J - 1) + 1,
                 Matrix (I - 1, J - 1) + Cost);
         end loop;
      end loop;

      return Matrix (M, N);
   end Levenshtein_Distance;

begin
   for I in 1 .. Argument_Count loop
      for J in 1 .. Argument_Count loop

         if I /= J then
            Distance := Levenshtein_Distance (Argument (I), Argument (J));

            if (Min_Distance = -1) or (Min_Distance > Distance) then
               Min_Distance := Distance;
            end if;
            Times := Times + 1;
         end if;

      end loop;
   end loop;

   Put ("times: ");
   Put (Item => Times, Width => 1);
   New_Line;
   Put ("min_distance: ");
   Put (Item => Min_Distance, Width => 1);
   New_Line;

end Code;
