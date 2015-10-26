newparam(:dtp) do
  include EasyType

  desc "Distributed Transaction Processing settings for this service "

  newvalues(:true, :false)

end


