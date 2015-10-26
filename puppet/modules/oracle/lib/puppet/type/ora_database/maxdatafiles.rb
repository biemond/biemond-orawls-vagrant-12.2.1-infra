# encoding: UTF-8
newparam(:maxdatafiles) do
  include EasyType
  include EasyType::Validators::Integer
  
  desc 'The initial sizing of the datafiles section of the control file. '

  to_translate_to_resource do | raw_resource|
  #  raw_resource.column_data('maxdatafiles')
  end
  
  on_apply do | command_builder | 
    "MAXDATAFILES #{value}"
  end
  
end
