newparam(:management_policy) do
  include EasyType

  desc "Service management policy. "

  newvalues(:automatic, :manual)

end

