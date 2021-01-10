# responsible for commuicating between user and data
require 'pry'


class CLI
    attr_accessor :amount, :category, :guesses
   
    def start
        api = API.new("api.php", options: {amount: 1})
        api.get_data

        puts "Welcome to CLI Trivia!"
        puts "So I know who is playing please tell me your name."
        # binding.pry
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
        # This array will be reliant on the instance of api calls
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
        menu #recursion, keeping the user looped in the program
    end
    def category_selection
        puts "Select a category" #possible duplicate, following along class presentation
        selection = user_input
        selection = selection.to_i
        # selection.to_i
        # binding.pry
        if selection == 0 || selection > Category.from_opentdb.count
            puts "You have entered an invalid response"
            category_selection
            else
                @category = Category.from_opentdb[selection -1].id
                puts "You have selected #{Category.from_opentdb[selection - 1].name}"
        end
        how_many_questions
        # query  trivia class 
        # Trivia.find_category(selection)
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
        # binding.pry
        questions = Question.from_opentdb(@amount, @category)
        questions.each_with_index do |question, index|
            puts question.question
            question.puts_answers
            
        end
    end
    def menu
        selection = user_input

        if selection == 'y' # || 'yes'
            trivia_categorie_list
            
            # print list of categories
        elsif selection == 'exit'
            # prompt goodbye message
            goodbye
        else 
            invalid
            # invalid output, make user select again
        end
    end
end