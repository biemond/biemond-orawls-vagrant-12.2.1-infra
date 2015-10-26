# encoding: UTF-8
newparam(:maxinstances) do
  include EasyType
  include EasyType::Validators::Integer
  
  desc 'The maximum number of instances that can simultaneously have this database mounted and open. '

  to_translate_to_resource do | raw_resource|
  #  raw_resource.column_data('maxinstances')
  end
  
  on_apply do | command_builder | 
    "MAXINSTANCES #{value}"
  end
  
end
