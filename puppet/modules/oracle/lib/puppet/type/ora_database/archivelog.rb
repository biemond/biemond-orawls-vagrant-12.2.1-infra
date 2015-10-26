# encoding: UTF-8
newparam(:archivelog) do
  include EasyType

  newvalues(:enabled, :disabled)

  desc 'Enable or disable archive log.'

  to_translate_to_resource do | raw_resource|
    # raw_resource.column_data('archivelog')
  end

  on_apply  do| command_builder |
    enabled? ? 'archivelog' : 'noarchivelog'
  end

  private

  def enabled?
    value == :enabled
  end

end
