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
    "#{name}: \t#{site}"
  end



end