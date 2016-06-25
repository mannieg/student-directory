@students = []
COHORT_SYMBOLS = [:January, :February, :March, :April, :May, :June, :July,
                  :August, :September, :October, :November, :December]
CEN = 50
=begin
  Center text alignment for console output
  Need to work on aligment, and make it more readable.
=end

def interactive_menu
  loop do
    print_menu
    process(gets.chomp)
  end
end

def process(selection)
  case selection
    when "1"
      input_students
    when "2"
      show_students
    when "9"
      exit
    else
      puts "I don't know what you mean, try again"
    end
  end

def print_menu
  puts "1. Input the students"
  puts "2. Show the students"
  puts "9. Exit"
end

def show_students
  print_header
  print_students_list
  print_footer
end

def input_students
  puts "Please enter the names of the students".center(CEN, ' ')
  puts "To finish, just hit return twice".center(CEN, ' ')

  name = gets.gsub("\n","") # Using gsub instead of chomp

  while !name.empty? do
    cohort = get_cohort
    puts "What is #{name}'s country of birth".center(CEN, ' ')
    country_of_birth = gets.chomp
    puts "What is #{name}'s height".center(CEN, ' ')
    height = gets.chomp
    puts "What is #{name}'s hobbies".center(CEN, ' ')
    hobbies = gets.chomp
    @students << {name: name, cohort: cohort, country_of_birth: country_of_birth,
                  height: height, hobbies: hobbies}

    puts "Now we have #{@students.count} student#{@students.count > 1 ? 's' : ''}".center(CEN, ' ')
    puts "Please provide student name or enter to exit".center(CEN, ' ')
    name = gets.chomp
  end
end

def get_cohort # Recursion if wrong input detected
  puts "Please provide the cohort for this student".center(CEN, ' ')
  cohort = gets.chomp.to_sym
  cohort = :July if cohort.empty? # Default cohort if input empty
  if !COHORT_SYMBOLS.include? cohort
    puts("Unrecognized cohort name..").center(CEN, ' ')
    get_cohort
  end
  return cohort
end

def print_header
    puts 'The students of Villains Academy'.center(CEN, ' ')
    puts '-------------'.center(CEN, ' ')
end

def print_students_list
  if(@students.length > 0)
    by_cohort = @students.group_by{|s| s[:cohort]}.each{|_,n| n.map!{|n| n[:name]}}
    by_cohort.each do |cohort, arr| # loops through grouped hash
      puts "The #{cohort} cohort has:".center(CEN, ' ')
      arr.each {|name| puts "#{name}".center(CEN, ' ')} # loops through nested array
    end
  end
end

def print_footer
    puts "Overall, we have #{@students.count} great student#{@students.count > 1 ? 's' : ''}".center(CEN, ' ')
end

interactive_menu
