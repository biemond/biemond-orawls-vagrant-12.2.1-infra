newproperty(:disks) do
  include EasyType
  include ::OraUtils::OracleAccess

  desc "The state of the diskgroup"

  to_translate_to_resource do | raw_resource|
    @group_number = raw_resource.column_data('GROUP_NUMBER')
    @sid = raw_resource.column_data('SID')
    oratab = OraUtils::OraTab.new
    sids = oratab.running_asm_sids
    @disks ||= sql_on( sids, 'select failgroup, group_number, path, name from v$asm_disk')
    Hash[failgroups.collect { |fg| [fg, disks_in_fg(fg)]}]
  end

  def self.failgroups
    @disks.collect do |entry|
      if current_diskgroup?(entry)
        entry['FAILGROUP']
      else
        nil
      end
    end.compact
  end

  def self.disks_in_fg(fg)
    @disks.reduce([]) do |value, disk|
      if disk['FAILGROUP'] == fg && current_diskgroup?(disk)
        value << {'diskname' => disk['NAME'], 'path' => disk['PATH']}
      end
      value
    end
  end

  def self.failgroup(raw)
    raw['FAILGROUP']
  end

  def self.current_diskgroup?(entry)
    entry['GROUP_NUMBER'] == @group_number && entry['SID'] == @sid
  end

end
