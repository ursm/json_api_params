# JsonapiParams

Deforms JSON API params to old-fashioned way.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'jsonapi_params'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install jsonapi_params

## Usage

``` ruby
# app/controllers/users_controller.rb

class UsersController < ApplicationController
  def create
    user_params = params.deform_jsonapi.permit(:name, :email)

    @user = User.create!(user_params)
  end

  def update
    @user       = User.find(params[:id])
    user_params = params.deform_jsonapi.permit(:name, :email)

    @user.update! user_params
  end
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/ursm/jsonapi_params.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
