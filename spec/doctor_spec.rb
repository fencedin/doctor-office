require 'spec_helper'

describe Doctor do
  it 'is initialized with a name' do
    doctor = Doctor.new('new_doctor')
    doctor.should be_an_instance_of Doctor
  end

  it 'should tell you its name' do
    doctor = Doctor.new('Dr. Bigglesworth')
    doctor.name.should eq 'Dr. Bigglesworth'
  end

  it 'starts with an empty array' do
    Doctor.all.should eq []
  end

  it 'lets you save a new doctor' do
    doctor = Doctor.new('Dr. Spaceman')
    doctor.save
    Doctor.all.should eq [doctor]
  end

  it 'is the same as another of the same name' do
    doctor1 = Doctor.new('Dr. Same')
    doctor2 = Doctor.new('Dr. Same')
    doctor1.should eq doctor2
  end
end
