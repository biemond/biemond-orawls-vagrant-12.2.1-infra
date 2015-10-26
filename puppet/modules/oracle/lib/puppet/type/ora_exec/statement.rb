newproperty(:statement) do
  include ::OraUtils::OracleAccess
  include ::EasyType::Helpers

  desc "The sql command to execute"

  #
  # Let the insync? check for the parameter unless and the refreshonly
  #
  def insync?(to)
    if resource[:refreshonly] != :true
      resource[:unless] ? unless_value? : false
    else
      true
    end
  end

  private

  def unless_value?
    sid = sid_from_resource
    options = {:sid => sid}
    options.merge!(:username => resource.username) if resource.username 
    options.merge!(:password => resource.password) if resource.password 
    rows = sql resource[:unless], options
    !rows.empty?
  end

end
