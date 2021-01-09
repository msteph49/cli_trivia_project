

class Trivia

    @@all = []
    attr_accessor :category, :name# , type: :questions, :correct_answer :incorrect_answers, :difficulty
    def initialize(trivia_hash)
        trivia_hash.each do |k, v|
            self.send("#{k}=",v) if self.respond_to?("#{k}=")  # interpilate the "k" so we can add the writer to it with equal sign
        end
        save
     
    end
    def save
        @@all << self
    end
    def self.all
        @@all
    end
    # Method the accepts category name and find object with that name
    # taken for class instruction, may need to be tweeked to get it to work
    # with API
    def self.find_category(category)
        self.all.find do |c|
            c.name == category_name
        end
    end
end