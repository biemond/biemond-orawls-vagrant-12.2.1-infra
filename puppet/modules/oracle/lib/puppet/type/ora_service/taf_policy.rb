newparam(:taf_policy) do
  include EasyType

  desc "TAF policy specification (for administrator-managed databases only)"

  newvalues(:basic, :none , :reconnect)

end
