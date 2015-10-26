require 'orabase/utils/oracle_access'

module OraUtils
  module TitleParser
    include OracleAccess

    def parse_database_sid
      # Chopping of @ end using length of 16 because max length of SID is 16
      lambda { |sid_name| sid_name.nil? ? default_database_sid : sid_name[1..17]} 
    end

    def parse_asm_sid
      # Chopping of @ end using length of 16 because max length of SID is 16
      lambda { |sid_name| sid_name.nil? ? default_asm_sid : sid_name[1..17]} 
    end


    def parse_database_name
      lambda do |name|
        begin
          groups      = name.scan(/^((@?.*?)?(\@.*?)?)$/).flatten
          sid         = parse_database_sid.call(groups.last)
          object_name = groups[1]
          if self.name != :ora_exec && object_name.include?('/')
            Puppet.deprecation_warning("Using 'sid/name' in title is deprecated. Use 'name@sid'.")
            sid, object_name = object_name.scan(/^(.*)\/(.*)$/).flatten.flatten
          end
          "#{object_name}@#{sid}"
        rescue
          fail ArgumentError, 'a failure in parsing the database object title. Check the documentation for the correct syntax of the title'
        end
      end
    end

    # TODO: Check how we can remove this duplication
    def parse_asm_name
      lambda do |name|
        begin
          groups      = name.scan(/^((@?.*?)?(\@.*?)?)$/).flatten
          sid         = parse_asm_sid.call(groups.last)
          object_name = groups[1]
          if self.name != :ora_exec && object_name.include?('/')
            Puppet.deprecation_warning("Using 'sid/name' in title is deprecated. Use 'name@sid'.")
            sid, object_name = object_name.scan(/^(.*)\/(.*)$/).flatten.flatten
          end
          "#{object_name}@#{sid}"
        rescue
          fail ArgumentError, 'a failure in parsing the asm object title. Check the documentation for the correct syntax of the title'
        end
      end
    end


    def map_title_to_sid(*attributes, &proc)
      all_attributes = [[:name, parse_database_name]] + attributes + [[:sid, parse_database_sid]]
      map_title_to_attributes(*all_attributes, &proc)
    end

    def map_title_to_asm_sid(*attributes, &proc)
      all_attributes = [[:name, parse_asm_name]] + attributes + [[:sid, parse_asm_sid]]
      map_title_to_attributes(*all_attributes, &proc)
    end


    # Retrieve the default sid on this system
    def default_database_sid
      oratab = OraUtils::OraTab.new
      oratab.default_database_sid
    rescue
      ''
    end

    # Retrieve the default sid on this system
    def default_asm_sid
      oratab = OraUtils::OraTab.new
      oratab.default_asm_sid
    rescue
      ''
    end


  end
end



