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
      save_students
    when "4"
      load_students
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
  print_footer
end

def input_students
  puts "Please enter the names of the students".center(CEN, ' ')
  puts "To finish, just hit return twice".center(CEN, ' ')

  name = STDIN.gets.gsub("\n","") # Using gsub instead of chomp

  while !name.empty? do
    cohort = get_cohort
    puts "What is #{name}'s country of birth".center(CEN, ' ')
    country_of_birth = STDIN.gets.chomp
    puts "What is #{name}'s height".center(CEN, ' ')
    height = STDIN.gets.chomp
    add_student(name, cohort, country_of_birth, height)
    puts "Now we have #{@students.count} student#{@students.count > 1 ? 's' : ''}".center(CEN, ' ')
    puts "Please provide student name or enter to exit".center(CEN, ' ')
    name = STDIN.gets.chomp
  end
end

def get_cohort # Recursion if wrong input detected
  puts "Please provide the cohort for this student".center(CEN, ' ')
  cohort = STDIN.gets.chomp.to_sym
  cohort = :July if cohort.empty? # Default cohort if input empty
  if !COHORT_SYMBOLS.include? cohort
    puts "Unrecognized cohort name..".center(CEN, ' ')
    cohort = get_cohort
  end
  return cohort
end

def add_student(name, cohort, country_of_birth, height)
  @students << {name: name, cohort: cohort,
                country_of_birth: country_of_birth, height: height}
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

def load_students(filename = "students.csv")
  file = File.open(filename, "r")
  file.readlines.each do |line|
    name, cohort, country_of_birth, height = line.chomp.split(',') # Parallel assignment :)
    add_student(name, cohort, country_of_birth, height)
  end
  file.close
end

def save_students
  file = File.open("students.csv", "w")

  @students.each do |student|
    student_data = [student[:name], student[:cohort], student[:country_of_birth],
                    student[:height]]
    csv_line = student_data.join(",")
    file.puts csv_line
  end
  file.close
end

def try_load_students
  filename = ARGV.first
  if filename.nil? # leave method if nil
    puts "Loading default students.csv file..."
    load_students
    return
  end
  if File.exists?(filename)
    load_students(filename)
    puts "Loaded #{@students.count} from #{filename}"
  else
    puts "Sorry, #{filename} doesn't exist."
    exit # exit program
  end
end

try_load_students
interactive_menu
