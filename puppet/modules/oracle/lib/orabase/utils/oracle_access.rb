require 'tempfile'
require 'fileutils'
require 'orabase/utils/sql'

module OraUtils
  module OracleAccess

    OS_USER_NAME = 'ASM_OS_USER'

    def self.included(parent)
      parent.extend(OracleAccess)
    end

    ##
    #
    # Use this function to execute Oracle statements on a set of specfied sids
    #
    # @param sids [Array] Array of SIDS
    # @param command [String] this is the commands to be given
    #
    #
    def sql_on( sids, command, parameters = {})
      results = []
      sids.each do |sid|
        results = results + sql(command, {:sid => sid}.merge(parameters))
      end
      results
    end

    ##
    #
    # Use this function to execute Oracle statements on all running databases.
    # This excludes asm database
    #
    # @param command [String] this is the commands to be given
    #
    #
    def sql_on_all_database_sids( command, parameters = {})
      oratab = OraTab.new
      sids = oratab.running_database_sids
      sql_on_sids(sids, command, parameters)
    end


    ##
    #
    # Use this function to execute Oracle statements on all running asm sids.
    #
    # @param command [String] this is the commands to be given
    #
    def sql_on_all_asm_sids( command, parameters = {})
      oratab = OraTab.new
      sids = oratab.running_asm_sids
      sql_on_sids(sids, command, parameters)
    end

    ##
    #
    # Use this function to execute Oracle statements on all running sid.
    # This includes asm database
    #
    # @param command [String] this is the commands to be given
    #
    #
    def sql_on_all_sids( command, parameters = {})
      oratab = OraTab.new
      oratab = OraTab.new
      sids = oratab.running_sids
      sql_on_sids(sids, command, parameters)
    end


    #
    # Run the sql commmand on all specified sids
    #
    def sql_on_sids( sids, command, parameters = {})
      results = []
      sids.each do |sid|
        Puppet.debug "executing #{command} on #{sid}"
        results = results + sql(command, {:sid => sid}.merge(parameters))
      end
      results
    end

    ##
    #
    # Use this function to execute Oracle statements
    #
    # @param command [String] this is the commands to be given
    #
    #
    def sql( command, options = {})
      options.merge!(:timeout => self[:timeout]) if timeout_specified
      @sql = Sql.new(options)
      sid = @sql.sid
      csv_string = @sql.execute(command)
      add_sid_to(convert_csv_data_to_hash(csv_string, [], :converters=> lambda {|f| f ? f.strip : nil}),sid)
    end

    def execute_on_sid(sid, command_builder)
      command_builder.options.merge!(:sid => sid)
      nil
    end

    def add_sid_to(elements, sid)
      elements.collect{|e| e['SID'] = sid; e}
    end

    # This is a little hack to get a specified timeout value
    def timeout_specified
      if respond_to?(:to_hash)
        to_hash.fetch(:timeout) { nil} #
      else
        nil
      end
    end

    def sid_from_resource
      sid_from(resource)
    end


    def sid_from(source)
      oratab = OraUtils::OraTab.new
      source.sid.empty? ? oratab.default_database_sid : source.sid
    end

  end
end
