# encoding: UTF-8
newparam(:tablespace_type) do
  include EasyType
  
  newvalues(:bigfile, :smallfile)

  desc 'Use this set the default type created tablespaces including SYSTEM and SYSAUX tablespaces'
    
  to_translate_to_resource do | raw_resource|
  #  raw_resource.column_data('tablespace_type')
  end
  
  on_apply do | command_builder | 
    "SET DEFAULT #{value} TABLESPACE"
  end
  
end