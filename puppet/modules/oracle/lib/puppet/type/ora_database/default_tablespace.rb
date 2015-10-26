# encoding: UTF-8
require 'orabase/utils/schemas'
require 'utils/hash'

newparam(:default_tablespace) do
  class ::Puppet::Type::Ora_database::ParameterDefault_tablespace
    include EasyType
    include OraUtils::Schemas
    include Utils::Hash

    desc <<-EOD 
    Specify the default tablespace. 

    Use this syntax to specify all attributes:

      ora_database{'dbname':
        ...
        default_tablespace => {
          name      => 'USERS',
          datafile  => {
            file_name  => 'users.dbs',
            size       => '10G',
            reuse      =>  true,
          }
          extent_management => {
            type          => 'local',
            autoallocate  => true, (mutual exclusive with uniform size)
            uniform_size  => '5G',
          }
        }
      }

    EOD

    DATAFILE          = OraUtils::Schemas::DATAFILE
    EXTENT_MANAGEMENT = OraUtils::Schemas::EXTENT_MANAGEMENT

    VALIDATION = {
      'name'               => String,
      'datafile'           => [:optional, DATAFILE],
      'extent_management'  => [:optional, EXTENT_MANAGEMENT]
    }

    def validate(value)
      ClassyHash.validate_strict(value, VALIDATION)
      use_hash(value)
      validate_extent_management(value_for('extent_management'))
    end
    

    def value
      use_hash(@value)
      datafile_data = value_for('datafile')
      command_segment = "default tablespace #{value_for('name')}"
      command_segment << " datafile #{datafiles(datafile_data)}" if exists?('datafile')
      command_segment << " #{extent_management(value_for('extent_management'))}" if exists?('extent_management')
      command_segment 
    end
  end
  
end
