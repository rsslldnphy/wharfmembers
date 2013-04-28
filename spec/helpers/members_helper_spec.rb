require 'spec_helper'

describe MembersHelper do
  describe "#membership_status" do

    it "displays if a member is pending" do
      member = stub(pending?: true)
      helper.membership_status(member).should eq "<span class=\"pending-member\">Pending</span>"
    end

    it "displays if a member is current" do
      member = stub(pending?: false, current?: true)
      helper.membership_status(member).should eq "<span class=\"current-member\">Current</span>"
    end

    it "displays if a member is expired" do
      member = stub(pending?: false, current?: false)
      helper.membership_status(member).should eq "<span class=\"expired-member\">Expired</span>"
    end
  end
end
