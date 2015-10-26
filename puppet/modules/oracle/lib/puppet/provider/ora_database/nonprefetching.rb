require 'orabase/utils/oracle_access'
require 'easy_type'

Puppet::Type.type(:ora_database).provide(:nonprefetching) do
  include EasyType::Provider
  include ::OraUtils::OracleAccess

  desc "Manage an Oracle Database"

  mk_resource_methods

  self.instance_eval { undef :prefetch }

  def exists?
    available_databases.include?(resource.name)
  end

  private

  def available_databases
    Pathname.glob("#{resource.oracle_base}/admin/*").collect {|e| e.basename.to_s}
    #
    # TODO: Discuss with Ed, why he prefers this. Atv this point in time it doesn't work consistently
    #
    # Pathname.glob("#{resource.oracle_home}/dbs/hc_#{resource.name}.dat").collect {|e|e.basename.to_s.scan(/hc_(.*).dat/).flatten}
    #
  end
end
