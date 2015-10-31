# This is the main entrypoint into the program
# It requires the other files/gems that it needs

require 'pry'
require './candidates'
require './filters'

## Your test code can go here

binding.pry

pp qualified_candidates(@candidates)

puts experienced?(@candidates[0]).inspect

puts "Enter candidate id: "
$name = gets.chomp
find(@candidates)
qualified_candidates(@candidates)
ordered_by_qualifications(@candidates)
repl_based_menu (@candidates)
