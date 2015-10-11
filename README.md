# JsonApiParams

[![Build Status](https://travis-ci.org/ursm/json_api_params.svg?branch=master)](https://travis-ci.org/ursm/json_api_params) [![Gem Version](https://badge.fury.io/rb/json_api_params.svg)](https://badge.fury.io/rb/json_api_params)

Extracts JSON API (http://jsonapi.org/) params to old-fashioned way.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'json_api_params'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install json_api_params

## Usage

In a case with the following request payload:

``` json
{
  "data": {
    "attributes": {
      "x-y": 1,
      "z": 2
    },
    "relationships": {
      "foo-bar": {
        "data": {
          "id": 42
        }
      },
      "baz": {
        "data": null
      },
      "qux": {
        "data": [
          {
            "id": 3
          },
          {
            "id": 4
          }
        ]
      }
    }
  }
}
```

`ActionController::Parameters#extract_json_api` returns the following structure.

``` ruby
params.extract_json_api
#=> {"x_y"=>1, "z"=>2, "foo_bar_id"=>42, "baz_id"=>nil, "qux_ids"=>[3, 4]}
```

You can use Strong Parameters as usual.

``` ruby
# app/controllers/users_controller.rb

class UsersController < ApplicationController
  def create
    user_params = params.extract_json_api.permit(:name, :email)

    @user = User.create!(user_params)
  end

  def update
    @user       = User.find(params[:id])
    user_params = params.extract_json_api.permit(:name, :email)

    @user.update! user_params
  end
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/ursm/json_api_params.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
