require 'orabase/utils/oracle_access'
require 'easy_type'

Puppet::Type.type(:ora_record).provide(:sqlplus) do
  include EasyType::Provider
  include EasyType::Template
  include EasyType::Helpers
  include ::OraUtils::OracleAccess

  desc "Manage a record in an Oracle table via regular SQL"

  mk_resource_methods

  def self.prefetch(resources)
    resources.each do |name, resource|
      options = options_for(resource[:username], resource[:password], sid_from(resource))
      columns = resource.data.keys.collect{|c| "#{c}||'#{' '.*c.length}' as #{c}"}
      statement = "select #{columns.join(',')} from #{resource[:table_name]} where #{resource[:key_name]} = '#{resource[:key_value]}'"
      records = sql(statement, options)
      resource.provider = map_raw_to_resource(records.last) unless records.empty?
    end
  end

  def self.options_for(username, password, sid)
    options = {:sid => sid}
    options.merge!( :username => username)
    password = password.nil? ? username : password
    options.merge!( :password => password)
    options
  end


end

