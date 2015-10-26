require 'orabase/utils/oracle_access'
require 'easy_type/helpers'
require 'orabase/utils/ora_tab'
require 'fileutils'


Puppet::Type.type(:ora_exec).provide(:sqlplus) do
  include OraUtils::OracleAccess
  include EasyType::Helpers
  include EasyType::Template

  mk_resource_methods

  def flush
    return if resource[:refreshonly] == :true
    execute
  end

  def execute
    cwd        = resource[:cwd]
    statement  = resource[:statement]
    sid        = sid_from_resource
    options     = {:sid => sid, :parse => false}
    options.merge!( :username => resource.username) unless resource.username.nil?
    options.merge!( :password => resource.password) unless resource.password.nil?

    fail "Working directory '#{cwd}' does not exist" if cwd && !File.directory?(cwd)
    FileUtils.cd(resource[:cwd]) if resource[:cwd]
    output = sql statement, options
    Puppet.debug(output) if resource.logoutput == :true
  end

  private

  def is_script?(statement)
    statement[0] == 64
  end

end
