newproperty(:logging) do
  include EasyType

  desc "TODO: Add description"
  newvalues(:yes, :no)


  to_translate_to_resource do | raw_resource|
    case raw_resource.column_data('LOGGING')
    when 'LOGGING' then :yes
    when 'NOLOGGING' then :no
    else
      fail('Invalid Logging found in tablespace resource.')
    end
  end

  on_modify do | command_builder|
    logging = (resource[:logging] == :yes) ? "logging" : "nologging"
    command_builder.after "alter tablespace #{resource[:tablespace_name]} #{logging}", :sid => sid 
  end

  on_create do | command_builder|
    if resource[:logging] == :yes
      "logging"
    else
      "nologging"
    end
  end

end

