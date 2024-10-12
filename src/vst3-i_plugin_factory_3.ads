
package Vst3.I_Plugin_Factory_3 is 
   type I_Plugin_Factory_3;

   I_Plugin_Factory_3_IID : constant TUID := Make_TUID (16#4555A2AB#, 16#C1234E57#, 16#9B122910#, 16#36878931#);
   I_Plugin_Factory_2_IID : constant TUID := Make_TUID (16#0007B650#, 16#F24B4C0B#, 16#A464EDB9#, 16#F00B2ABB#);
   I_Plugin_Factory_IID   : constant TUID := Make_TUID (16#7A4D811C#, 16#52114A1F#, 16#AED9D2EE#, 16#0B43BF9F#);
   F_Unknown_IID          : constant TUID := Make_TUID (16#00000000#, 16#00000000#, 16#C0000000#, 16#00000046#);

   type P_Factory_Info_Vendor is array (1 .. 64) of aliased char;
   type P_Factory_Info_Url is array (1 .. 256) of aliased char;
   type P_Factory_Info_Email is array (1 .. 128) of aliased char;
   type P_Factory_Info is record
      Vendor   : aliased P_Factory_Info_Vendor;
      Url      : aliased P_Factory_Info_Url;
      Email    : aliased P_Factory_Info_Email; 
      Flags    : aliased Int; 
   end record
   with Convention => C_Pass_By_Copy;

   function Make_Factory_Info (Vendor : String; Url : String; Email : String; Flags : Int) return P_Factory_Info;

   type P_Class_Info_Category is array (1 .. 32) of aliased char;
   type P_Class_Info_Name is array (1 .. 64) of aliased char;
   type P_Class_Info is record
      Cid         : aliased TUID := (others => nul);  
      Cardinality : aliased Int := 0;  
      Category    : aliased P_Class_Info_Category := (others => nul);  
      Name        : aliased P_Class_Info_Name := (others => nul);  
   end record
   with Convention => C_Pass_By_Copy;
   
   function Make_Class_Info (Cid : String; Cardinality : Int; Category : String; Name : String) return P_Class_Info;

   type P_Class_Info_2 is record
      Cid         : aliased TUID := (others => nul);  
      Cardinality : aliased Int := 0;  
      Category    : aliased P_Class_Info_Category := (others => nul);  
      Name        : aliased P_Class_Info_Name := (others => nul);  
   end record
   with Convention => C_Pass_By_Copy;

   type P_Class_Info_W is record
      Cid         : aliased TUID := (others => nul);  
      Cardinality : aliased Int := 0;  
      Category    : aliased P_Class_Info_Category := (others => nul);  
      Name        : aliased P_Class_Info_Name := (others => nul);  
   end record
   with Convention => C_Pass_By_Copy;

   function Add_Ref (this : access I_Plugin_Factory_3)
      return Unsigned
      with Convention => C;

   function Release (this : access I_Plugin_Factory_3) 
      return Unsigned
      with Convention => C;

   function Query_Interface (This : access I_Plugin_Factory_3; Iid : TUID; Obj : access Address) 
      return Result
      with Convention => C;

   function Get_Factory_Info (This : access I_Plugin_Factory_3; Info : access P_Factory_Info)
      return Result
      with Convention => C;

   function Count_Classes (This : access I_Plugin_Factory_3)
      return Int
      with Convention => C;

   function Get_Class_Info (This : access I_Plugin_Factory_3; Index : Int; Info: access P_Class_Info)
      return Result
      with Convention => C;

   function Create_Instance (This : access I_Plugin_Factory_3; Cid : C_String; Iid : C_String; Obj : Address)
      return Result
      with Convention => C;

   function Get_Class_Info_2 (This : access I_Plugin_Factory_3; Index : Int; Info : access P_Class_Info_2) 
      return Result 
      with Convention => C;

   function Get_Class_Info_W (This : access I_Plugin_Factory_3; Index : Int; Info : access P_Class_Info_W) 
      return Result 
      with Convention => C;

   function Set_Host_Context (This : access I_Plugin_Factory_3; Context : access F_Unknown) 
      return Result 
      with Convention => C;

   type I_Plugin_Factory_3_V_Table is record
      Query_Interface   : access function (This : access I_Plugin_Factory_3; Iid : TUID; Obj : access Address) return Result with Convention => C;
      Add_Ref           : access function (This : access I_Plugin_Factory_3) return Unsigned with Convention => C;
      Release           : access function (This : access I_Plugin_Factory_3) return Unsigned with Convention => C;
      Get_Factory_Info  : access function (This : access I_Plugin_Factory_3; Info : access P_Factory_Info) return Result with Convention => C;
      Count_Classes     : access function (This : access I_Plugin_Factory_3) return Int with Convention => C;
      Get_Class_Info    : access function (This : access I_Plugin_Factory_3; Index : Int; Info: access P_Class_Info) return Result with Convention => C;
      Create_Instance   : access function (This : access I_Plugin_Factory_3; Cid : C_String; Iid : C_String; Obj : Address) return Result with Convention => C;
      Get_Class_Info_2  : access function (This : access I_Plugin_Factory_3; Index : Int; Info : access P_Class_Info_2) return Result with Convention => C;
      Get_Class_Info_W  : access function (This : access I_Plugin_Factory_3; Index : Int; Info : access P_Class_Info_W) return Result with Convention => C;
      Set_Host_Context  : access function (This : access I_Plugin_Factory_3; Context : access F_Unknown) return Result with Convention => C;
   end record
   with Convention => C_Pass_By_Copy;

   type I_Plugin_Factory_3 is record
      V_Table: access I_Plugin_Factory_3_V_Table := new I_Plugin_Factory_3_V_Table'(
         Query_Interface => Query_Interface'Access,
         Release => Release'Access,
         Add_Ref => Add_Ref'Access,
         Get_Factory_Info => Get_Factory_Info'Access,
         Count_Classes => Count_Classes'Access,
         Get_Class_Info => Get_Class_Info'Access,
         Create_Instance => Create_Instance'Access,
         Get_Class_Info_2 => Get_Class_Info_2'Access,
         Get_Class_Info_W => Get_Class_Info_W'Access,
         Set_Host_Context => Set_Host_Context'Access
      );
      Ref_Count: F_Unknown_Ref_Count := 0;
   end record 
   with Convention => C_Pass_By_Copy;

end Vst3.I_Plugin_Factory_3;
