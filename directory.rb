require 'csv'

class StudentDirectory
  
  def initialize
    @students = []
    @cohorts = [:January, :February, :March, :April, :May, :June, :July, :August, :September, :October, :November, :December]
  end
    
  def add_students(name, cohort, hobby, country, height)
     @students << {name: name.capitalize, cohort: cohort.to_sym, hobby: hobby, country_of_birth: country, height: height}
  end
    
  def input_students
    puts "Please enter the names of the students"
    puts "To finish, just hit return twice"
    # get the first name
    name = STDIN.gets #input without chomp
    name.strip!
    # while the name is not empty, repeat this code
    while !name.empty? do
      # ask for cohort
      puts "Which cohort? (press enter for November)"
      cohort = ""
      loop do 
        # check for typo
        cohort = STDIN.gets.chomp.capitalize
        if @cohorts.include?(cohort.to_sym)
          break
        # assign default value
        elsif cohort.empty?
          cohort = "November"
          break
        # throw error
        else
          puts "You entered typo, try again"
        end
      end
      # ask additional details
      puts "Person hobby?"
      hobby = STDIN.gets.chomp
      puts "Country of birth?"
      country = STDIN.gets.chomp
      puts "Person height?"
      height = STDIN.gets.chomp
      # add the student hash to the array
      add_students(name, cohort, hobby, country, height)
      if @students.count == 1
        puts "Now we have #{@students.count} student"
      else
        puts "Now we have #{@students.count} students"
      end
      # get another name from the user
      name = STDIN.gets.chomp
    end
  end
  
  def find_student
    puts "Find students starting with specific letter"
    puts "Enter specific letter"
    letter = STDIN.gets.chomp.capitalize
    @students.each { |x| puts x[:name] if x[:name].chars.first == letter}
  end
  
  def students_less_than_12
    puts "Students with less than 12 characters long"
    @students.each { |x| puts x[:name] if x[:name].length <= 12 }
  end 
  
  def print_header
    # adding alignment
    puts "The students of Villains Academy".center(50)
    puts "-------------".center(50)
  end
  
  def group_cohort
    # display students by month
    puts "Sorted by month"
    @cohorts.each do |cohort|
      @students.each do |student|
        puts "#{student[:name]} (#{student[:cohort]} cohort)" if student[:cohort] == cohort
      end
    end
  end
  
  def nov_cohort
    # display students only from November by .select
    puts "Students from default month only"
    nov_student = @students.select { |student| student[:cohort] == :November }
    nov_student.each { |student| puts "#{student[:name]} (#{student[:cohort]} cohort)" }
  end
  
  def print_students_list
    # using while loop instead
    i = 0
    while i < @students.length
      puts "#{i.+(1)}. #{@students[i][:name]} (#{@students[i][:cohort]} cohort), hobby: #{@students[i][:hobby]}, place of birth: #{@students[i][:country_of_birth]}, height: #{@students[i][:height]}"
      i += 1
    end
  end
  
  def print_footer
    if @students.count == 1
      puts "Overall, we have #{@students.count} great student"
    else
      puts "Overall, we have #{@students.count} great students"
    end
  end
  
  def print_menu
    puts "1. Input the students"
    puts "2. Show the students"
    puts "3. Sort the students by cohort"
    puts "4. Show all current cohort students"
    puts "5. Find students by first letter"
    puts "6. Show all students with a name shorter than 12 characters"
    puts "7. Save the list to file"
    puts "8. Load the list from file"
    puts "9. Exit"
  end
  
  def process(selection)
    case selection
      when "1"
        input_students
      when "2"
        # all students
        show_students
      when "3"
        # students by month
        group_cohort if record_check
      when "4"
        # students from November
        nov_cohort if record_check
      when "5"
        # find student by first letter
        find_student if record_check
      when "6"
        # Students with less than 12 characters long
        students_less_than_12
      when "7"
        # save to file
        save_students if record_check
      when "8"
        load_students("Ask for file")
      when "9"
        exit
      else
        puts "I don't know what you mean, try again"
    end
  end
  
  def interactive_menu
    loop do
      print_menu
      process(STDIN.gets.chomp)
    end
  end
  
  def record_check
    # skip if no students
    if !@students.empty?
      return true
    else 
      puts "No students on the list"
    end
  end
  
  def show_students
    print_header
    print_students_list if record_check
    print_footer
  end
  
  def save_students
    puts "Input file name or press enter for default 'students.csv'"
    filename = STDIN.gets.chomp
    filename = "students.csv" if filename.empty?
    # open the file for writing
    CSV.open(filename, "w") do |csv|
    # iterate over the array of students
      @students.each do |student|
        csv << [student[:name], student[:cohort], student[:hobby], student[:country_of_birth], student[:height]]
      end
    end
    puts "File saved successfully" if File.exists?(filename)
  end
  
  def load_students(filename)
    if filename == "Ask for file"
      puts "Input file name or press enter for default 'students.csv'"
      filename = STDIN.gets.chomp
      filename = "students.csv" if filename.empty?
    end
    if File.exists?(filename)
      CSV.foreach(filename) do |row|
        name, cohort, hobby, country, height = row
        add_students(name, cohort, hobby, country, height)
      end
      puts "File loaded successfully"
    else
      puts "Sorry, #{filename} doesn't exist."
    end
  end
  
  def try_load_students
    filename = ARGV.first # first argument from the command line
    filename ||= "students.csv" # get out of the method if it isn't given
    if File.exists?(filename) # if it exists
      load_students(filename)
      puts "Loaded #{@students.count} from #{filename}"
    else # if it doesn't exist, inform but continue 
      puts "Sorry, #{filename} doesn't exist."
    end
  end

end

directory = StudentDirectory.new

directory.try_load_students
directory.interactive_menu

