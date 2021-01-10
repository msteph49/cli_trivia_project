

class Question
    attr_accessor :question, :correct_answer, :incorrect_answer
    attr_reader :answers
    def initialize(question, correct_answer, incorrect_answer)
        @question = question
        @correct_answer = correct_answer
        @incorrect_answer = incorrect_answer
        @answers = [incorrect_answer + [correct_answer]].flatten.shuffle
    end
   
    def puts_answers
        puts "Select your answer"
        @answers.each_with_index do |answer, index|
            puts "#{index + 1}: #{answer}"
        end
    end

    def guesses(index)
        answers[index] == correct_answer
    end
    def self.from_opentdb(amount, category) # 
        questions = []
    
        api = API.new("api.php", options: {amount: amount, category: category})
    
        json = api.get_data()
    
        json["results"].each do |question|
          questions << self.new(
            question["question"], 
            question["correct_answer"],
            question["incorrect_answers"]
          )
        end
    
        questions
    
    end

end
