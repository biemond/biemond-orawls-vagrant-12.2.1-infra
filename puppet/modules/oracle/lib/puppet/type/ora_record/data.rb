newproperty(:data) do
  include EasyType

  desc "The data in the row specified as an hash. "

  to_translate_to_resource do | raw_resource|
    data = raw_resource.dup
    data.delete('SID')
    data
  end


  #
  # because the order may differ, but they are still the same,
  # to decide if they are equal, first do a sort on is and should
  #
  def insync?(is)
    resource[:ensure] == :updated ? is == should : true
  end

  def validate(value)
    fail "Ora_record['#{resource[:name]}'] data keyword must be passed a Hash" unless value.is_a?(Hash)
    value.keys.each do | key|
      fail "Ora_record['#{resource[:name]}'] data keyword must be passed a Hash with string keys" unless key.is_a?(String)
    end
  end

  def change_to_s(from, to)
    difference = Hash[*((from.size > to.size)    \
      ? from.to_a - to.to_a \
      : to.to_a - from.to_a
    ).flatten] 
    difference.keys.collect{|k| "Changed: #{k} from #{from[k]} to #{to[k]}" }.join(',')
  end



end
