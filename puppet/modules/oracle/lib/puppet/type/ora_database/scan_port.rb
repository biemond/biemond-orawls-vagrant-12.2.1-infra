# encoding: UTF-8
newparam(:scan_port) do
  include EasyType
  include EasyType::Validators::Integer

  defaultto(1521)

  desc <<-EOD
  The scan port number for a RAC cluster. This parameter is only used when you are creating
  a RAC database by specicying the instances parameter. Here is an example:

    ora_database{'db':
      ...
      instances   => {'db1' => 'node1', 'db2' => 'node2'},
      scan_name   => 'scan',
      scan_port   => '1521',
    }

  EOD

end

