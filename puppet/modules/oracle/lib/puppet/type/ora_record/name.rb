newparam(:name) do
  include EasyType
  include EasyType::Validators::Name
  desc "The table name"

  isnamevar

end

