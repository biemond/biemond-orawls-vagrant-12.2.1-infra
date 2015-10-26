require 'orabase/resources/generic'

module Resources
  class OraAsmDiskgroup < Resources::Generic

    def raw_resources
      statement = template('puppet:///modules/oracle/ora_asm_diskgroup/index.sql.erb', binding)
      sql_on_all_asm_sids(statement)
    end

  end
end