require 'orabase/utils/ora_tab'

#
# Although this file is named asm_sid, the name of the parameter is and should be
# sid. This is done to distinqush between a default asm sid and a default database
# sid
#
newparam(:sid) do
  include EasyType

  desc "ASM SID to connect to"

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
  self[:sid].empty? ? oratab.default_asm_sid : self[:sid]
end
