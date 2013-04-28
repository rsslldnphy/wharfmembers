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

  it 'is a current member if it has a membership for this year' do
    year = Date.today.year
    member = Member.new(memberships: [Membership.new(year: year)])
    member.should be_current
  end

  it 'is not a current member if it does not have a membership for this year' do
    year = 2012
    member = Member.new(memberships: [Membership.new(year: year)])
    member.should_not be_current
  end

  it 'is a pending member if it has no memberships' do
    member = Member.new
    member.should be_pending
  end

  it 'is not a pending member if it has memberships' do
    member = Member.new(memberships: [Membership.new])
    member.should_not be_pending
  end

end
