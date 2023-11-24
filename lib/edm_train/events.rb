# frozen_string_literal: true

module EdmTrain
  # Events API
  class Events
    # Returns all known events
    # @return [Array<Event>]
    def self.all
      EdmTrain.client.get('/events').map { |raw_event| Event.new(raw_event) }
    end

    # Search for events matching the given paramaters
    # @param [Hash] params All fields are optional
    # @option params [String] :eventName The name of the event, such as the name of a festival. Most events do not have names. If an event has no artists, then it will have a name.
    # @option params [String] :artistIds One or more artist ids to retrieve events for. Artist ids can be determined by looking at an existing event where they are performing.
    # @option params [String] :venueIds One or more venue ids to retrieve events for. Venue ids can be determined by looking at an existing event for that location.
    # @option params [String] :locationIds One or more location ids to retrieve events for. Location ids can be determined by using the Locations API below. All live streams will be included unless livestreamInd is set to false.
    # @option params [String] :startDate  Retrieve events occurring at or after this local date (only future events will be returned).
    # @option params [String] :endDate  Retrieve events occurring at or before this local date.
    # @option params [String] :createdStartDate  Retrieve events added to Edmtrain at or after this UTC date (only future events will be returned).
    # @option params [String] :createdEndDate  Retrieve events added to Edmtrain at or before this UTC date.
    # @option params [String] :festivalInd  Set to true to return only festivals (default is not set). Set to false to exclude festivals.
    # @option params [String] :livestreamInd  Set to true to return only live streams (default is not set). Set to false to exclude live streams.
    # @return [Array<Event>]
    # @example
    #   EdmTrain::Events.find(locationIds: 102) # Find events near location 102 (Detroit, Michigan)
    def self.find(params)
      EdmTrain.client.get('/events', params).map { |raw_event| Event.new(raw_event) }
    end
  end

  # Event object
  # @attr_reader [Integer] id the event ID
  # @attr_reader [String] link the link to the event on EdmTrain
  # @attr_reader [Date] date the date of the event
  # @attr_reader [Array<Artist>] artists the artists performing at the event
  # @attr_reader [Venue] venue the venue of the event
  class Event
    attr_reader :id, :link, :ages, :date, :venue, :ages
    # @param [Hash] raw_event the raw event from the API
    # @note This is not intended to be called directly
    def initialize(raw_event)
      @id = raw_event['id']
      @link = raw_event['link']
      @date = Date.parse(raw_event['date'])
      @start_time = raw_event['startTime']
      @end_time = raw_event['endTime']
      @artists = raw_event['artistList'].map {|artist| EdmTrain::Artist.new(artist)}
      @venue = EdmTrain::Venue.new(raw_event['venue'])
      @created_at = raw_event['createdDate']
      @festival = raw_event['festivalInd']
      @electronic = raw_event['electronicMusicInd']
      @other_genre = raw_event['otherGenreInd']
      @live_stream = raw_event['liveStreamInd']
      @ages = raw_event['ages'] || ''
      @name = raw_event['name']
      @festival = raw_event['festivalInd']
      @electronic = raw_event['electronicMusicInd']
      @other_genre = raw_event['otherGenreInd']
    end

    # Returns a string representation of the event for event searching
    # @return [DateTime]
    def created_at
      @created_at ? DateTime.parse(raw_event['createdDate']) : nil
    end
    
    # Returns an array of artists performing at the event
    # @return [Array<Artist>]
    def artists
      @artists ? raw_event['artistList'].map { |artist| EdmTrain::Artist.new(artist) } : []
    end

    # Returns the name of the event
    # @return [String]
    def name
      @name || @artists.map(&:name).join(', ')
    end

    # Returns the start time of the event. This only applies to livestreams
    # @return [DateTime]
    def start_time
      @start_time ? DateTime.parse(@start_time) : date
    end

    # Returns the end time of the event. This only applies to livestreams
    # @return [DateTime]
    def end_time
      @end_time ? DateTime.parse(@end_time) : date
    end

    # Returns true if the event is an electronic music event
    # @return [Boolean]
    def electronic?
      @electronic
    end

    # Returns true if the event is an other genre event
    # @return [Boolean]
    def other_genre?
      @other_genre
    end

    # Returns true if the event is a festival
    # @return [Boolean]
    def festival?
      @festival
    end

    # Returns true if the event is a livestream
    # @return [Boolean]
    def live_stream?
      @raw_event['liveStreamInd']
    end
    
    # Returns an array of artist names performing at the event
    # @return [Array<String>]
    def artist_names
      return "Unknown" unless @artists
      @artists.map(&:name)
    end

    # Returns a string representation of the event.
    # @return [String]
    def to_s
      "#{name} - #{artist_names.join(', ')} at #{venue.name}"
    end
  end
end
