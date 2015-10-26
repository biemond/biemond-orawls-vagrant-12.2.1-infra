# encoding: UTF-8
newparam(:sys_password) do
  include EasyType
  desc 'The password of ythe SYS account'

  to_translate_to_resource do | raw_resource|
  #  raw_resource.column_data('sys_password')
  end

  on_apply do | command_builder|
    "user sys identified by #{value}"
  end
  
end