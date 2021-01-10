require "URI"
require_relative "./trivia_cli/version"

require 'bundler'
Bundler.require

puts "in enviroment"


require_relative "./trivia_cli/cli"
require_relative "./trivia_cli/api"
# require_relative "./trivia_cli/trivia"
require_relative "./trivia_cli/questions"
require_relative "./trivia_cli/category"

# ./bin/run   in terminal runs the run file