
require 'pry'
class API
    attr_accessor :options
    def initialize(resource, options:)
        @resource = resource 
        @options = options 
    end

    def uri
        "https://opentdb.com/#{@resource}?#{to_query}"
    end

    def to_query
        URI.encode_www_form(@options)
    end

    def get_data
        response = RestClient.get(uri)
        JSON.parse(response)
    end
end