require 'spec_helper'

describe Specialty do
  it 'is initialized with a name' do
    specialty = Specialty.new('new_specialty')
    specialty.should be_an_instance_of Specialty
  end

  it 'should tell you its name' do
    specialty = Specialty.new('Oncology')
    specialty.name.should eq 'Oncology'
  end

  it 'starts with an empty array' do
    Specialty.all.should eq []
  end

  it 'lets you save a new specialty' do
    specialty = Specialty.new('General Practice')
    specialty.save
    Specialty.all.should eq [specialty]
  end

  it 'is the same as another of the same name' do
    specialty1 = Specialty.new('Labor and Delivery')
    specialty2 = Specialty.new('Labor and Delivery')
    specialty1.should eq specialty2
  end
end
