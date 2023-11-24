# frozen_string_literal: true

require 'edm_train/client'
require 'edm_train/events'
require 'edm_train/locations'
require 'edm_train/venue'
require 'edm_train/artist'

# An API Client for EdmTrain.com
# Search and discover EDM events near you.
# @example
#   EdmTrain.api_key = 'YOUR_API_KEY'
#   all_locations = EdmTrain::Locations.all
#   detroit = EdmTrain::Locations.find(city: 'Detroit', state: 'Michigan')
#   detroit_events = detroit.events
module EdmTrain
end