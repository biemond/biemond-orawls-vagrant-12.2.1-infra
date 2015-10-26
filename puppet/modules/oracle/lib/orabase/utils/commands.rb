module OraUtils
  module Commands

    def self.included(parent)
      parent.extend(Commands)
    end


    [:asmcmd, :srvctl, :orapwd].each do | command|
      file  = "orabase/utils/#{command}_command"
      klass = "#{command.to_s.capitalize}Command"
      require file

      module_eval(<<-END_RUBY, __FILE__, __LINE__)
        # @nodoc
        # @private
        def #{command}( arguments, options = {})
          #{command} = ::OraUtils::#{klass}.new(options)
          #{command}.execute arguments
        end
      END_RUBY
    end
  end
end
