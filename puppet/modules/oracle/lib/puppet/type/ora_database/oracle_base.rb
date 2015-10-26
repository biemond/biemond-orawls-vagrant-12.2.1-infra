# encoding: UTF-8
newparam(:oracle_base) do
  include EasyType

  defaultto '/opt/oracle'
  
  desc 'The oracle_base directory'

end