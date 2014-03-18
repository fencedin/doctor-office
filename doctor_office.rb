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
  puts "Enter doctor full name:"
  name = gets.chomp
  puts "\nEnter doctor specialty:"
  specialty = gets.chomp
  new_doctor = Doctor.new(name, specialty)
  new_doctor.save
  main_menu

end
system "clear"
main_menu
