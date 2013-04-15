require 'spec_helper'

describe Member do

  it 'has a full name' do
    member = Member.new(first_name: 'Russell', last_name: 'Dunphy')
    member.full_name.should eq 'Russell Dunphy'
  end
end
