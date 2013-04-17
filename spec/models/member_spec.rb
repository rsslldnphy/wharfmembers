require 'spec_helper'

describe Member do

  it 'has a full name' do
    member = Member.new(first_name: 'Russell', last_name: 'Dunphy')
    member.full_name.should eq 'Russell Dunphy'
  end

  it 'can return its full address as an array' do
    member = Member.new(address_one: '123 Street', address_two: 'Southport', postcode: 'AB1 234')
    member.address.should eq [
      '123 Street',
      'Southport',
      'AB1 234'
    ]
  end
end
