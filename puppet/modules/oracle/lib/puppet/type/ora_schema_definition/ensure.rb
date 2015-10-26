newproperty(:ensure) do
  include EasyType

  desc "version number or latest"

  newvalue(:absent) do
    @resource.provider.destroy
  end
  newvalue(:latest)
  newvalue(/^\d{1,3}.\d{1,3}.\d{1,3}$/) 
  aliasvalue(:present, :latest)

  defaultto(:latest)

  to_translate_to_resource do | raw_resource|
    raw_resource.column_data('VERSION')
  end

end
