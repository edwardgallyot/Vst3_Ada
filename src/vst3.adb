with Ada.Text_IO; use Ada.Text_IO;
with Ada.Directories; use Ada.Directories;
with Interfaces; use Interfaces;
with Ada.Unchecked_Conversion;

package body Vst3 is 
   function To_C (Src: String) return C_String_32 is
      Res : C_String_32 := (others => nul);
   begin
      for I in Src'Range loop Res (I) := To_C (Src (I)); end loop;
      return Res;
   end To_C;

   function To_C (Src: String) return C_String_64 is
      Res : C_String_64 := (others => nul);
   begin
      for I in Src'Range loop Res (I) := To_C (Src (I)); end loop;
      return Res;
   end To_C;

   function To_C (Src: String) return C_String_128 is
      Res : C_String_128 := (others => nul);
   begin
      for I in Src'Range loop Res (I) := To_C (Src (I)); end loop;
      return Res;
   end To_C;

   function To_C (Src: String) return C_String_256 is
      Res : C_String_256 := (others => nul);
   begin
      for I in Src'Range loop Res (I) := To_C (Src (I)); end loop;
      return Res;
   end To_C;

   function Make_TUID (One: Unsigned_32; Two: Unsigned_32; Three: Unsigned_32; Four: Unsigned_32) return TUID is
      pragma Warnings (Off, "types for unchecked conversion have different sizes");
      function To_Char is new Ada.Unchecked_Conversion(Unsigned_32, char);
      pragma Warnings (On, "types for unchecked conversion have different sizes");
      Res : TUID;
   begin

      Res (1)  := To_Char(Shift_Right(One and 16#FF000000#, 24));
      Res (2)  := To_Char(Shift_Right(One and 16#00FF0000#, 16));
      Res (3)  := To_Char(Shift_Right(One and 16#0000FF00#, 8));
      Res (4)  := To_Char(Shift_Right(One and 16#000000FF#, 0));
               
      Res (5)  := To_Char(Shift_Right(Two and 16#FF000000#, 24));
      Res (6)  := To_Char(Shift_Right(Two and 16#00FF0000#, 16));
      Res (7)  := To_Char(Shift_Right(Two and 16#0000FF00#, 8));
      Res (8)  := To_Char(Shift_Right(Two and 16#000000FF#, 0));

      Res (9)  := To_Char(Shift_Right(Three and 16#FF000000#, 24));
      Res (10) := To_Char(Shift_Right(Three and 16#00FF0000#, 16));
      Res (11) := To_Char(Shift_Right(Three and 16#0000FF00#, 8));
      Res (12) := To_Char(Shift_Right(Three and 16#000000FF#, 0));

      Res (13) := To_Char(Shift_Right(Four and 16#FF000000#, 24));
      Res (14) := To_Char(Shift_Right(Four and 16#00FF0000#, 16));
      Res (15) := To_Char(Shift_Right(Four and 16#0000FF00#, 8));
      Res (16) := To_Char(Shift_Right(Four and 16#000000FF#, 0));

      return Res;
   end Make_TUID;
end Vst3;
