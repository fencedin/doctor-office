require 'pg'
require './lib/doctor'
require './lib/patient'
require './lib/specialty'

DB = PG.connect(:dbname => 'doctors_office')

def main_menu
  puts "To add a doctor, press 'd', to add a new patient, press 'p'\n"
  puts "For a list of doctors by name, press 'n', to list doctors by specialty, press 's'.\n"
  puts "For a list of patients for a specific doctor, press 'l'.\n"
  puts "To exit, press 'x'\n\n"
  entry = gets.chomp.downcase
  case entry
  when 'd'
    add_doctor
  when 'p'
    add_patient
  when 'n'
    list_doctors
  when 's'
    list_specialty
  when 'l'
    list_patients
  when 'x'
    puts "Thank you. Goodbye."
  else
    system "clear"
    main_menu
  end
end

def add_doctor
  puts "Enter doctors full name:"
  @name = gets.chomp
  @new_doctor = Doctor.new(@name)
  @new_doctor.save
  list_specialty
end

def list_specialty
  puts "\nHere is a list of current specialties.\n"
  results = DB.exec("SELECT * FROM specialties;")
    results.each do |result|
      puts result["name"]
    end
  puts "\nEnter the name of the specialty for this doctor, or enter 'n' for new specialty.\n"
  specialty = gets.chomp.upcase
  case specialty
  when 'n'
    new_specialty
  else
    id_result = DB.exec("SELECT * FROM specialties;")
      id_result.each do |result|
        if specialty == result['name']
          @id = result['id']
        else
        end
      end
    @new_doctor.save_id(@id, @name)
    main_menu
  end
end



 def new_specialty
  new_specialty = Specialty.new(specialty)
  new_specialty.save

  @new_doctor.save_id(@id, name)





end



system "clear"
main_menu
