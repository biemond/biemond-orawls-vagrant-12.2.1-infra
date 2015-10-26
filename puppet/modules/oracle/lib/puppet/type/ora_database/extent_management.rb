# encoding: UTF-8
require 'orabase/utils/schemas'
require 'utils/hash'

newparam(:extent_management) do
  class ::Puppet::Type::Ora_database::ParameterExtent_management
    include EasyType
    include OraUtils::Schemas

    newvalues(:local)

    desc <<-EOD 
    Specify the extent management. 

    Use this syntax to specify all attributes:

      ora_database{'dbname':
        ...
        extent_management => 'local'
    EOD

  end
  
end
