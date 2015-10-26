newparam(:segment_space_management) do
  include EasyType

  desc "TODO: Give description"
  newvalues(:auto, :manual)

  to_translate_to_resource do | raw_resource|
    raw_resource.column_data('SEGMEN').downcase.to_sym
  end

  on_modify do | command_builder|
    command_builder.after "alter tablespace #{resource[:name]} segment space management #{value}", :sid => sid 
  end

end
