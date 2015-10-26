# encoding: UTF-8
newparam(:character_set) do
  include EasyType

  desc 'Specify the character set the database uses to store data. '

  to_translate_to_resource do | raw_resource|
    # raw_resource.column_data('character_set')
  end

  on_apply do | command_builder | 
    "character set #{value}"
  end

end
