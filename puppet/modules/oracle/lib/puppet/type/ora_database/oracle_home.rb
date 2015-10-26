# encoding: UTF-8
newparam(:oracle_home) do
  include EasyType
  
  desc 'The oracle_home directory'

end

def oracle_home
  self[:oracle_home] ? self[:oracle_home] : "#{self[:oracle_base]}/app/#{name}"
end