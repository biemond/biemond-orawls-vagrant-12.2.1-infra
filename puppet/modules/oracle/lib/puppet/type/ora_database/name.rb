require 'orabase/utils/mungers'

newparam(:name) do
  include EasyType
  include EasyType::Validators::Name

  desc "The database name"

  isnamevar

  to_translate_to_resource do | raw_resource|
    raw_resource.column_data('name')
  end

end

