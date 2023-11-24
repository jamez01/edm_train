# frozen_string_literal: true

module EdmTrain
  class Artist
    attr_reader :id, :name, :link, :b2b_ind

    def initialize(raw_artist)
      @id = raw_artist['id']
      @name = raw_artist['name']
      @link = raw_artist['link']
      @b2b_ind = raw_artist['b2bInd']
    end
  end
end
