require 'pg'

class Insurance

  attr_reader :name

  def initialize(name)
    @name = name
  end

  def self.all
    results = DB.exec("SELECT * FROM insurance;")
    insurances = []
    results.each do |result|
      name = result['name']
      insurances << Insurance.new(name)
    end
    insurances
  end

  def save
    DB.exec("INSERT INTO insurance (name) VALUES ('#{name}');")
  end

  def ==(another_insurance)
    self.name == another_insurance.name
  end

end


#look at refactoring self.all to include RETURNING id with
#@id = results.first['id'].to_i
