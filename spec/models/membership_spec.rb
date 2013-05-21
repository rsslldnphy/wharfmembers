require 'spec_helper'

describe Membership do

  it 'begins immediately on creation' do
    Membership.register.should be_current
  end

  it 'ends after the start of the next calendar year' do
    m = Membership.register
    Date.stub(today: Date.today + 1.year)
    m.should be_expired
  end

end
