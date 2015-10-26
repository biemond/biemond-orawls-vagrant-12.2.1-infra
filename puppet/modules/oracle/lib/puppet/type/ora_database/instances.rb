# encoding: UTF-8

newparam(:instances) do
  class ::Puppet::Type::Ora_database::ParameterInstances
    include EasyType
    include OraUtils::Schemas
    include Utils::Hash

    defaultto({})

    desc <<-EOD 
    One or more instances to be enables on the database

    Use this syntax to specify all attributes:

      ora_database{'dbname':
        ...
        instances       => {
          instance1   => host1,
          instance2   => host2,
        }
      }
    EOD


  def validate(value)
    fail "instances should be a hash" unless value.is_a?(Hash)
  end

  end
end
