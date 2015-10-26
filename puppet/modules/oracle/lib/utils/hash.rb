module Utils
  module Hash

    def included(parent)
      parent.extend(self)
    end


    def with_hash(content, &proc)
      old_content = @__content
      @__content = content      # use a double underscore to make sure it doesn't interfere 
      yield proc
      @__content = old_content
    end

    def use_hash(content)
      @__content = content  # use a double underscore to make sure it doesn't interfere 
    end

    def content_if(key, string = default_value_for_key(key))
      "#{string} #{value_for(key)}" if exists?(key)
    end

    def key_if(key, string = default_value_for_key(key))
      "#{string}" if exists?(key)
    end

    def exists?(key)
      case value_for(key)
      when nil, '' then false
      else
        true     
      end
    end

    def value_for(key)
      keys = key.split('.')
      keys.inject(@__content) do |location, key|
        location && location[key] ? location[key] : nil
      end
    end

    private

    def default_value_for_key(key)
      key.split('.').last.gsub('_', ' ')
    end

  end
end
