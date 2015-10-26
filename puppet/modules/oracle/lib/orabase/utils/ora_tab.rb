module OraUtils
  class OraTab

    ASM_REGXP 			= /^\+ASM\d*$/
    NON_ASM_REGXP		= /^(?:(?!\+ASM\d*).)*$/
    DEFAULT_CONTENT = <<-EOD
    #
    # This file is used by ORACLE utilities.  It is created by root.sh
    # and updated by either Database Configuration Assistant while creating
    # a database or ASM Configuration Assistant while creating ASM instance.

    # A colon, ':', is used as the field terminator.  A new line terminates
    # the entry.  Lines beginning with a pound sign, '#', are comments.
    #
    # Entries are of the form:
    #   $ORACLE_SID:$ORACLE_HOME:<N|Y>:
    #
    # The first and second fields are the system identifier and home
    # directory of the database respectively.  The third filed indicates
    # to the dbstart utility that the database should , "Y", or should not,
    # "N", be brought up at system boot time.
    #
    # Multiple entries with the same $ORACLE_SID are not allowed.
    #
    #
    EOD

    def initialize(file = default_file)
      fail "oratab #{file} not found. Probably Oracle not installed" unless File.exists?(file)
      @oratab = file
    end

    def add_new_entry(sid, home, start)
      write( append_new_entry(sid, home, start))
    end

    def ensure_entry(sid, home, start)
      unless valid_sid?(sid)
        add_new_entry(sid, home, start)
      end
    end

    def append_new_entry(sid, home, start)
      "#{oratab_content}\n#{sid}:#{home}:#{start}\n"
    end

    def write(content)
      File.open(default_file, 'w') {|f| f.write(content)}
    end

    def oratab_content
      File.open(default_file) {|f| f.read}
    rescue Errno::ENOENT
      DEFAULT_CONTENT
    end

    def entries
      values = []
      File.open(@oratab) do | oratab|
        oratab.each_line do | line|
          content = [:sid, :home, :start].zip(line.split(':'))
          values << Hash[content] unless comment?(line)
        end
      end
      values
    end

    def valid_sid?(sid)
      sids.include?(sid)
    end

    def valid_asm_sid?(sid)
      asm_sids.include?(sid)
    end

    def valid_database_sid(sid)
      database_sids.include?(sid)
    end

    def sids
      entries.collect{|i| i[:sid]}
    end

    def asm_sids
      sids.select{|sid| sid =~ ASM_REGXP}
    end

    def database_sids
      sids.select{|sid| sid =~ NON_ASM_REGXP}
    end

    def running_sids
      running_database_sids + running_asm_sids
    end

    def running_database_sids
      database_sids.select do |sid|
        `pgrep -f "^(ora|xe)_pmon_#{sid}$"` != ''
      end
    end

    def running_asm_sids
      asm_sids.select do |sid|
        `pgrep -f ^asm_pmon_\\\\#{sid}$` != ''
      end
    end

    def default_database_sid
      database_sids.first || ''
    end

    def default_asm_sid
      asm_sids.first || ''
    end


    private
    def comment?(line)
      line.start_with?('#') || line.start_with?("\n")
    end

    def default_file
      case os
      when 'Linux' then '/etc/oratab'
      when 'SunOS' then '/var/opt/oracle/oratab'
      else fail 'unsupported OS'
      end
    end

    def os
      Facter.value(:kernel)
    end
  end
end
