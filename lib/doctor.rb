require 'pg'

class Doctor

  attr_reader :name

  def initialize(name)
    @name = name
  end

  def self.all
    results = DB.exec("SELECT * FROM doctors;")
    doctors = []
    results.each do |result|
      name = result['name']
      doctors << Doctor.new(name)
    end
    doctors
  end

  def save
    DB.exec("INSERT INTO doctors (name) VALUES ('#{name}');")
  end

  def ==(another_doctor)
    self.name == another_doctor.name
  end

end
