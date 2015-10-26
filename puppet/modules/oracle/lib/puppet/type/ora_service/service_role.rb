newparam(:service_role) do
  include EasyType

  desc "The service role. "

  newvalues(:primary, :physical_standby, :logical_standby, :snapshot_standby)

end

