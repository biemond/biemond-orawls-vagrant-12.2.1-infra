newparam(:failover_retries) do
  include EasyType
  include Validators::Integer

  desc "The number of failover retry attempts. "

end
