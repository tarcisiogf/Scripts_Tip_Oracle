Declare
  Retval       Boolean;
  P_Username   Varchar2 (32767);
  P_Password   Varchar2 (32767);
Begin
  P_Username := 'APXORCLACTACC';
  P_Password := 'senha9';

  Retval := Dba_Util.Ldap_Auth (P_Username, P_Password);

  :P_Username := P_Username;
  :P_Password := P_Password;

  Commit;
End;




CREATE OR REPLACE Function DBA_UTIL.Ldap_Auth (P_Username In Varchar2, P_Password In Varchar2)
  Return Boolean Is
  L_Ldap_Host   Varchar2 (256) := '10.120.100.210';
  L_Ldap_Port   Varchar2 (256) := '389';
  L_Ldap_Base   Varchar2 (256) := 'cn=%LDAP_USER%,apex oracle action account,ou=service_account,dc=in,dc=pge,dc=rj,dc=gov,dc=br';
  L_Dn_Prefix   Varchar2 (100) := 'IN\'; -- Amend as desired'.

  L_Retval      Pls_Integer;
  L_Session     Dbms_Ldap.Session;
Begin
  If P_Username Is Null Or P_Password Is Null Then
    Raise_Application_Error (-20000, 'Credentials must be specified.');
  End If;

  -- Choose to raise exceptions.
  Dbms_Ldap.Use_Exception := True;

  -- Connect to the LDAP server.
  L_Session := Dbms_Ldap.Init (Hostname => L_Ldap_Host, Portnum => L_Ldap_Port);

  L_Retval := Dbms_Ldap.Simple_Bind_S (Ld => L_Session, Dn => L_Dn_Prefix || P_Username, Passwd => P_Password);

  -- No exceptions mean you are authenticated.
  Return True;
Exception
  When Others Then
    -- Exception means authentication failed.
    L_Retval := Dbms_Ldap.Unbind_S (Ld => L_Session);
    Apex_Util.Set_Custom_Auth_Status (P_Status => 'Incorrect username and/or password');
    Return False;
End;
/