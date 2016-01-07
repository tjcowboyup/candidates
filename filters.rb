# In this file we define the methods to help filter out candidates
# This way, we keep these methods separated from other potential parts of the program

#Takes in a candidate (hash)
#Returns true if the candidate has 2 years of experience or more
#Returns false otherwise
def experienced?(candidate)
  candidate[:years_of_experience] >= 2
end

#Takes in an id
#Returns the candidate with that :id
#If there is no candidate with that id, it naturally returns nil
def find (candidate_id)
  @candidates.detect{|candidate| candidate_id == candidate[:id]}
  puts "No match foud" if nil 
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
    if years_of_experience(x[:years_of_experience]) && github_points(x[:github_points]) && knowledge(x[:languages]) && applied_time(x[:date_applied]) && old_enough(x[:age])
      match << (x)
    end
  end

  match
end

def years_of_experience (year)
 year >= 2
end

def github_points (points)
  points >= 100
end

def knowledge (language)
  (language.to_s).match("Python") && (language.to_s).match("Ruby")
end

def applied_time (day)
  (Time.now.to_date - day).to_i <= 15
end

def old_enough (age)
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
  answer = gets.chomp.split(' ')
  case (answer[0])
    when ("find")
      puts find(answer[1])
    when ("all")
      puts collection
    when ("qualified")
      puts ordered_by_qualifications(qualified_candidates(@candidates))
    when ("quit")
      return
    else
      return
    end
end
