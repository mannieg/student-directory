@students = []
COHORT_SYMBOLS = [:January, :February, :March, :April, :May, :June, :July,
                  :August, :September, :October, :November, :December]
=begin
  Center text alignment for console output
  Need to work on aligment, and make it more readable.
=end

def interactive_menu
  loop do
    print_menu
    process(STDIN.gets.chomp)
  end
end

def process(selection)
  case selection
    when "1"
      input_students
    when "2"
      show_students
    when "3"
      puts "Optionally provide file name to save"
      save_students(STDIN.gets.chomp)
    when "4"
      puts "Optionally provide file name to load "
      get_input_file(STDIN.gets.chomp)
    when "9"
      exit
    else
      puts "I don't know what you mean, try again"
    end
  end

def print_menu
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Save the list to students.csv"
  puts "4. Load the list from students.csv"
  puts "9. Exit"
end

def show_students
  print_header
  print_students_list
  student_count
end

def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"

  name = STDIN.gets.gsub("\n","") # Using gsub instead of chomp

  while !name.empty? do
    cohort = get_cohort
    puts "What is #{name}'s country of birth"
    country_of_birth = STDIN.gets.chomp
    puts "What is #{name}'s height"
    height = STDIN.gets.chomp
    add_student(name, cohort, country_of_birth, height)
    student_count
    puts "Please provide student name or enter to exit"
    name = STDIN.gets.chomp
  end
end

def get_cohort # Recursion if wrong input detected
  puts "Please provide the cohort for this student"
  cohort = STDIN.gets.chomp.to_sym
  cohort = :July if cohort.empty? # Default cohort if input empty
  if !COHORT_SYMBOLS.include? cohort
    puts "Unrecognized cohort name.."
    cohort = get_cohort
  end
  return cohort
end

def add_student(name, cohort, country_of_birth, height)
  @students << {name: name, cohort: cohort,
                country_of_birth: country_of_birth, height: height}
end

def print_header
    puts 'The students of Villains Academy'
    puts '-------------'
end

def print_students_list
  if(@students.length > 0)
    by_cohort = @students.group_by{|s| s[:cohort]}.each{|_,n| n.map!{|n| n[:name]}}
    by_cohort.each do |cohort, arr| # loops through grouped hash
      puts "The #{cohort} cohort has:"
      arr.each {|name| puts "#{name}"} # loops through nested array
    end
  end
end

def student_count
    puts "Overall, we have #{@students.count} great student#{@students.count > 1 ? 's' : ''}"
end

def load_students(filename = "students.csv")
  File.open(filename, "r") do |file|
    file.readlines.each do |line|
      name, cohort, country_of_birth, height = line.chomp.split(',') # Parallel assignment :)
      add_student(name, cohort, country_of_birth, height)
    end
  end
  puts "#{filename} has been loaded into memory"
end

def save_students(filename = "students.csv")
  File.open(filename, "w") do |file|
    @students.each do |student|
      student_data = [student[:name], student[:cohort], student[:country_of_birth],
                    student[:height]]
      csv_line = student_data.join(",")
      file.puts csv_line
    end
  end
  puts "#{filename} has been saved.."
end

def get_argument
  filename = ARGV.first
  get_input_file(filename)
end

def get_input_file(filename)
  if filename.nil? # leave method if nil
    puts "Loading default students.csv file..."
    load_students
    return
  end
  if File.exists?(filename)
    load_students(filename)
    puts "Loaded #{@students.count} from #{filename}"
  else
    puts "Sorry, #{filename} doesn't exist. Exiting program.."
    exit # exit program
  end
end

get_argument
interactive_menu
