require 'orabase/utils/ora_command'

module OraUtils
  class AsmcmdCommand < OraCommand

    def initialize(options = {})
      super(:asmcmd, options)
    end

  end
end

