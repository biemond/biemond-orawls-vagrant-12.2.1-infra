# encoding: UTF-8
require 'utils/hash'

newparam(:config_scripts, :array_matching => :all ) do
  include EasyType
  include Utils::Hash

  desc <<-EOD 
    A list of one or more files to be used to create the catalog and/or custom
    environment after the initial database fileset has been created.

    Use this syntax to specify all attributes:

      ora_database{'dbname':
        ...
        config_scripts  => [
	    { sr01 => template('myconfig/Catalog.sql.erb'),      },
	    { sr02 => template('myconfig/Cwmlite.sql.erb'),      },
	    { sr03 => template('myconfig/Xdb_Protocol.sql.erb'), },
	    { sr04 => template('myconfig/Grants.sql.erb'),       },
	  ],
      }
  EOD

  defaultto []

  #
  # Make sure it is always an array
  #
  def munge(value)
    value.is_a?(Array) ? value : [value]
  end

  def validate(value)
    fail "Must be an array of Hashes" unless array_of_hashes?(value) or single_hash?(value)
  end

  private

  def array_of_hashes?(value)
    value.is_a?(Array) and !value.any?{|e| !e.is_a?(Hash)}
  end

  def single_hash?(value)
    value.is_a?(Hash) and value.count == 1
  end

end

