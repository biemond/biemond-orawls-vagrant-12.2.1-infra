# encoding: UTF-8
newparam(:oracle_user) do
  include EasyType

  defaultto 'oracle'
  
  desc 'The oracle user'

end