newparam(:network_number) do
  include EasyType
  include Validators::Integer

  desc "The network this service is offered on. "

end
