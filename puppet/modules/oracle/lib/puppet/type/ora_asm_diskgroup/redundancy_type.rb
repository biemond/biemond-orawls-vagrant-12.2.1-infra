newproperty(:redundancy_type) do
  include EasyType
  include EasyType::Validators::Name
  include EasyType::Mungers::Upcase

  desc "The redundancy type of the diskgroup"

  newvalues('HIGH', 'EXTERNAL', 'NORMAL')
 
  to_translate_to_resource do | raw_resource|
    type = raw_resource.column_data('TYPE').upcase
    case type
    when 'EXTERN' then 'EXTERNAL'
    else type
    end
  end

end
