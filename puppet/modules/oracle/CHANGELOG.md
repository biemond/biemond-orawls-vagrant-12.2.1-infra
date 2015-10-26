History
========

26-08-2015  version 1.7.19
--------------------------
- timeout parameter was not honoured. Now fixed

26-08-2015  version 1.7.18
--------------------------
- Fix undefined method sort for ora_init_param

25-08-2015  version 1.7.17
--------------------------
- Fix null quota's for ora_user.
- Fix idempotence for autoextend and maxsize

10-08-2015  version 1.7.16
--------------------------
- Added support for multiple values in ota_init_parameter

10-08-2015  version 1.7.15
--------------------------
- Allow letters in versionnumber of ora_racord upgrade and downgrade scripts

16-07-2015  version 1.7.14
--------------------------
- Set ownership for some more directories when creating a database

06-07-2015  version 1.7.13
--------------------------
- refreshonly on ora_exec now only logs a message when something is done.

06-07-2015  version 1.7.12
--------------------------
- Fix dropping triggers when reinstalling schema

01-07-2015  version 1.7.11
--------------------------
- Use instance name instead of database name for orapwd name.

19-06-2015  version 1.7.10
--------------------------
- only use lb_advisory on RAC clusters

17-06-2015  version 1.7.9
--------------------------
- added lb_advisory property to ora_service

17-06-2015  version 1.7.8
--------------------------
- Added refreshonly for ora_exec
- Check if the cwd specified for ora_exec is valid

09-06-2015  version 1.7.7
--------------------------
- Add support for timezone parameter on Ora_database

04-06-2015  version 1.7.6
--------------------------
- Small fixes in ora_schema_definition

02-06-2015  version 1.7.5
--------------------------
- Better cleanup of schema_definition
- Translate latest version to real number

02-06-2015  version 1.7.4
--------------------------
- Better logging of script that are running
- Ignore characters in versions of upgrade and downgrade scripts


27-05-2015  version 1.7.3
--------------------------
- Small fix for ora_schema_defintion removing occasional error's

22-05-2015  version 1.7.2
--------------------------
- Better error checking on data attribute of ora_schema_defintion 


21-05-2015  version 1.7.1
--------------------------
- Small fixes to ora_schema_definition and ora_record. 

20-05-2015  version 1.7.0
--------------------------
- Added ora_schema_definition type. This type helps in managing the table defintions of your applications
- Added ora_record. This type supports manageing configuration records in database

13-05-2015  version 1.6.6
--------------------------
- Fixed creating a tablespace when no datafile is specfied

24-04-2015  version 1.6.5
--------------------------
- Fixed changing tablespaces
- Added support for Puppet 4

08-04-2015  version 1.6.4
--------------------------
- Now realy works on RAC...

04-04-2015  version 1.6.3
--------------------------
- ora_service now works on RAC systems
- ora_service noew presists the services on non RAC systems 


23-03-2015  version 1.6.2
--------------------------
- Quick bugfix

23-03-2015  version 1.6.1
--------------------------
- Small fix for `ora_exec` when `unless` is specfied without a username


23-03-2015  version 1.6.0
--------------------------
- Removed the oracle daemon. Totaly. This makes the code easier to read.
- some small changes in `ora_database` for RAC support.
- improved error handling of sql code. This may lead to error's not seen before.
- Support for multiple disks in ora_asm_diskgroups.

04-03-2015  version 1.5.4
--------------------------
- Fixed spfile creation on RAC nodes
- Made direct sql the default for sql commands. This is the first step in removing the daemon.

07-02-2015  version 1.5.3
--------------------------
- Allow `ora_init_param` to manage ASM instances

03-02-2015  version 1.5.2
--------------------------
- Added the `unless` parameter to `ora_exec`

30-01-2015  version 1.5.1
--------------------------
- ora_tablespace max_size property now supports value unlimited

29-01-2015  version 1.5.0
--------------------------
- Support for asm_volumes
- Added a fact to get asm volume information (With help from Corey Osman)
- Fixed ora_asm_diskgroup attribute au_size


19-01-2015  version 1.4.0
--------------------------
- Add grant privileges function to ora_role (Thanks to Edward Groenenberg)
- Now works on Oracle XE (Thanks to Andreas Wegmann)
- ora_database can now remove clustered databases

12-01-2015  version 1.3.0
--------------------------
- Re-enginered the ora_database
- make the fact use of os_user work for both Oracle and ASM

07-01-2015  version 1.2.0
--------------------------
- Added the initial implementation of ora_database
- Add functionality to use a fact to specify os_user for oracle and asm. Fixes #36


07-01-2015  version 1.1.0
--------------------------
- Cleaned up contents of distributed package
- autorequire the oracle users tablespace
- Some fixes and clarifications for ora_asm_diskgroup. BEWARE: The api has changed. Check the README for details.
- Added support for oratab on Solaris.


16-12-2014  version 1.0.0
--------------------------
- Fixed some bugs

27-11-2014  version 0.7.0
--------------------------
-Big API change. Change all type names to ora_..
- Have the sid at with @ at the back instead with a slach at the front. eg. it used to be SID/HAJEE. Now it is HAJEE@SID


27-11-2014  version 0.6.0
--------------------------
- init params now works with a different syntax for specifying the name. Check the readme for details
- Added support for 'growing' small file tablespaces. the type doesn't try to downscale a grown tablespace
- Added support for running under a different os_user.


07-10-2014  version 0.5.0
--------------------------
- Added custom type asm_diskgroup. This group supports creating and removing ASM disk groups. 
Parts of it are writen by Remy van Berkum (remy.vanberkum@vermont24-7.com). Also added support
for connecting to the ASM instances with the sysasm user


24-09-2014  version 0.4.0
--------------------------
- Added some types needed for Oracle RAC


08-09-2014  version 0.3.1
--------------------------
- defaults SID's now work for all types. 
- Changed documentation to show use with SID

08-09-2014  version 0.3.0
--------------------------
- Added support for multiple SID's. 
- The listener now needs a sid as title. This is potential incompatible with previous versions where the name could be anything. 
- Added support for specifying the SID for init_param

Before this, history not really recorded. Look at git history for details