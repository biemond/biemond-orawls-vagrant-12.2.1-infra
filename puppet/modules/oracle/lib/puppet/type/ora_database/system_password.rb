# encoding: UTF-8
newparam(:system_password) do
  include EasyType
  desc 'The password of ythe SYSTEM account'

  to_translate_to_resource do | raw_resource|
  #  raw_resource.column_data('system_password')
  end

  on_apply do | command_builder|
    "user system identified by #{value}"
  end
  
end