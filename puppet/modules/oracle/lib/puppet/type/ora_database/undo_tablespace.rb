# encoding: UTF-8
require 'orabase/utils/schemas'
require 'utils/hash'

newparam(:undo_tablespace) do
  class ::Puppet::Type::Ora_database::ParameterUndo_tablespace
    include EasyType
    include OraUtils::Schemas
    include Utils::Hash

    desc <<-EOD 
    Specify the default tablespace. 

    Use this syntax to specify all attributes:

      ora_database{'dbname':
        ...
        undo_tablespace => {
          name      => 'UNDOTBS',
          type      => 'bigfile',
          datafile  => {
            file_name  => 'undo.dbs',
            size       => '10G',
            reuse      =>  true,
          }
        }
      }
    EOD

    DATAFILE          = OraUtils::Schemas::DATAFILE
    EXTENT_MANAGEMENT = OraUtils::Schemas::EXTENT_MANAGEMENT
    TABLESPACE_TYPE   = OraUtils::Schemas::TABLESPACE_TYPE

    VALIDATION = {
      'name'               => String,
      'type'               => [:optional, TABLESPACE_TYPE],
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
      command_segment = "#{value_for('type')} undo tablespace #{value_for('name')}"
      command_segment << " datafile #{datafiles(datafile_data)}" if exists?('datafile')
      command_segment
    end
  end
  
end
