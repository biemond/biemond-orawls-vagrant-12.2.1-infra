newproperty(:contents) do
  include EasyType

  desc "What does the tablespace contain? permanent, temporary of undo data"

  newvalues(:permanent, :temporary, :undo)

  to_translate_to_resource do | raw_resource|
    raw_resource.column_data('CONTENTS').downcase.to_sym
  end
end
