def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"

  students = []
  cohort_symbols = [:January, :February, :March, :April, :May, :June, :July,
                    :August, :September, :October, :November, :December]

  name = gets.chomp

  while !name.empty? do
    puts "What is #{name}'s country of birth"
    country_of_birth = gets.chomp
    puts "What is #{name}'s height"
    height = gets.chomp
    puts "What is #{name}'s hobbies"
    hobbies = gets.chomp
    students << {name: name, cohort: :november, country_of_birth: country_of_birth,
                  height: height, hobbies: hobbies}

    puts "Now we have #{students.count} student#{students.count > 1 ? 's' : ''}"
    puts "Please provide student name or enter to exit"
    name = gets.chomp
  end
  students
end

def print_header
    puts 'The students of Villains Academy'
    puts '-------------'
end

def print(students)
    i = 0
    until i >= students.length
        puts "#{i}.#{students[i][:name]} (#{students[i][:cohort]} cohort) -- #{students[i][:country_of_birth]}" if students[i][:name].length < 12
        i += 1
    end
end

def print_footer(students)
    puts "Overall, we have #{students.count} great student#{students.count > 1 ? 's' : ''}"
end

students = input_students
print_header
print(students)
print_footer(students)
