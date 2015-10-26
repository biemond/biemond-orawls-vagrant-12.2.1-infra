require 'pathname'
$:.unshift(Pathname.new(__FILE__).dirname.parent.parent)
$:.unshift(Pathname.new(__FILE__).dirname.parent.parent.parent.parent + 'easy_type' + 'lib')
require 'easy_type'
require 'orabase/utils/oracle_access'
require 'orabase/utils/title_parser'


module Puppet
  newtype(:ora_record) do
    include EasyType
    include ::OraUtils::OracleAccess
    extend ::OraUtils::TitleParser

    desc %q[This resource allows you to manage a record in an Oracle database table.

        ora_record{'ARGOS_ABONNEMENT':
          table_name => 'ABONNEMENT',
          username   => 'CRIS',
          ensure     => present,
          password   => 'CRIS',
          key_name   => 'ABONNEMENTID',
          key_value  => '19',
          data       => {
              'AFNEMER'                     => 'ARGOS',
              'REISINFORMATIEPRODUCT'       => 'ARGOS',
              'LOCATIELANDELIJKINDICATOR'   => 'J',
              'LOCATIENIETINSTAPPEN'        => 0,
              'STATUS'                      => 0,
              'TIJDVENSTER'                 => 70,
              'LAATSTEVERWERKINGSTIJDSTIP'  => CURRENT_TIMESTAMP,
              'AANMELDTIJDSTIP'             => CURRENT_TIMESTAMP,
              'VERSTUURDEBERICHTEN'         => 0,
              'QUEUENAAM'                   => 'cris.pub2.jms.queue.output',
            }
        }

    ]

    set_command(:sql)

    to_get_raw_resources do
      sql_on_all_database_sids template('puppet:///modules/oracle/ora_tablespace/index.sql.erb', binding)
    end

    on_create do | command_builder |
      statement = "insert into #{table_name} ( #{key_name} ,#{columns}) values ( '#{key_value}', #{values})"
      command_builder.add(statement, :sid => sid, :username => username, :password => password)
    end

    on_modify do | command_builder |
      statement = "select * from #{table_name} where #{key_name} = '#{key_value}' for update\;\n"
      statement << "update #{table_name} set #{new_values} where #{key_name} = '#{key_value}'\;\n"
      statement << "commit\n"
      command_builder.add(statement, :sid => sid, :username => username, :password => password)
    end

    on_destroy do | command_builder |
      statement = "delete from #{table_name} where #{key_name} = '#{key_value}'"
      command_builder.add(statement, :sid => sid, :username => username, :password => password)
    end

    map_title_to_sid(:name) { /^((?:.*\/)?(@?.*?)?(\@.*?)?)$/}

    parameter :name
    parameter :username
    parameter :password
    parameter :table_name
    parameter :sid
    parameter :key_value
    parameter :key_name
    property  :data
    property  :ensure

    private

    def columns
      "#{data.keys.join(',')}"
    end

    def values
      data.values.collect{|v| "'#{v}'"}.join(',')
    end

    def new_values
      data.collect{|k,v| "#{k}='#{v}'"}.join(',')
    end

  end
end
