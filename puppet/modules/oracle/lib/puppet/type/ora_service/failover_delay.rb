newparam(:failover_delay) do
  include EasyType
  include Validators::Integer

  desc "The delay between failover attempts "

end
