newproperty(:value, :array_matching => :all ) do
  include EasyType

  desc "The value or values of the parameter. You can use either a single value or an Array value"

  #
  # Order doesn't matter
  #
  def insync?(is)
    Array(is).sort == Array(should).sort
  end

  to_translate_to_resource do | raw_resource|
    raw_resource.column_data('DISPLAY_VALUE')
  end

end