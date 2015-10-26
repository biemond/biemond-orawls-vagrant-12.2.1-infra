$:.unshift(Pathname.new(__FILE__).parent.parent.parent.parent + 'easy_type/lib')
$:.unshift(Pathname.new(__FILE__).parent.parent)
require 'facter'
require 'puppet'
begin
  require 'puppet/type/ora_asm_diskgroup'
  require 'puppet/type/ora_asm_volume'
rescue

end

Facter.add("ora_asm_diskgroups") do
  setcode do
    begin
    ::Resources::OraAsmDiskgroup.index
    rescue
      # Rescue all error's. We don't want errors during facts
      nil
    end
  end
end

Facter.add("ora_asm_volumes") do
  setcode do
    begin
    ::Resources::OraAsmVolume.index
    rescue
    # Rescue all error's. We don't want errors during facts
    nil
    end
  end
end

