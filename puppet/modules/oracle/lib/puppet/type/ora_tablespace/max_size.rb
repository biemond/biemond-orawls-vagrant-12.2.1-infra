# TODO: Check values
newproperty(:max_size) do
  include EasyType

  desc "maximum size for autoextending"

  def munge(size)
    return size if size.is_a?(Numeric)
    case size
    when /^\d+(K|k)$/ then size.chop.to_i * 1024
    when /^\d+(M|m)$/ then size.chop.to_i * 1024 * 1024
    when /^\d+(G|g)$/ then size.chop.to_i * 1024 * 1024 * 1024
    when /^unlimited$/ then size = 'unlimited'
    when /^\d+$/ then size.to_i
    else
      fail('invalid size')
    end
  end


  # TODO: Check why it doesn't return the right values
  to_translate_to_resource do | raw_resource|
    raw_resource.column_data('MAX_SIZE').to_f.to_i
  end

  on_modify do | command_builder|
    if resource[:autoextend] == :on
      command_builder.add "alter database datafile '#{resource[:datafile]}' autoextend on maxsize #{value}", :sid => sid 
      nil
    else
      Puppet.warning "property maxsize changed on ora_tablespace[#{resource[:name]}], but autoextend is off. Change has no effect. "
      nil
    end
  end

  on_create do | command_builder|
    if resource[:autoextend] == :on
      "maxsize #{value}"
    else
      Puppet.warning "property maxsize changed on ora_tablespace[#{resource[:name]}], but autoextend is off. Change has no effect. "
      nil
    end
  end


end
