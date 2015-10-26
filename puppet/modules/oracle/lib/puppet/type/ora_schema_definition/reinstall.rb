newparam(:reinstall) do

  desc "Force delete before applying the schema updates"

  newvalues(:true, :false)

  defaultto(:false)

end

