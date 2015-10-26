# encoding: UTF-8
require 'orabase/utils/schemas'
require 'utils/hash'

newparam(:logfile_groups, :array_matching => :all) do
  class ::Puppet::Type::Ora_database::ParameterLogfile_groups
    include EasyType
    include OraUtils::Schemas
    include Utils::Hash

    desc <<-EOD 
    Specify the logfile groups. 

    Use this syntax to specify all attributes:

      ora_database{'dbname':
        ...
        logfile_groups => [
            {file_name => 'test1.log', size => '10M', reuse => true},
            {file_name => 'test2.log', size => '10M', reuse => true},
          ],
      }

    EOD

    VALIDATION       = OraUtils::Schemas::DATAFILE

    def validate(value)
       value = [value] if value.is_a?(Hash) # ensure, it is an array
      value.each {|v| ClassyHash.validate_strict(v, VALIDATION)}
    end
    
    def value
      command_segment = []
      @value.each_index do | index|
        v = @value[index]
        command_segment << "group #{index + 1} #{file_specification(v)}"
      end
      "logfile #{command_segment.join(', ')}" if @value
    end
  end

end
