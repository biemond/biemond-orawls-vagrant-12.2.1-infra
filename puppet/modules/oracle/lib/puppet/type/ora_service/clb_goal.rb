newproperty(:clb_goal) do
  include EasyType

  desc "The load balancing goal to the service. "

  newvalues(:short, :long)

  to_translate_to_resource do | raw_resource|
    raw_resource.column_data('CLB_G').downcase.to_sym
  end

  on_apply do | command_builder |
    "-j #{value}"
  end

end


