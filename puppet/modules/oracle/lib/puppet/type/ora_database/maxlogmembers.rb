# encoding: UTF-8
newparam(:maxlogmembers) do
  include EasyType
  include EasyType::Validators::Integer
  
  desc 'The maximum number of members, or copies, for a redo log file group'

  to_translate_to_resource do | raw_resource|
  #  raw_resource.column_data('maxlogmembers')
  end

  on_apply do | command_builder | 
    "MAXLOGMEMBERS #{value}"
  end
  
end