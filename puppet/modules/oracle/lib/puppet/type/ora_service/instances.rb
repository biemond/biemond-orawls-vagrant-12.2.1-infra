require 'orabase/utils/mungers'

newproperty(:instances, :array_matching => :all) do
  include EasyType

  desc = %q{A list of instance names to activate the service on.}


#
# Make sure it is always an array
#
  def munge(value)
    value.is_a?(Array) ? value : [value]
  end

end
