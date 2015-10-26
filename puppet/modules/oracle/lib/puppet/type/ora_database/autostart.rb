# encoding: UTF-8
newparam(:autostart) do
  include EasyType
  
  desc 'Add autostart to the oratab entry'

  newvalues(:true, :false)
  
  defaultto(:true)

end

def autostart
  self[:autostart] == :true ? 'Y' : 'N'
end