# encoding: UTF-8
newparam(:maxlogfiles) do
  include EasyType
  include EasyType::Validators::Integer
  
  desc 'define the limits for the redo log. '

  to_translate_to_resource do | raw_resource|
  #  raw_resource.column_data('maxlogfiles')
  end
  
  on_apply do | command_builder | 
    "MAXLOGFILES #{value}"
  end
  
end
