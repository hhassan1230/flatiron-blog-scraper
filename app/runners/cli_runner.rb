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
    input = ""
    while input != "0"
      input = student_choice
      if input.match(/^\d+$/)
        open_page(students[input.to_i - 1].site) if students[input.to_i - 1] && input.to_i != 0
      else

      end
    end
    exit
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

  def exit
    puts `clear`
    puts "Goodbye"
  end

  def student_choice
    puts "Type in number of what student's blog you'd like to view (or 0 to quit):"
    get_user_input
  end

  def open_page(url)
    `open #{url}`
  end
end