require 'orabase/utils/oracle_access'

newproperty(:lb_advisory) do
  include EasyType
  include ::OraUtils::OracleAccess

  desc "Goal for the Load Balancing Advisory. "

  newvalues( :none, :service_time, :throughput)

  def insync?(is)
    #
    # This parameter is only appropriate on a cluster
    if is_cluster?
      super
    else
      Puppet.info 'Not on a RAC cluster. Ignoring parameter \'lb_advisory\'.'
      true
    end
  end


  to_translate_to_resource do | raw_resource|
    value = raw_resource.column_data('GOAL').downcase
    value == '' ? value : value.to_sym
  end

  on_apply do | command_builder |
    "-B #{value}"
  end

  # TODO: Remove duplication
  def is_cluster?
    sql('select parallel as par from v$instance', :sid => sid).first['PAR'] == 'YES'
  end


end


