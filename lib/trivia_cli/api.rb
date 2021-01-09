# https://opentdb.com/api.php?amount=10

# responsible for making a call to api
# getting the data necessary
# creating new Ruby objects with that data => Object oriented

# trivia_array["results"][0]["type"]
require 'pry'
class API

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


        # trivia_array = JSON.parse(response)["results"]
        # trivia_array.each do |trivia|
        #     Trivia.new(trivia)
        
        # end
        # binding.pry
    end
end