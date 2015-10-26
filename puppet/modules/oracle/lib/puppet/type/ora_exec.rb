require 'pathname'
$:.unshift(Pathname.new(__FILE__).dirname.parent.parent)
$:.unshift(Pathname.new(__FILE__).dirname.parent.parent.parent.parent + 'easy_type' + 'lib')
require 'easy_type'
require 'orabase/utils/oracle_access'
require 'orabase/utils/title_parser'


module Puppet
  #
  # Create a new type oracle_user. Oracle user, works in conjunction 
  # with the SqlResource
  #
  newtype(:ora_exec) do
    include EasyType
    include ::OraUtils::OracleAccess
    extend OraUtils::TitleParser

    desc "This resource allows you to execute any sql command in a database"

    map_title_to_sid(:statement) { /^((@?.*?)?(\@.*?)?)$/}

    def refresh
      provider.execute
    end

    parameter :name
    property  :statement
    parameter :sid

    parameter :timeout
    parameter :cwd
    parameter :logoutput
    parameter :password
    parameter :username
    parameter :unless
    parameter :refreshonly

  end


end



