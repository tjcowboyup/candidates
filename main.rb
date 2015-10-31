# This is the main entrypoint into the program
# It requires the other files/gems that it needs

require 'pry'
require './candidates'
require './filters'

## Your test code can go here

binding.pry

pp qualified_candidates

#Takes in a candidate (hash)
#Returns true if the candidate has 2 years of experience or more
#Returns false otherwise
def experienced?
  puts @candidates[:years_of_experience] >= 2
 end

#Takes in an id
#Returns the candidate with that :id
#If there is no candidate with that id, it naturally returns nil
def find (candidate_id) 
  puts "Enter candidate id: "
  #name = gets.chomp
  puts @candidates.find{|candidate| candidate_id == candidate[:id]}
 end

#Takes in the collection of candidates
#Returns a subset of the candidates that meet the following criteria:
#Are experienced
#Have 100 or more Github points
#Know at least Ruby or Python
#Applied in the last 15 days
#Are over the age of 17 (18+)
def qualified_candidates (collection)
  match=[]
  
    collection.each do |x|
      if years_of_experience(x[:years_of_experience]) && github_points(x[:github_points]) && knowledge(x[:languages]) && applied_time(x[:date_applied]) && age_candidate(x[:age])
        match << (x)
      end
  end
end

def years_of_experience (year)
 year >= 2
end

def github_points (points)
  points >= 100
end

def knowledge (language)
  laguage = true if (language.to_s).match("Ruby")
  laguage = true if (language.to_s).match("Python")
end

def applied_time (day)
  (Time.now.to_date - day).to_i <= 15
end

def age_candidate (age)
  age > 18
end

#reordered such that:
#Candidates with the most experience are at the top
#For Candidates that have the same years of experience, they are further sorted by their number of Github points (highest first)
def ordered_by_qualifications (collection)
  collection.sort_by {|x| [x[:years_of_experience], x[:github_points]]}.reverse!
end
#Create a REPL that presents the user with a menu where they can type in one of the following commands:
#find 1: This will display candidate with id 1
#all: This will print them all out to the screen (one per line)
#qualified: This will print only qualified candidates, ordered by experience and points (one per line)
#quit: Exit the REPL / program
def repl_based_menu (collection)
  p "one of the following commands: "
  answer = gets.chomp
  case (answer)
  when ("find 1")
    puts find(1)
  when ("all")
     puts collection
  when ("qualified")
     puts ordered_by_qualifications(qualified_candidates(@candidates))
    else
      return
    nil
  end
end

experienced?
find(@candidates)
qualified_candidates(@candidates)
ordered_by_qualifications(@candidates)
repl_based_menu (@candidates)
