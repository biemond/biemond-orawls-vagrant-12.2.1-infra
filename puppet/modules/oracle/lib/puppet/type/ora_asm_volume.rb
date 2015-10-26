require 'pathname'
$:.unshift(Pathname.new(__FILE__).dirname.parent.parent)
$:.unshift(Pathname.new(__FILE__).dirname.parent.parent.parent.parent + 'easy_type' + 'lib')
require 'easy_type'
require 'orabase/utils/commands'
require 'orabase/utils/title_parser'
require 'orabase/resources/ora_asm_volume'


# @nodoc
module Puppet
  newtype(:ora_asm_volume) do
    include EasyType
    include ::OraUtils::Commands
    extend ::OraUtils::TitleParser

    desc "The ASM volumes"

    ensurable
    
    set_command(:asmcmd)

    to_get_raw_resources do
      ::Resources::OraAsmVolume.raw_resources
    end

    on_create do | command_builder |
      command_builder.add( "volcreate -G #{diskgroup} -s #{size}M #{volume_name}", :sid => sid)
    end

    on_modify do | command_builder|
      Puppet.warning "Modification of asm volumes not supported yet"
      nil
    end

    on_destroy do |command_builder|
      command_builder.add("voldelete -G #{diskgroup} #{volume_name}", :sid => sid)
    end

    def self.remove_colon_from_diskgroup
      # Chopping of @ end using length of 16 because max length of SID is 16
      lambda { |diskgroup| diskgroup.nil? ? (fail ArgumentError, 'invalid diskgroup in title') : diskgroup.chop} 
    end


    map_title_to_asm_sid([:diskgroup, remove_colon_from_diskgroup], :volume_name) { /^((.*\:)?(@?.*?)?(\@.*?)?)$/}

    #
    # property  :new_property  # For every property and parameter create a parameter file
    #
    parameter :name
    parameter :asm_sid      # The included file is asm_sid, but the parameter is named sid
    parameter :volume_name
		parameter :diskgroup
    parameter :volume_device

		property  :size
    # -- end of attributes -- Leave this comment if you want to use the scaffolder

    #
  end
end
