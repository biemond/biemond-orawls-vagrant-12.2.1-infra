# encoding: UTF-8
newparam(:spfile_location) do
  include EasyType

  desc <<-EOD
  Location of the database's spfile. If you specify this paramater, a spfile will be 
  created at the specified location. If you don't specify this parameter **no** spfile
  will be created.

  You can use this parameter like this:

  ora_database{'db1':
    ...
    spfile_location => '/opt/oracle/...../dbs/',
  }

  or

  ora_database{'db1':
    ...
    spfile_location => '+RECODG',
  }

  EOD

end
