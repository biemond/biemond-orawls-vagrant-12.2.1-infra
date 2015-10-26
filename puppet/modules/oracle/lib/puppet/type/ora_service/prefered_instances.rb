require 'orabase/utils/mungers'

newproperty(:prefered_instances, :array_matching => :all) do
  include EasyType

  desc = %q{A list of preferred instances on which the service runs when the database is administrator managed}

  defaultto []

#
# Make sure it is always an array
#
  def munge(value)
    value.is_a?(Array) ? value : [value]
  end

end
