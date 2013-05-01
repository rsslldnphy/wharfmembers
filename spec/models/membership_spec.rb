require 'spec_helper'

describe Membership do

  it 'begins 48 hours after registration' do
    Membership.registration.should be_pending
  end

  it 'begins immediately after renewal' do
    Membership.renewal.should be_current
  end

  it 'ends after the start of the next calendar year' do
    m = Membership.renewal
    Date.stub(today: Date.today + 1.year)
    m.should be_expired
  end

end
