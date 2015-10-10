# XXX Though these are necessary, AC::Parameters doesn't require it
require 'active_support/core_ext/class/attribute_accessors'
require 'date'
require 'rack/test/uploaded_file'

require 'action_controller/metal/strong_parameters'
require 'active_support/core_ext/object/try'
require 'active_support/core_ext/string/inflections'

class ActionController::Parameters
  def deform_jsonapi
    data          = fetch(:data)
    relationships = data.fetch(:relationships) { self.class.new }

    attributes = self.class[*data.fetch(:attributes) { Hash.new }.flat_map {|key, value|
      [key.underscore, value]
    }]

    relationships.each_with_object(attributes) {|(key, value), attrs|
      k = key.underscore

      case _data = value.fetch(:data)
      when Array
        attrs["#{k}_ids"] = _data.map {|item|
          item.fetch(:id)
        }
      else
        attrs["#{k}_id"] = _data.try(:fetch, :id)
      end
    }
  end
end
