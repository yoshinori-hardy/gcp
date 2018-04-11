## Custom Security Roles

As custom role name can only be used once per project, they should be managed and 
maintained independantly of the Server and Network infrastructure.  If they were 
re-created with random names at each infra build we would not be able to use human
readable names.  This also provides the security team a single place to manage custom
security roles.  These roles should be created immediately after the project and 
prior to running the remaining infrastructure build.
