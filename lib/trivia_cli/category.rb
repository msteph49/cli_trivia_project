class Category 
    attr_accessor :id, :name 

    def initialize(id:, name:)
        @id = id
        @name = name
    end

    def self.from_opentdb
        categories = []

        api = API.new("api_category.php", options: {})

        data = api.get_data 

        data["trivia_categories"].each do |category|
            categories << self.new(id: category["id"], name: category["name"])
        end

        categories
    end
end