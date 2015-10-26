require 'pathname'
$:.unshift(Pathname.new(__FILE__).dirname.parent.parent)
$:.unshift(Pathname.new(__FILE__).dirname.parent.parent.parent.parent + 'easy_type' + 'lib')
require 'easy_type'
require 'orabase/utils/oracle_access'
require 'orabase/utils/title_parser'
require 'orabase/utils/commands'

module Puppet
  newtype(:ora_service) do
    include EasyType
    include ::OraUtils::OracleAccess
    extend ::OraUtils::TitleParser
    include ::OraUtils::Commands

    desc %q{
      This resource allows you to manage a service in an Oracle database.
      
       ora_service{'service_name':
        instances => [ 'inst1', 'inst2', 'inst3', .... ]
        }

      or for all instances

      ora_service{'service_name':
        instances => [ '*' ]
        }
    }

    ensurable

    set_command(:sql)


    to_get_raw_resources do
      sql_on_all_database_sids "select name, goal from dba_services"
    end

    on_create do | command_builder |
      if is_cluster? 
        create_cluster_service
      else
        create_service
      end
      nil
    end
    
    on_modify do | command_builder |
      fail "Not implemented yet."
    end

    on_destroy do | command_builder |
      disconnect_service
      if is_cluster?
        remove_cluster_service
      else
        remove_service
      end
      nil
    end

    map_title_to_sid(:service_name) { /^((@?.*?)?(\@.*?)?)$/}

    parameter :name
    parameter :service_name
    parameter :sid
    property  :instances
    parameter :prefered_instances

    #
    # This will be implemented later
    # TODO: Add the implementation for these options
    # property  :clb_goal
    # parameter :aq_ha_notifications
    # parameter :cardinality
    # parameter :dtp
    # parameter :failover_delay
    # parameter :failover_method
    # parameter :failover_retries
    # parameter :failover_type
    parameter :lb_advisory
    # parameter :management_policy
    # parameter :network_number
    # parameter :server_pool
    # parameter :service_role
    # parameter :taf_policy


    private

      def disconnect_service
        sql "exec dbms_service.disconnect_session('#{service_name}')", :sid => sid, :failonsqlfail => false, :parse => false
      end


      def delete_service
        sql "exec dbms_service.delete_service('#{service_name}')", :sid => sid, :failonsqlfail => false, :parse => false
      end

      def create_cluster_service
        switches = properties.collect do | property|
          property.on_apply(nil) if property.respond_to?('on_apply')
        end.compact!.join(' ')
        srvctl "add service -d #{dbname} -s #{service_name}  -r #{cluster_instances.join(',')} #{switches}", :sid => sid
        srvctl "start service -d #{dbname} -s #{service_name}", :sid => sid
      end

      def create_service
        new_services = current_services << service_name
        statement = set_services_command(new_services)
        sql statement, :sid => sid
      end


      def remove_service
        current_services.delete(service_name)
        statement = set_services_command(current_services)
        sql statement, :sid => sid
        sql "exec dbms_service.delete_service('#{service_name}')", :sid => sid, :failonsqlfail => false, :parse => false
      end

      def remove_cluster_service
        srvctl "stop service -d #{dbname} -s #{service_name}", :sid => sid
        sql "exec dbms_service.delete_service('#{service_name}')", :sid => sid, :failonsqlfail => false, :parse => false
        srvctl "remove service -d #{dbname} -s #{service_name} -i #{cluster_instances.join(',')}", :sid => sid
      end

      def is_cluster?
        sql('select parallel as par from v$instance', :sid => sid).first['PAR'] == 'YES'
      end

      def cluster_instances
        instances.nil? || instancles.count == 0 ?
          sql('select INSTANCE_NAME from gv$instance', :sid => sid).collect {|e| e['INSTANCE_NAME']} :
          instances          
      end

      def set_services_command(services)
        "alter system set service_names = '#{services.join('\',\'')}' scope=both"
      end

      def current_services
        @current_services ||= provider.class.instances.map(&:service_name).dup
      end

      def dbname
        sid.chop
      end

  end
end







