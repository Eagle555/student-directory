def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
  # create an empty array
  @cohorts = [:January, :February, :March, :April, :May, :June, :July, :August, :September, :October, :November, :December]
  students = []
  # get the first name
  name = gets #input without chomp
  name.strip!
  # while the name is not empty, repeat this code
  while !name.empty? do
    # ask for cohort
    puts "Which cohort? (press enter for November)"
    loop do 
      # check for typo
      @cohort = gets.chomp.capitalize.to_sym
      if @cohorts.include?(@cohort)
        break
      # assign default value
      elsif @cohort.empty?
        @cohort = :November
        break
      # throw error
      else
        puts "You entered typo, try again"
      end
    end
    # ask aditional details
    puts "Person hobby?"
    hobby = gets.chomp
    puts "Country of birth?"
    country = gets.chomp
    puts "Person height?"
    height = gets.chomp
    # add the student hash to the array
    students << {name: name, cohort: @cohort, hobby: hobby, country_of_birth: country, height: height }
    if students.count == 1
      puts "Now we have #{students.count} student"
    else
      puts "Now we have #{students.count} students"
    end
    # get another name from the user
    name = gets.chomp
  end
  # return the array of students
  students
end

def find_student(students)
  puts "Find students starting with specific letter"
  puts "Enter specific letter"
  letter = gets.chomp
  students.each { |x| puts x[:name] if x[:name].chars.first == letter}
end

def students_less_than_12(students)
  puts "Students with less than 12 characters long"
  students.each { |x| puts x[:name] if x[:name].length <= 12 }
end 

def print_header
  # adding alignment
  puts "The students of Villains Academy".center(50)
  puts "-------------".center(50)
end

def group_cohort(students)
  # display students by month
  puts "Sorted by month"
  @cohorts.each do |cohort|
    students.each do |student|
      puts "#{student[:name]} (#{student[:cohort]} cohort)" if student[:cohort] == cohort
    end
  end
  # display students only from November
  puts "Students from default month only"
  students.select! { |student| student[:cohort] == :November }
  students.each { |student| puts "#{student[:name]} (#{student[:cohort]} cohort)" }
end

def print(students)
  # using while loop instead
  i = 0
  while i < students.length
    puts "#{i.+(1)}. #{students[i][:name]} (#{students[i][:cohort]} cohort), #{students[i][:hobby]}, #{students[i][:country_of_birth]}, #{students[i][:height]}"
    i += 1
  end
  
=begin
  students.each do |student|
    puts "#{students.index(student).+(1)}. #{student[:name]} (#{student[:cohort]} cohort)"
  end
=end
  
end

def print_footer(names)
  if names.count == 1
    puts "Overall, we have #{names.count} great student"
  else
    puts "Overall, we have #{names.count} great students"
  end
end

#nothing happens until we call the methods
students = input_students
print_header
print(students)
group_cohort(students)
print_footer(students)
# find student by first letter
find_student(students)
# Students with less than 12 characters long
students_less_than_12(students)