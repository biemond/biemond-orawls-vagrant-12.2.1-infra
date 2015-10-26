require 'orabase/utils/ora_tab'

newparam(:sid) do
  include EasyType

  desc "SID to connect to"

  to_translate_to_resource do | raw_resource|
    raw_resource.column_data('SID')
  end

end

#
# This is to support installations where the oratab is not available during the parse,
# but is available when we apply the class
#

def sid
  oratab = OraUtils::OraTab.new
  begin
   self[:sid].empty? ? oratab.default_database_sid : self[:sid]
  rescue NoMethodError
    oratab.default_database_sid
  end
end
