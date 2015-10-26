newproperty(:autoextend) do
  include EasyType

  desc "Enable autoextension for the tablespace"
  newvalues(:on, :off)
  aliasvalue(:yes, :on)
  aliasvalue(:no, :off)
  aliasvalue(true, :on)
  aliasvalue(false, :off)


  to_translate_to_resource do | raw_resource|
    case raw_resource.column_data('AUT')
    when 'YES' then :on
    when 'NO' then :off
    else
      fail('Invalid autoxtend found in tablespace resource.')
    end
  end

  on_modify do | command_builder|
    command_builder.add "alter database datafile '#{resource[:datafile]}' autoextend #{value}", :sid => sid 
    nil
  end

  on_create do | command_builder|
    "autoextend #{resource[:autoextend]}"
  end
end
