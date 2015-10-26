# encoding: UTF-8
require 'orabase/utils/schemas'
require 'utils/hash'

newparam(:datafiles, :array_matching => :all) do
  class ::Puppet::Type::Ora_database::ParameterDatafiles
    include EasyType
    include OraUtils::Schemas
    include Utils::Hash

    desc <<-EOD 
    One or more files to be used as datafiles.

    Use this syntax to specify all attributes:

      ora_database{'dbname':
        ...
        datafiles       => [
          {file_name   => 'file1.dbs', size => '10G', reuse => true},
          {file_name   => 'file2.dbs', size => '10G', reuse => true},
        ]
      }
    EOD

    VALIDATION = OraUtils::Schemas::DATAFILE

    def validate(value)
       value = [value] if value.is_a?(Hash) # ensure, it is an array
       value.each {|v| ClassyHash.validate_strict(v, VALIDATION)}
    end

    def value
      "datafile #{datafiles(@value)}" unless @value.empty?
    end

  end
end
