# encoding: UTF-8
newparam(:national_character_set) do
  include EasyType

  desc 'The national character set used to store data in columns'

  to_translate_to_resource do | raw_resource|
  #  raw_resource.column_data('national_character_set')
  end

  on_apply do | command_builder | 
    "NATIONAL CHARACTER SET #{value}"
  end
  
end