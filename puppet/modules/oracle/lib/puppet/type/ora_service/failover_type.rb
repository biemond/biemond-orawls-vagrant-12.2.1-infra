newparam(:failover_type) do
  include EasyType

  desc "Failover type. "

  newvalues(:none, :session, :select)

end


