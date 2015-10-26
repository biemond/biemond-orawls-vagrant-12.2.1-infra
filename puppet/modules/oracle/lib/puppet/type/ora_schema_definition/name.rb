require 'orabase/utils/mungers'

newparam(:name) do
  include EasyType
  include EasyType::Validators::Name
  include OraUtils::Mungers::LeaveSidRestToUppercase
  desc "The schema name"

  isnamevar

end

