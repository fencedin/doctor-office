require 'spec_helper'

describe Insurance do
  it 'is initialized with a name' do
    insurance = Insurance.new('new_insurance')
    insurance.should be_an_instance_of Insurance
  end

  it 'should tell you its name' do
    insurance = Insurance.new('Oncology')
    insurance.name.should eq 'Oncology'
  end

  it 'starts with an empty array' do
    Insurance.all.should eq []
  end

  it 'lets you save a new insurance' do
    insurance = Insurance.new('General Practice')
    insurance.save
    Insurance.all.should eq [insurance]
  end

  it 'is the same as another of the same name' do
    insurance1 = Insurance.new('Labor and Delivery')
    insurance2 = Insurance.new('Labor and Delivery')
    insurance1.should eq insurance2
  end
end
