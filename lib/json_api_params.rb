# XXX Though these are necessary, AC::Parameters doesn't require it
require 'active_support/core_ext/class/attribute_accessors'
require 'active_support/core_ext/module/delegation'
require 'date'
require 'rack/test/uploaded_file'

require 'action_controller/metal/strong_parameters'
require 'active_support/core_ext/string/inflections'

class ActionController::Parameters
  def extract_json_api
    case data = fetch(:data)
    when Array
      return data.map {|_data|
        self.class.new(data: _data).extract_json_api
      }
    end

    relationships = data.fetch(:relationships) { self.class.new }.to_unsafe_hash.map {|key, value|
      [key.underscore, value]
    }.to_h

    attributes = data.fetch(:attributes) { self.class.new }.to_unsafe_hash.map {|key, value|
      [key.underscore, value]
    }.to_h

    extracted = relationships.each_with_object(attributes) {|(key, value), attrs|
      case _data = value.fetch('data')
      when Array
        attrs["#{key}_ids"] = _data.map {|item|
          item.fetch('id')
        }
      when nil
        attrs["#{key}_id"] = nil
      else
        attrs["#{key}_id"] = _data.fetch('id')
      end
    }

    self.class.new(extracted)
  end
end
