require 'pathname'
$:.unshift(Pathname.new(__FILE__).dirname.parent.parent)
$:.unshift(Pathname.new(__FILE__).dirname.parent.parent.parent.parent + 'easy_type' + 'lib')
require 'easy_type'
require 'orabase/utils/oracle_access'
require 'orabase/utils/title_parser'
require 'orabase/utils/ora_tab'
require 'orabase/resources/ora_asm_diskgroup'

module Puppet
  #
  # Create a new type oracle_user. Oracle user, works in conjunction 
  # with the SqlResource provider
  #
  newtype(:ora_asm_diskgroup) do
    include EasyType
    include ::OraUtils::OracleAccess
    extend ::OraUtils::TitleParser

    desc %q{
      This resource allows you to manage a user in an Oracle database.
    }

    ensurable

    set_command(:sql)

    to_get_raw_resources do
      ::Resources::OraAsmDiskgroup.raw_resources
    end

    on_create do | command_builder |
      statement = template('puppet:///modules/oracle/ora_asm_diskgroup/create.sql.erb', binding)
      command_builder.add(statement, :sid => sid)
    end

    on_modify do | command_builder |
      Puppet.info "No disk groups modified. Function not implemented yet."
      nil
    end

    on_destroy do | command_builder |
      statement = template('puppet:///modules/oracle/ora_asm_diskgroup/destroy.sql.erb', binding)
      command_builder.add(statement, :sid => sid)
    end


    map_title_to_asm_sid(:groupname) { /^((@?.*?)?(\@.*?)?)$/}

    parameter :name
    parameter :groupname
    parameter :asm_sid      # The included file is asm_sid, but the parameter is named sid

    parameter :diskgroup_state
    property  :redundancy_type
    property  :au_size
    property  :compat_asm
    property  :compat_rdbms
    property  :disks

  end
end
