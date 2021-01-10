

class CLI
    attr_accessor :amount, :category
    def initialize
        @guesses = []
    end
    def start
        api = API.new("api.php", options: {amount: 1})
        api.get_data

        puts "Welcome to CLI Trivia!"
        puts "So I know who is playing please tell me your name."
        
        greet(user_input)
    end
    def user_input
        gets.strip
    end
    def greet(name)
        puts "Hi #{name.capitalize}, lets get started"
        puts "We have several fun categories for you to choose from, would you like to see a menu?"
        puts "Input 'y' to see the list, if at any point you want to leave the app type 'exit'"
        menu
    end
    def trivia_categorie_list
        
        Category.from_opentdb.each.with_index(1) do |category, i|
            puts "#{i}. #{category.name}"
        end
        category_selection
    end
    def goodbye
        puts "Bye for now."
    end
    def invalid
        puts "Invalid input, please try again"
        menu 
    end
    def category_selection
        puts "Select a category" 
        selection = user_input
        selection = selection.to_i

        if selection == 0 || selection > Category.from_opentdb.count
            puts "You have entered an invalid response"
            category_selection
            else
                @category = Category.from_opentdb[selection -1].id
                puts "You have selected #{Category.from_opentdb[selection - 1].name}"
        end
        how_many_questions

    end
    def how_many_questions
        puts "How many questions would you like to answer, please enter a number 5-10"
        selection = user_input
        if selection == "exit"
            goodbye
        elsif selection.to_i < 5 || selection.to_i > 10
            puts "You have entered an invalid response, please try again."
            how_many_questions
        else
            @amount = selection
            puts "You have selected #{selection} questions"
        end
        make_questions
    end
    def make_questions
        
        questions = Question.from_opentdb(@amount, @category)
        questions.each_with_index do |question, index|
            puts question.question
            question.puts_answers
            check_answer(question)
        end
        results
    end
    def check_answer(question)

        user_answer = user_input
        user_answer = user_answer.to_i
    
    
        if user_answer <= 0 || user_answer > question.answers.size
    
            puts "Invalid"
            check_answer(question)
            return 
        end
        
        guess = question.guesses(user_answer -1)
    
        @guesses << guess
        if guess == true
            puts "Your guess was correct"
        else
        puts "Incorrect.The correct answer was #{question.correct_answer}"
        end
        
    end
    def results

        if 100 / @amount.to_i * @guesses.count(true) == 100
            puts "Great Job! You got a perfect score!!!"
        elsif 100 / @amount.to_i * @guesses.count(true) < 100 && @amount.to_i * @guesses.count(true) >= 80
            puts "Good Job! You got #{@gusses.count(true)} out of #{@amount} correct!"
        elsif 100 / @amount.to_i * @guesses.count(true) < 80 && @amount.to_i * @guesses.count(true) >= 60
            puts "Not bad. You got #{@gusses.count(true)} out of #{@amount} correct." 
        else 100 / @amount.to_i * @guesses.count(true) < 60 && @amount.to_i * @guesses.count(true) >= 0
            puts "You got #{@guesses.count(true)} out of #{@amount} correct. Try again and improve your score next time!"
        end
        play_again
    end
    def play_again
        puts "Would you like to play again, enter 'y' to play again or 'exit' to end game"
        response = user_input
        response = response.downcase
        if response == "y"
        puts "restarting..."
        @guesses.clear
        @amount = 0
        start
        elsif response == "exit"
            goodbye
        else
            puts "You have entered an invalid response please try again."
            play_again
        end
    end

    def menu
        selection = user_input
        selection = selection.downcase

        if selection == 'y' # || 'yes'
            trivia_categorie_list
        elsif selection == 'exit'
            goodbye
        else 
            invalid
            
        end
    end
end