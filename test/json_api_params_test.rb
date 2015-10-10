require 'test_helper'

class JsonApiParamsTest < Minitest::Test
  def test_simple
    params = ActionController::Parameters.new(
      data: {
        attributes: {
          'x-y': 1,
          z:     2
        },
        relationships: {
          'foo-bar': {
            data: {
              id: 42
            }
          },
          baz: {
            data: nil
          },
          qux: {
            data: [{
              id: 3
            }, {
              id: 4
            }]
          }
        }
      }
    )

    expected = ActionController::Parameters.new(
      x_y:         1,
      z:           2,
      foo_bar_id: 42,
      baz_id:      nil,
      qux_ids:    [3, 4]
    )

    assert { params.extract_json_api == expected }
  end
end
