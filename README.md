# edm_train
Edm_Train is a simpel ruby gem to interface with the edmtrain.com API.

# Prerequisites 
* edm_train was designed with Ruby 3.2.1 and has not been tested on earlier versions, however, it is a simple library and will likely work on most ruby versions.
* An API key from edmtrain.com

# Install
### Gemfile
```ruby
gem 'edm_train', '~> 0.0.1'
```

### Rubygems
```shell
gem install edm_train
```

## Examples
Find a list of locations EDM Train supports
```
  EdmTrain.api_key = ENV['EDM_TRAIN_API_KEY']
  locations = 
```ruby
  EdmTrain.api_key = ENV['EDM_TRAIN_API_KEY']
  location = EdmTrain::Locations.find(city: 'Detroit', state: 'Michigan')
  events = location.events
```