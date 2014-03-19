require 'pg'

class Specialty

  attr_reader :name

  def initialize(name)
    @name = name
  end

  def self.all
    results = DB.exec("SELECT * FROM specialties;")
    specialties = []
    results.each do |result|
      name = result['name']
      specialties << Specialty.new(name)
    end
    specialties
  end

  def save
    DB.exec("INSERT INTO specialties (name) VALUES ('#{name}');")
  end

  def ==(another_specialty)
    self.name == another_specialty.name
  end

end

#look at refactoring self.all to include RETURNING id with
#@id = results.first['id'].to_i
