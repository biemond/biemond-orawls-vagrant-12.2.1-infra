# encoding: UTF-8
newparam(:logfile) do
  include EasyType
  
  desc 'The file to be used as redo log file.'
  
  to_translate_to_resource do | raw_resource|
  #  raw_resource.column_data('logfile')
  end
    
  on_apply do | command_builder | 
    "LOGFILE #{value}"
  end
  
end