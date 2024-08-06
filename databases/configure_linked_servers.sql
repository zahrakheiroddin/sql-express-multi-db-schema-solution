-- Configure linked server to Database2
EXEC sp_addlinkedserver 
   @server = 'Server2', 
   @srvproduct = '',
   @provider = 'SQLNCLI', 
   @datasrc = 'Server2\InstanceName';

EXEC sp_addlinkedsrvlogin 
   @rmtsrvname = 'Server2', 
   @locallogin = NULL, 
   @useself = 'False', 
   @rmtuser = 'remote_username', 
   @rmtpassword = 'remote_password';