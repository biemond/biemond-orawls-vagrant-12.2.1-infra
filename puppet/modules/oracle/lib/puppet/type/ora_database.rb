require 'pathname'
$:.unshift(Pathname.new(__FILE__).dirname.parent.parent)
$:.unshift(Pathname.new(__FILE__).dirname.parent.parent.parent.parent + 'easy_type' + 'lib')
require 'easy_type'
require 'orabase/utils/oracle_access'
require 'orabase/utils/commands'
require 'orabase/utils/ora_tab'
require 'orabase/utils/directories'

module Puppet
  newtype(:ora_database) do
    include EasyType
    include ::OraUtils::OracleAccess
    include ::OraUtils::Directories
    include ::OraUtils::Commands

    desc "This resource allows you to manage an Oracle Database."

    set_command([:sql, :remove_directories, :srvctl, :orapwd])

    ensurable

    on_create do | command_builder |
      begin
        @dbname = is_cluster? ? instance_name : name
        create_directories
        create_init_ora_file
        add_oratab_entry
        create_ora_pwd_file(command_builder)

        create_stage_1
        create_stage_2
        execute_stage_1( command_builder)
        execute_stage_2( command_builder)
        if is_cluster?
          register_database(command_builder)
          add_instances(command_builder)
          start_database(command_builder)
        end
        nil

      rescue => e
        remove_directories
        fail "Error creating database #{name}, #{e.message}"
        nil
      end
    end

    on_modify do | command_builder |
      info "database modification not yet implemented"
      nil
    end

    on_destroy do | command_builder |
      if is_cluster?
        remove_instance_registrations( command_builder)
        remove_database_registration( command_builder)
      end
      statement = template('puppet:///modules/oracle/ora_database/destroy.sql.erb', binding)
      command_builder.add(statement, :sid => name)
      command_builder.after('', :remove_directories)
    end

    parameter :name
    parameter :system_password
    parameter :sys_password
    parameter :init_ora_content
    parameter :timeout
    parameter :control_file
    parameter :maxdatafiles
    parameter :maxinstances
    parameter :character_set
    parameter :national_character_set
    parameter :tablespace_type
    parameter :logfile
    parameter :logfile_groups
    parameter :maxlogfiles
    parameter :maxlogmembers
    parameter :maxloghistory
    parameter :archivelog
    parameter :force_logging
    parameter :extent_management
    parameter :oracle_home
    parameter :oracle_base
    parameter :oracle_user
    parameter :install_group
    parameter :autostart
    parameter :default_tablespace
    parameter :datafiles
    parameter :default_temporary_tablespace
    parameter :undo_tablespace
    parameter :sysaux_datafiles
    parameter :spfile_location
    parameter :timezone
    parameter :config_scripts
  
    #
    # When defining a RAC database, these become valuable
    #
    parameter :instances
    parameter :scan_name
    parameter :scan_port
    # -- end of attributes -- Leave this comment if you want to use the scaffolder

    private


    def create_init_ora_file
      File.open(init_ora_file, 'w') do |file| 
        file.write(init_ora_content)
        if is_cluster?
          write_cluster_parameters(file)
        else
      	  file.write("#\n")
      	  file.write("# Parameters inserted by Puppet ora_database\n")
      	  file.write("#\n")
        end
      end      
      owned_by_oracle( init_ora_file)
      Puppet.debug "File #{init_ora_file} created with content"
    end

    def write_cluster_parameters(file)
      instance_names = instances.keys.sort    # sort the keys for ruby 1.8.7 Hash ordering
      instance_names.each_index do |index|
        instance = instance_names[index]
        instance_no = index + 1
        file.write("#\n")
        file.write("# Parameters inserted by Puppet ora_database (RAC)\n")
        file.write("#\n")
        file.write("#{instance}.instance_number=#{instance_no}\n")
        file.write("#{instance}.thread=#{instance_no}\n")
        file.write("#{instance}.undo_tablespace=UNDOTBS#{instance_no}\n")
      end
    end

    def add_oratab_entry
      oratab = OraUtils::OraTab.new
      oratab.ensure_entry(@dbname, oracle_home, autostart)
    end

    def create_ora_pwd_file(command_builder)
      command_builder.add("file=#{oracle_home}/dbs/orapw#{@dbname} force=y password=#{sys_password} entries=20", :orapwd, :sid => @dbname)
    end

    def create_stage_1
      content = template("puppet:///modules/oracle/ora_database/create.sql.erb", binding)
      path = "#{admin_scripts_path}/create.sql"
      File.open(path, 'w') { |f| f.write(content) }
      owned_by_oracle(path)
    end

    def create_stage_2
      with_config_scripts do | script, content|
        path = "#{admin_scripts_path}/#{script}.sql"
        File.open(path, 'w') { |f| f.write(content) }
        owned_by_oracle(path)
      end
    end

    def start_database(command_builder)
      # command_builder.add("stop database -d #{name}", :srvctl, :sid => @dbname)
      command_builder.add("start database -d #{name}", :srvctl, :sid => @dbname)
    end

    def register_database(command_builder)
      command = if spfile_location
        "add database -d #{name} -o #{oracle_home} -n #{name} -m #{name} -p #{spfile_location}/#{name}/spfile#{name}.ora "
      else
        "add database -d #{name} -o #{oracle_home} -n #{name} -m #{name} "
      end
      command_builder.add(command, :srvctl, :sid => @dbname)
    end

    def add_instances(command_builder)
      instances.each do | instance, node|
        command_builder.add("add instance -d #{name} -i #{instance} -n #{node}", :srvctl, :sid => @dbname)
      end
    end

    def disable_database(command_builder)
      command_builder.add("disable database -d #{name}", :srvctl, :sid => @dbname)
    end

    def remove_instance_registrations(command_builder)
      instances.each do | instance, node|
        command_builder.add("remove instance -d #{name} -i #{instance}", :srvctl, :sid => @dbname)
      end
    end

    def remove_database_registration(command_builder)
      command_builder.add("remove database -d #{name}", :srvctl, :sid => @dbname)
    end

    def execute_stage_1( command_builder)
      command_builder.add("@#{admin_scripts_path}/create", :sid => @dbname, :timeout => 0)
    end

    def execute_stage_2( command_builder)
      with_config_scripts do | script, _|
        command_builder.after("@#{admin_scripts_path}/#{script}", :sid => @dbname, :timeout => 0)
      end
    end

    def instance_name(entry=1)
      "#{name}#{entry}"
    end

    def is_cluster?
      instances.count > 0
    end

    def hostname
      Facter.value('hostname')
    end

    def init_ora_file
      "#{oracle_home}/dbs/init#{@dbname}.ora"
    end

    def admin_scripts_path
      "#{oracle_base}/admin/#{name}/scripts"
    end

    def with_config_scripts
      config_scripts.each do |entry|
        script = entry.keys.first
        content = entry[script]
        yield( script, content)
      end
    end

  end
end

