# frozen_string_literal: true

module EdmTrain
  # Venue object
  class Venue
    attr_reader :id, :name, :location, :address, :state, :latitude, :longitude

    def initialize(raw_venue)
      @id = raw_venue['id']
      @name = raw_venue['name']
      @location = raw_venue['location']
      @address = raw_venue['address']
      @state = raw_venue['state']
      @latitude = raw_venue['latitude']
      @longitude = raw_venue['longitude']
    end
  end
end
