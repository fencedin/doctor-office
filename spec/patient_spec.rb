require 'spec_helper'

describe Patient do
  it 'is initialized with a name and dob' do
    patient = Patient.new('new_patient', '1981-07-20')
    patient.should be_an_instance_of Patient
  end

  it 'should tell you its name' do
    patient = Patient.new('Samwise Gamgee', '1773-04-01')
    patient.name.should eq 'Samwise Gamgee'
    patient.dob.should eq '1773-04-01'
  end

  it 'starts with an empty array' do
    Patient.all.should eq []
  end

  it 'lets you save a new patient' do
    patient = Patient.new('George Foreman', '1956-08-30')
    patient.save
    Patient.all.should eq [patient]
  end

  it 'is the same as another of the same name' do
    patient1 = Patient.new('Vincent Kartheiser', '1979-03-23')
    patient2 = Patient.new('Vincent Kartheiser', '1979-03-23')
    patient1.should eq patient2
  end
end
