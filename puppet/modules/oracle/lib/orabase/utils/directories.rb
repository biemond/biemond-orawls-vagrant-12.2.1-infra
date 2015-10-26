module OraUtils
  module Directories

    def self.included(parent)
      parent.extend(Directories)
    end


    def remove_directories( placeholder = nil, options = {})
      FileUtils.rm_rf "#{oracle_base}/admin/#{name}"
      FileUtils.rm_rf "#{oracle_home}/dbs/init#{name}.ora"
      FileUtils.rm_rf "#{oracle_base}/cfgtoolslog/dbca/#{name}"
    end

    def create_directories( placeholder = nil, options = {})
      make_oracle_directory oracle_base
      make_oracle_directory oracle_home
      make_oracle_directory "#{oracle_home}/dbs"
      make_oracle_directory "#{oracle_base}/admin"
      make_oracle_directory "#{oracle_base}/cfgtoollogs"
      make_oracle_directory "#{oracle_base}/admin/#{name}"
      make_oracle_directory "#{oracle_base}/admin/#{name}/adump"
      make_oracle_directory "#{oracle_base}/admin/#{name}/ddump"
      make_oracle_directory "#{oracle_base}/admin/#{name}/dpdump"
      make_oracle_directory "#{oracle_base}/admin/#{name}/hdump"
      make_oracle_directory "#{oracle_base}/admin/#{name}/pfile"
      make_oracle_directory "#{oracle_base}/admin/#{name}/scripts"
      make_oracle_directory "#{oracle_base}/admin/#{name}/scripts/log"
      make_oracle_directory "#{oracle_base}/cfgtoollogs/dbca/#{name}"
    end

    def make_oracle_directory(path)
      Puppet.debug "creating directory #{path}"
      FileUtils.mkdir_p path
      owned_by_oracle(path)
    end

    def owned_by_oracle(*path)
      Puppet.debug "Setting ownership for #{path}"
      FileUtils.chmod 0775, path
      FileUtils.chown oracle_user, install_group, path
    end

  end
end
