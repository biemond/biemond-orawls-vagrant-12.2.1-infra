# encoding: UTF-8
newparam(:control_file) do
  include EasyType
  desc 'Specify reuse, to reuse existing control files'

  newvalues(:reuse)  

  to_translate_to_resource do | raw_resource|
    # raw_resource.column_data('control_file')
  end

  on_apply do | command_builder | 
    "CONTROLFILE #{value}"
  end
  
end