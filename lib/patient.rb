require 'pg'

class Patient

  attr_reader :name, :dob

  def initialize(name, dob)
    @name = name
    @dob = dob
  end

  def self.all
    results = DB.exec("SELECT * FROM patients;")
    patients = []
    results.each do |result|
      name = result['name']
      dob = result['dob']
      patients << Patient.new(name, dob)
    end
    patients
  end

  def save
    DB.exec("INSERT INTO patients (name, dob) VALUES ('#{name}', '#{dob}');")
  end

  def ==(another_patient)
    self.name == another_patient.name && self.dob == another_patient.dob
  end

  def save_id(id, name)
    DB.exec("UPDATE patients SET doctor_id = #{id} WHERE name = '#{name}';")
  end

end
