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

  let (:member) { Member.new }

  it 'starts off as a pending member' do
    member.should be_pending
    member.should_not be_expired
    member.should_not be_current
  end

  it 'can be completed' do
    member.complete
    member.should_not be_pending
    member.should be_current
    member.should_not be_expired
  end

  it 'is a current member immediately once renewed' do
    member.renew
    member.should be_current
    member.should_not be_expired
  end

  it 'becomes an expired member after the end of the calendar year' do
    member.renew
    Date.stub(today: Date.today + 1.year)
    member.should be_expired
    member.should_not be_current
  end

  it 'should not expire if lifetime member' do
    member.renew
    member.lifetime_membership = true
    Date.stub(today: Date.today + 15.year)
    member.should be_current
    member.should_not be_expired
  end
end
