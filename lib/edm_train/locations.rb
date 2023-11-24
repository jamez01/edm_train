# frozen_string_literal: true

module EdmTrain
  # Locations API Calls
  class Locations
    # Returns all known locations
    # @return [Array<Location>]
    def self.all
      EdmTrain.client.get('/locations').map do |raw_location|
        Location.new(raw_location)
      end
    end

    # Returns a location based on city and state
    # @param [Hash] params
    # @option params [String] :city the city
    # @option params [String] :state the state
    # @example
    #   EdmTrain::Locations.find(city: 'Detroit', state: 'Michigan')
    # @return [Location]
    def self.find(params = {})
      Location.new(EdmTrain.client.get('/locations', city: params[:city], state: params[:state]).first)
    end
  end

  # Location object
  # @attr_reader [Integer] id the location ID
  # @attr_reader [String] city the city (e.g. 'Detroit')
  # @attr_reader [String] state the state (e.g. 'Michigan')
  # @attr_reader [String] state_code the state code (e.g. 'MI')
  # @attr_reader [Float] latitude the latitude
  # @attr_reader [Float] longitude the longitude
  # @attr_reader [String] link the link to the location on EdmTrain
  class Location
    attr_reader :id, :city, :state, :state_code, :latitude, :longitude, :link

    # @param [Hash] raw_location the raw location from the API
    # @note This is not intended to be called directly
    def initialize(raw_location)
      @id = raw_location['id']
      @city = raw_location['city']
      @state = raw_location['state']
      @state_code = raw_location['stateCode']
      @latitude = raw_location['latitude']
      @longitude = raw_location['longitude']
      @link = raw_location['link']
    end
    
    # Returns all events for this location
    # @return [Array<Event>]  
    def events
      EdmTrain::Events.find(to_h)
    end

    # Returns a string representation of the location for event searching
    # @return [Hash]
    def to_h
      {
        city: @city,
        state: @state,
        latitude: @latitude,
        longitude: @longitude
      }
    end
  end
end
