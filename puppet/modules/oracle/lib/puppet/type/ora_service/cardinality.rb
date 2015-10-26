newparam(:cardinality) do
  include EasyType

  desc "The cardinality of the service. "

  newvalues(:uniform, :singleton)

end
