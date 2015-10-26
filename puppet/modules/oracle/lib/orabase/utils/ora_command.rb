module OraUtils
  class OraCommand

    DEFAULT_TIMEOUT   = 300 # 5 minutes
    ORA_OS_USER_NAME  = 'ORA_OS_USER'
    ASM_OS_USER_NAME  = 'ASM_OS_USER'

    VALID_OPTIONS = [
      :sid,
      :os_user,
      :password,
      :timeout,
      :username,
    ]

    attr_reader *VALID_OPTIONS

    def initialize(command, options, valid_options = VALID_OPTIONS)
      @valid_options  = valid_options
      check_options( options )
      @command        = command
      @oratab         = OraUtils::OraTab.new
      @password       = options[:password] # may be empty
      @timeout        = options.fetch(:timeout) { DEFAULT_TIMEOUT}
      @sid            = options.fetch(:sid) { raise ArgumentError, "you need to specify a sid for oracle access"}
      if asm_sid?
        @os_user      = options.fetch(:os_user) {default_asm_user}
        @username     = options.fetch(:username){'sysasm'}
      else
        @os_user      = options.fetch(:os_user) {default_ora_user}
        @username     = options.fetch(:username){'sysdba'}
      end
    end

    def command_string(arguments = '')
      "su - #{@os_user} -c \"export ORACLE_SID=#{@sid};export ORAENV_ASK=NO;. oraenv; #{@command} #{arguments}\""
    end

    def execute(arguments)
      options = {:failonfail => true}
      value = ''
      within_time(@timeout) do
        Puppet.debug "Executing #{@command} command: #{arguments} on #{@sid} as #{os_user}, connected as #{username}"
        value = Puppet::Util::Execution.execute(command_string(arguments), options)
      end
      value
    end

    private

    def within_time(timeout)
      Puppet.debug "Using timeout #{timeout}"
      if timeout == 0
        yield
      else
        Timeout::timeout(timeout) do
          yield
        end
      end
    end

    def validate_sid
      raise ArgumentError, "sid #{@sid} doesn't exist on node" unless @ratab.valid_sid?(@sid) 
    end

    def asm_sid?
      @oratab.valid_asm_sid?(@sid)
    end

    def check_options(options)
      options.each_key {| key|  raise ArgumentError, "option #{key} invalid for #{@command}. Only #{@valid_options.join(', ')} are supported" unless @valid_options.include?(key)}
    end

    def default_asm_user
      ENV[ASM_OS_USER_NAME] ||  Facter.value(ASM_OS_USER_NAME) || 'grid'
    end

    def default_ora_user
      ENV[ORA_OS_USER_NAME] ||  Facter.value(ORA_OS_USER_NAME) || 'oracle'
    end

  end
end
