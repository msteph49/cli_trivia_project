

class Question
    attr_accessor :question, :correct_answer, :incorrect_answer
    attr_reader :answers
    def initialize(question, correct_answer, incorrect_answer)
        @question = question
        @correct_answer = correct_answer
        @incorrect_answer = incorrect_answer
        @answers = [[correct_answer] + incorrect_answer].flatten.shuffle
    end
   
    def puts_answers
        puts "Select your answer"
        @answers.each_with_index do |answer, index|
            puts "#{index + 1}: #{answer}"
        end
    end
    def self.get_data

    end
end
