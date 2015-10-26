newparam(:name) do
  include EasyType
  include EasyType::Validators::Name
  include EasyType::Mungers::String

  desc "ora_asm_volume's name"

  isnamevar

  to_translate_to_resource do | raw_resource|
    sid = raw_resource.column_data('SID')
    diskgroup   = raw_resource.column_data('DISKGROUP').upcase
    volume_name = raw_resource.column_data('VOLUME_NAME').upcase
    "#{diskgroup}:#{volume_name}@#{sid}"
  end

end
