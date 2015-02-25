# Scrape Flatiron Students page
# Get urls for each student's page
# Scrape each student's page getting url for their blogs
# Print that shit
require_relative  '../models/student.rb'
require 'nokogiri'
require 'open-uri'
require 'pry'

class FlatironScraper
  attr_reader :url

  def initialize
    @url = "http://fellows.flatironschool.com"
  end

  def run
    new_array = []
    html = open_page(url).read
    nokogiri = Nokogiri::HTML(html)
    links = nokogiri.css(".blog-thumb>a")
    links = links.map do |link|
      link.values
    end.flatten
      
   blogs = links.map do |student_link|
    new_student_link = "#{@url}/#{student_link}"
    html = open_page(new_student_link).read
    nokogiri = Nokogiri::HTML(html)
    links = nokogiri.css("\#ok-text-column-3 .services>p>a")
     v = links.map do |link|
      link.values

      # binding.pry

    end.flatten
    new_array << v[0]
    students_name = student_link.gsub('.html', '')
    new_student_name = students_name.gsub('students/', '')
    new_student_name = new_student_name.gsub("_", " ").
    split(" ").map { |name| name.capitalize }.
    join(" ")

    create_student(new_student_name, v[0])
   end
  end

  def create_student(name, site)
    Student.new(name, site)
  end



  def open_page(url)
    open(url)
  end
end