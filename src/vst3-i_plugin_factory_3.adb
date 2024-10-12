with Vst3.I_Plugin_Factory_3;
with System.Address_To_Access_Conversions;

package body Vst3.I_Plugin_Factory_3 is 

   function Make_Factory_Info (Vendor : String; Url : String; Email : String; Flags : Int) return P_Factory_Info is 
      Info : P_Factory_Info := (Flags => Flags, Vendor => (others => nul), Email => (others => nul), Url => (others => nul));
   begin
      for I in Vendor'Range loop Info.Vendor (I) := To_C (Vendor (I)); end loop;
      for I in Email'Range loop Info.Email (I) := To_C (Email (I)); end loop;
      for I in Url'Range loop Info.Url (I) := To_C (Url (I)); end loop;
      return Info;
   end Make_Factory_Info;

   function Make_Class_Info (Cid : String; Cardinality : Int; Category : String; Name : String) return P_Class_Info is
      Info : P_Class_Info := (Cid => (others => nul), Cardinality => Cardinality, Name => (others => nul), Category => (others => nul));
   begin
      for I in Cid'Range loop Info.Cid (I) := To_C (Cid (I)); end loop;
      for I in Category'Range loop Info.Category (I) := To_C (Category (I)); end loop;
      for I in Name'Range loop Info.Name (I) := To_C (Name (I)); end loop;
      return Info;
   end Make_Class_Info;

   function Add_Ref (This : access I_Plugin_Factory_3) return Unsigned is 
   begin
      Put_Line("Add Ref");
      This.Ref_Count := This.Ref_Count + 1;
      return 0;
   end Add_Ref;

   function Release (This : access I_Plugin_Factory_3) return Unsigned is 
   begin
      Put_Line("Release");
      This.Ref_Count := This.Ref_Count - 1;
      return 0;
   end Release;

   function Query_Interface (This : access I_Plugin_Factory_3; iid : TUID; obj  : access Address) return Result is
   begin
      Put_Line("Query Interface");

      if iid = I_Plugin_Factory_3_IID or
         iid = I_Plugin_Factory_2_IID or
         iid = I_Plugin_Factory_IID   then
         obj.all := This.all'Address;
         return Ok_True;
      end if;

      return No_Interface;
   end Query_Interface;

   function Count_Classes (This : access I_Plugin_Factory_3) return Int is
   begin
      Put_Line("Count Classes");
      return 1;
   end Count_Classes;

   function Get_Factory_Info (This : access I_Plugin_Factory_3;
                              Info : access P_Factory_Info) return Result is
   begin
      Info.all := Make_Factory_Info ("the bois", "www.google.com","edgallyot@gmail.com", 0);
      return Ok_True;
   end Get_Factory_Info;

   function Get_Class_Info (This : access I_Plugin_Factory_3; Index : Int; Info: access P_Class_Info) return Result is
   begin
      Info.all := Make_Class_Info("Alright boizy", 0, "Audio Module Class", "Sami");
      return Ok_True;
   end Get_Class_Info;

   function Create_Instance (This : access I_Plugin_Factory_3; Cid : C_String; Iid : C_String; Obj : Address) return Result is 
   begin
      Put_Line("Create Instance");
      return Ok_True;
   end Create_Instance;

   function Get_Class_Info_2 (This : access I_Plugin_Factory_3; Index : Int; Info : access P_Class_Info_2) return Result is
   begin
      Put_Line("Get Class Info 2");
      return Ok_True;
   end Get_Class_Info_2;

   function Get_Class_Info_W (This : access I_Plugin_Factory_3; Index : Int; Info : access P_Class_Info_W) return Result is
   begin
      Put_Line("Get Class Info W");
      return Ok_True;
   end Get_Class_Info_W;

   function Set_Host_Context (This : access I_Plugin_Factory_3; Context : access F_Unknown) return Result is
   begin
      Put_Line("Set Host Context");
      return Ok_True;
   end Set_Host_Context;

end Vst3.I_Plugin_Factory_3;

