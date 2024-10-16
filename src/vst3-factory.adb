with Ada.Unchecked_Conversion;
with System.Atomic_Counters; use System.Atomic_Counters;
with Vst3.Plugin; use Vst3.Plugin;
with Vst3.Component; use Vst3.Component;
with Vst3.Constants; use Vst3.Constants;

package body Vst3.Factory is 

   function Init (Cid : TUID; Cardinality : Int; Category : String; Name : String) return Class_Info is
      Info : constant Class_Info := (
         Cid => Cid,
         Cardinality => Cardinality,
         Name => To_C (Name),
         Category => To_C (Category));
   begin
      return Info;
   end Init;

   function Init (
      Cid            : TUID;
      Cardinality    : Int;
      Category       : String;
      Name           : String;
      Class_Flags    : Unsigned;  
      Sub_Categories : String;
      Vendor         : String;  
      Version        : String;  
      Sdk_Version    : String 
   ) return Class_Info_2 is
      Info_2 : constant Class_Info_2 := (
         Cid => Cid,
         Cardinality => Cardinality,
         Category => To_C (Category),
         Name => To_C (Name),
         Class_Flags => Class_Flags,
         Sub_Categories => To_C (Sub_Categories),
         Vendor => To_C (Vendor),
         Version => To_C (Version),
         Sdk_Version => To_C (Sdk_Version));
   begin
      return Info_2;
   end Init;

   function Add_Ref (This : access Vst3_Factory) return Unsigned is 
   begin
      Vst3_Log("Called Vst3.Factory.Add_Ref");
      Increment (This.Ref_Count);
      return Unsigned(This.Ref_Count);
   end Add_Ref;

   function Release (This : access Vst3_Factory) return Unsigned is 
   begin
      Vst3_Log("Called Vst3.Factory.Release");
      Decrement (This.Ref_Count);
      return Unsigned(This.Ref_Count);
   end Release;

   function Query_Interface (This : access Vst3_Factory; iid : TUID; obj : access Address) return Result is
   begin
      Vst3_Log("Called Vst3.Factory.Query_Interface");
      if iid = Plugin_Factory_3_Id or
         iid = Plugin_Factory_2_Id or
         iid = Plugin_Factory_Id   or 
         iid = Unknown_Id          then
         obj.all := This.all'Address;
         return Ok_True;
      end if;

      return No_Interface;
   end Query_Interface;

   function Count_Classes (This : access Vst3_Factory) return Int is
   begin
      Vst3_Log("Called Vst3.Factory.Count_Classes");
      return 1;
   end Count_Classes;

   function Get_Factory_Info (This : access Vst3_Factory;
                              Info : access Factory_Info) return Result is
      Flags : Unsigned_32 := Shift_Right(1, 4);
      Default_Factory_Flags : Int := Int(Flags);
      Info_To_Copy : constant Factory_Info := (To_C("the bois"), To_C("www.google.com"), To_C("edgallyot@gmail.com"), Default_Factory_Flags);
   begin
      Vst3_Log("Called Vst3.Factory.Get_Factory_Info");
      Info.all := Info_To_Copy;
      return Ok_True;
   end Get_Factory_Info;

   function Get_Class_Info (This : access Vst3_Factory; Index : Int; Info: access Class_Info) return Result is
      Class_Id : constant TUID := Make_TUID(1, 0, 0, 0);
      Info_To_Copy : constant Class_Info := Init(Class_Id, Cardinality_Many_Instances, "Audio Module Class", "Sami");
   begin
      Vst3_Log("Called Vst3.Factory.Get_Class_Info");
      Info.all := Info_To_Copy;
      return Ok_True;
   end Get_Class_Info;


   function Create_Instance (This : access Vst3_Factory; Class_Id : TUID; Interface_Id : TUID; Obj : access Address) return Result is 
      Class_TUID : constant TUID := Make_TUID(1, 0, 0, 0);
      Instance : access Vst3_Plugin;
      Ignore : Unsigned;
   begin
      Vst3_Log("Called Vst3.Factory.Create_Instance");
      if Class_Id = Class_TUID 
      then 
         if Interface_Id = Unknown_Id or Interface_Id = Vst3.Component.Component_Id 
         then
            Instance := new Vst3_Plugin;
            Ignore   := Add_Ref (Instance.Component'Access);
            Obj.all  := Instance.Component'Address;
            return Ok_True;
         end if; 
      end if;
      return No_Interface;
   end Create_Instance;

   function Get_Class_Info_2 (This : access Vst3_Factory; Index : Int; Info : access Class_Info_2) return Result is
      Cid : constant TUID := Make_TUID(1, 0, 0, 0);
      Component_Simple_Mode_Supported : constant Unsigned_32 := Shift_Right(1, 1);
      function To_Unsigned is new Ada.Unchecked_Conversion(Unsigned_32, Unsigned);
      Info_To_Copy : constant Class_Info_2 := Init(
         Cid,
         Cardinality_Many_Instances,
         "Audio Module Class",
         "Sami",
         To_Unsigned(Component_Simple_Mode_Supported),
         "Fx",
         "The bois",
         "0.0.1",
         "VST 3.7.9"
      );
   begin
      Vst3_Log("Called Vst3.Factory.Get_Class_Info_2");
      Info.all := Info_To_Copy; 
      return Ok_True;
   end Get_Class_Info_2;

   function Get_Class_Info_W (This : access Vst3_Factory; Index : Int; Info : access Class_Info_W) return Result is
   begin
      Vst3_Log("Called Vst3.Factory.Get_Class_Info_W");
      -- TODO(edg): We should implement this. Right now it's easier to ignore it to get things up and running.
      return Not_Implemented;
   end Get_Class_Info_W;

   function Set_Host_Context (This : access Vst3_Factory; Context : access F_Unknown) return Result is
   begin
      Vst3_Log("Called Vst3.Factory.Set_Host_Context");
      -- NOTE(edg): Unused
      return Ok_True;
   end Set_Host_Context;

end Vst3.Factory;

