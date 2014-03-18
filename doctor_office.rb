require 'pg'
require './lib/doctor'
require './lib/patient'
require './lib/specialty'

DB = PG.connect(:dbname => 'doctors_office')

def main_menu
  puts "To add a doctor, press 'd', to add a new patient, press 'p'\n"
  puts "For a list of doctors and their specialties, press 'n'. To search for a doctor by specialty, press 's'.\n"
  puts "For a list of patients with their doctors, press 'l'.\n"
  puts "To exit, press 'x'\n\n"
  entry = gets.chomp.downcase
  case entry
  when 'd'
    add_doctor
  when 'p'
    add_patient
  when 'n'
    list_doctors
    gets.chomp
    system "clear"
    main_menu
  when 's'
    search_specialty
    gets.chomp
    system "clear"
    main_menu
  when 'l'
    list_patients
    gets.chomp
    system "clear"
    main_menu
  when 'x'
    system "clear"
    puts "Thank you. Goodbye.\n\n"
  else
    system "clear"
    main_menu
  end
end

def add_doctor
  puts "Enter doctors full name:"
  @doctor_name = gets.chomp.upcase
  @new_doctor = Doctor.new(@doctor_name)
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
  id_result = DB.exec("SELECT * FROM specialties;")
  id_result.each do |result|
    if specialty == result['name']
      @pass = true
    end
  end
  if @pass == true
    case specialty
    when 'N'
      new_specialty
    else
      id_result = DB.exec("SELECT * FROM specialties;")
      id_result.each do |result|
        if specialty == result['name']
          @specialty_id = result['id']
        else
        end
      end
      @new_doctor.save_id(@specialty_id, @doctor_name)
      system "clear"
      main_menu
    end
  else
    puts "That is not a valid entry.\n\n"
    list_specialty
  end
end

def new_specialty
  puts "\nEnter name of specialty: "
  specialty = gets.chomp.upcase
  new_specialty = Specialty.new(specialty)
  new_specialty.save

  id_result = DB.exec("SELECT * FROM specialties;")
  id_result.each do |result|
    if specialty == result['name']
      @specialty_id = result['id']
    else
    end
  end
  @new_doctor.save_id(@specialty_id, @doctor_name)
  system "clear"
  main_menu
end

def list_doctors
  puts "Here is a directory of doctors with their specialty.\n\n"
  results = DB.exec("SELECT * FROM doctors ORDER BY name;")
  results.each do |result|
    specs = DB.exec("SELECT * FROM specialties ORDER BY name;")
    specs.each do |spec|
      if result["specialty_id"] == spec["id"]
        puts "\t" + result["name"] + ": " + spec["name"]
      end
    end
  end
end

def add_patient
  puts "Enter new patient name: "
  @patient_name = gets.chomp.upcase
  puts "Enter patient's date of birth (2001-02-31) "
  dob = gets.chomp
  @new_patient = Patient.new(@patient_name, dob)
  @new_patient.save
  get_doctor
end

def get_doctor
  list_doctors
  puts "Which doctor is this patient being assigned to?"
  patient_doctor = gets.chomp.upcase
  id_result = DB.exec("SELECT * FROM doctors;")
  id_result.each do |result|
    if patient_doctor == result['name']
      @pass = true
    end
  end
  if @pass == true
    id_result = DB.exec("SELECT * FROM doctors;")
    id_result.each do |result|
      if patient_doctor == result['name']
        @doctor_id = result['id']
      else
      end
    end
    @new_patient.save_id(@doctor_id, @patient_name)
    system "clear"
    main_menu
  else
    system "clear"
    get_doctor
  end
end

def list_patients
  puts "Here is a directory of patients with their doctors.\n\n"
  results = DB.exec("SELECT * FROM patients ORDER BY name;")
  results.each do |result|
    specs = DB.exec("SELECT * FROM doctors ORDER BY name;")
    specs.each do |spec|
      if result["doctor_id"] == spec["id"]
        puts "\t" + result["name"] + " (" + result["dob"] + ") : " + spec["name"]
      end
    end
  end
end

def search_specialty
  puts "Here is a directory of all doctors by specialty.\n\n"
  specs = DB.exec("SELECT * FROM specialties ORDER BY name;")
  specs.each do |spec|
    results = DB.exec("SELECT * FROM doctors ORDER BY name;")
    results.each do |result|
      if result["specialty_id"] == spec["id"]
        puts "\t" + spec["name"] + " :" + result["name"]
      end
    end
  end
end

system "clear"
main_menu
