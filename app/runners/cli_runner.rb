require_relative '../../config/environment'
require "open-uri"
require "json"

class CLIRunner
  attr_accessor :query, :flags

  def initialize
    @flags = {}
  end

  def call
    `say -v Moira "Hello"`
    puts ""
    puts "Welcome to Flatiron Students"
    run
  end

  def get_user_input
    gets.chomp.strip
  end

  def run
    scraper = create_scraper
    scraper.run
    students = Student.all
    display_students(students)
    # binding.pry
    input = student_choice
    if input.match(/^\d+$/)
      open_page(students[input.to_i - 1].site)
    else

    end
    #make sure its a number and in range
  end

  def create_scraper
    FlatironScraper.new
  end

  def display_students(student_array)
    puts `clear`
    student_array.each_with_index do |student, i|
      puts "#{i + 1}. #{student.to_s}"
    end
    puts ""
  end

  def help
    puts `clear`
    puts "Type 'exit' to exit"
    puts "Type 'help' to view this menu again"
    puts "Type 'question (question here)' to search for a question"
    puts "Type 'question -f (question here)' to search for the first question"
    puts "Type 'question -t (your tag here) -q (question here)' to search for a question with your tag"
    puts "Type 'question -f -t (your tag here) -q (question here)' to search for the first question with your tag"
  end

  def exit
    puts `clear`
    puts "Goodbye"
  end

  def student_choice
    puts "Type in number of what student's blog you'd like to view:"
    get_user_input
  end

  def open_page(url)
    `open #{url}`
  end
end