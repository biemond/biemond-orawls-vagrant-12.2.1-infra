require 'pathname'
$:.unshift(Pathname.new(__FILE__).dirname.parent.parent)
$:.unshift(Pathname.new(__FILE__).dirname.parent.parent.parent.parent + 'easy_type' + 'lib')
require 'easy_type'
require 'orabase/utils/oracle_access'
require 'orabase/utils/title_parser'


module Puppet
  newtype(:ora_tablespace) do
    include EasyType
    include ::OraUtils::OracleAccess
    extend ::OraUtils::TitleParser

    desc "This resource allows you to manage an Oracle tablespace."

    set_command(:sql)

    ensurable

    to_get_raw_resources do
      sql_on_all_database_sids template('puppet:///modules/oracle/ora_tablespace/index.sql.erb', binding)
    end

    on_create do | command_builder |
      base_command = "create #{ts_type} #{ts_contents} tablespace \"#{tablespace_name}\""
      base_command << " segment space management #{segment_space_management}" if segment_space_management
      base_command
      command_builder.add(base_command, :sid => sid)
    end

    on_modify do | command_builder |
      # Allow individual properties to do there stuff
    end

    on_destroy do | command_builder |
      command_builder.add("drop tablespace \"#{tablespace_name}\" including contents and datafiles", :sid => sid)
    end

    map_title_to_sid(:tablespace_name) { /^((?:.*\/)?(@?.*?)?(\@.*?)?)$/}

    parameter :name
    parameter :tablespace_name
    parameter :sid

    parameter :timeout
    property  :bigfile
    group(:autoextend_group) do
      parameter :datafile
      property  :size
      property  :autoextend
      property  :next
      property  :max_size
    end
    property  :extent_management
    property  :segment_space_management
    property  :logging
    property  :contents

    def ts_type
      (self['bigfile'] == :yes) ? 'bigfile' : ''
    end

    def ts_contents
      (self['contents'] != :permanent) ? self['contents'] : ''
    end


  end
end
