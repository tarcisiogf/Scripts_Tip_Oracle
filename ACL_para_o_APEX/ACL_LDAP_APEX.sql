    -- Criando ACL para permitir a autenticação do Apex com o Active Directory da Microsoft 


   --1. Create ACL, add privileges and assign the ACL with ports. Principal, Is_Grant and Privileges are mandadory
   EXEC Dbms_Network_Acl_Admin.Create_Acl (Acl => 'ldap.xml', Description => 'Allow LDAP', Principal => 'PUBLIC', Is_Grant => TRUE, Privilege => 'connect');
   EXEC Dbms_Network_Acl_Admin.Create_Acl (Acl => 'ldap.xml', Description => 'Allow LDAP', Principal => 'PUBLIC', Is_Grant => TRUE, Privilege => 'resolve');
   COMMIT;   

   -- 2. Create Privileges 
   EXEC Dbms_Network_Acl_Admin.Add_Privilege    (Acl => 'ldap.xml', Principal => 'PUBLIC', Is_Grant => TRUE, Privilege => 'connect');
   EXEC Dbms_Network_Acl_Admin.Add_Privilege    (Acl => 'ldap.xml', Principal => 'PUBLIC', Is_Grant => TRUE, Privilege => 'resolve');

   -- 3 Assign_Acl    
   EXEC Dbms_Network_Acl_Admin.Assign_Acl (Acl => 'ldap.xml', Host => 'SEU_IP');
   EXEC Dbms_Network_Acl_Admin.Assign_Acl (Acl => 'ldap.xml', Host => 'SEU_SERVIDOR');   
   COMMIT;
   
   -- 4. Check acls and privs   
   Select * From Dba_Network_Acls where acl LIKE '%ldap%' ;
   Select * From Dba_Network_Acl_Privileges  where acl LIKE '%ldap%';
   select * from xdb.resource_view  where upper( any_path) LIKE upper( '%acls/%ldap%') order by  2;
   
  -- 5. Delete ACL / Privs / Unassign
  /*
   Exec Dbms_Network_Acl_Admin.Unassign_Acl (Host => 'SEU_IP');                   commit;
   Exec Dbms_Network_Acl_Admin.Unassign_Acl (Host => 'SEU_SERVIDOR');     commit;
   Exec Dbms_Network_Acl_Admin.Delete_Privilege (Acl => 'ldap.xml', Principal => 'PUBLIC', Is_Grant => TRUE, Privilege => 'resolve'); commit;
   Exec Dbms_Network_Acl_Admin.Delete_Privilege (Acl => 'ldap.xml', Principal => 'PUBLIC', Is_Grant => TRUE, Privilege => 'connect'); commit;   
   -- Delete Geral
   Exec DBMS_NETWORK_ACL_ADMIN.drop_acl ( acl =>'ldap.xml');   COMMIT;
   */

