# encoding: UTF-8
newparam(:force_logging) do
  include EasyType

  newvalues(:enabled, :disabled)

  desc 'Enable or disable the FORCE LOGGING mode. '

  to_translate_to_resource do | raw_resource|
  #  raw_resource.column_data('force_logging')
  end

  on_apply do | command_builder | 
    enabled? ? 'force_logging' : 'noforce_logging'
  end

  private

  def enabled?
    value == :enabled
  end

end