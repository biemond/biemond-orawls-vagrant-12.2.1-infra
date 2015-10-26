require 'orabase/utils/mungers'

newparam(:schema_name) do
  include EasyType
  include EasyType::Validators::Name
  include EasyType::Mungers::Upcase

  isnamevar

  desc "The schema name"

  to_translate_to_resource do | raw_resource|
    raw_resource.column_data('APPLICATION').upcase
  end


end

