class Student

  attr_reader :name, :site

  STUDENTS = []

  def initialize(name, site)
    @name = name
    @site = add_http(site)



    STUDENTS << self
    # binding.pry
  end

  def add_http(site)
    unless site =~ /^https?:\/\//
      site.insert(0,"http://")
    end
    site
  end

  def self.all
    STUDENTS
  end

  def to_s
    longest = Student.longest_name_length
    # difference = 
    formatted_name = name.ljust(longest, " ")
    # binding.pry
    "#{formatted_name} | \t\t#{site}"
  end

  def self.longest_name_length
    longest = 0
    all.each do |student|
      longest = student.name.length if student.name.length > longest
    end
    longest
  end
end