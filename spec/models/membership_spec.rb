require 'rails_helper'

describe Membership do

  it 'begins immediately on creation' do
    expect(Membership.register).to be_current
  end

  it 'ends after the start of the next calendar year' do
    membership = Membership.register
    allow(Date).to receive_messages(:today => Date.today + 1.year)
    expect(membership).to be_expired
  end

end
