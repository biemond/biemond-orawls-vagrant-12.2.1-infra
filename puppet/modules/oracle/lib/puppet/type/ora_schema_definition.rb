require 'pathname'
$:.unshift(Pathname.new(__FILE__).dirname.parent.parent)
$:.unshift(Pathname.new(__FILE__).dirname.parent.parent.parent.parent + 'easy_type' + 'lib')
require 'easy_type'
require 'orabase/utils/oracle_access'
require 'orabase/utils/title_parser'
require 'orabase/utils/commands'
require 'puppet/type/ora_schema_definition/version'

module Puppet
  newtype(:ora_schema_definition) do
    include EasyType
    include ::OraUtils::OracleAccess
    extend ::OraUtils::TitleParser
    include ::OraUtils::Commands

    desc %q{
      This resource allows you to manage a schema definition. This includes all tables, indexes and other
      DDL that is needed for your application.
      
        app_schema_definition{'application_schema@DB1':
          ensure      => '3.3.1',
          source_path => '/staging/'

        }
    }

    set_command(:sql)

    on_create do | command_builder |
      provider.upgrade_to(self[:ensure])
      nil
    end
    
    on_modify do | command_builder |
      if ::Version.new(self[:ensure]) > provider.ensure
        provider.upgrade_to(self[:ensure])
      else
        provider.downgrade_to(self[:ensure])
      end
      nil
    end

    on_destroy do | command_builder |
      provider.class.destroy(self)
      nil
    end


    map_title_to_sid(:schema_name) { /^((@?.*?)?(\@.*?)?)$/}

    parameter :name
    parameter :schema_name
    parameter :sid
    parameter :source_path
    parameter :parameters
    parameter :password
    parameter :reinstall
    property  :ensure

  end
end







