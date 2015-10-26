newproperty(:extent_management) do
  include EasyType

  desc "TODO: Give description"
  newvalues(:local, :dictionary)

  to_translate_to_resource do | raw_resource|
    raw_resource.column_data('EXTENT_MAN').downcase.to_sym
  end

  on_modify do | command_builder|
    Puppet.info 'extend_management can only be changed by migrating the tablespace'
  end

  on_create do | command_builder|
    "extent management #{resource[:extent_management]}"
  end

end
