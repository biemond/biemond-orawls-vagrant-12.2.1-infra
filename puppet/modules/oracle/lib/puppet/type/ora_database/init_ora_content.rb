# encoding: UTF-8
newparam(:init_ora_content) do
  include EasyType

  desc <<-EOD
    The content of the init.ora parameters. The next set of parameters are managed by the
    ora_database custom type:
      - cluster_database
      - remote_listener
      - control_files
      - *.instance_number
      - *.instance_thread
      - *.undo_tablespace

    An example:

      ora_database{'db1':
        ...
        init_ora_content => template('database/my_init_ora_content.ora.erb')
        ...
      }
  EOD

end

def init_ora_content
  self[:init_ora_content] ? self[:init_ora_content] :  template('puppet:///modules/oracle/ora_database/default_init_ora.erb', binding)
end
