# frozen_string_literal: true

require 'open-uri'
require 'json'

# An API Client for EdmTrain.com
module EdmTrain
  # Helper method to return the client. 
  # @return [EdmTrain::Client] the base client
  def self.client
    @client ||= Client.new
  end

  # EdmTrain API key getter
  # @return [String] the API key
  def self.api_key
    @api_key
  end

  # EdmTrain API key setter
  # @param [String] key the API key
  # @return [String] the API key
  def self.api_key=(key)
    @api_key = key
  end

  # Error for API errors
  # @return [StandardError] the API error
  class APIError < StandardError; end

  # Error for missing API key
  # @return [StandardError] the missing API key error
  class MissingKeyError < StandardError
    def initialize
      super 'Must set EdmTrain.api_key before making requests'
    end
  end

  # Client for the EdmTrain API
  class Client
    # Perform a GET request to the EdmTrain API
    # @param [String] path the path to the API endpoint
    # @param [Hash] params the query parameters
    # @raise [MissingKeyError] if the API key is not set
    # @return [Hash] the response from the API
    def get(path, params = {})
      raise MissingKeyError unless EdmTrain.api_key

      params[:client] = EdmTrain.api_key
      result = JSON.parse(URI.open("https://edmtrain.com/api/#{path}?#{to_query(params)}").read)
      raise APIError, result['message'] unless result['success']

      result['data']
    end

    private
    # Helper method to convert a hash to a query string
    # @param [Hash] params the query parameters
    # @return [String] the query string
    def to_query(params)
      URI.encode_www_form(params)
    end
  end
end
