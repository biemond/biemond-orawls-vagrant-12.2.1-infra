newproperty(:au_size) do
  include EasyType
  include EasyType::Mungers::Integer

  desc "The allocation unit size of the diskgroup in Mb"

  newvalues(1, 2, 4, 8, 16, 32, 64)

  to_translate_to_resource do | raw_resource|
    raw_resource.column_data('ALLOCATION_UNIT_SIZE').to_i/1024/1024
  end

end
