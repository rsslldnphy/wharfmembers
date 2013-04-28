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

  describe "#member_actions" do

    it "allows completion of pending members" do
      member = stub(pending?: true)
      helper.member_actions(member).should match /complete.*Complete Registration/
    end

    it "has no actions if the member is current" do
      member = stub(pending?: false, current?: true)
      helper.member_actions(member).should be_nil
    end

    it "allows renewal if the member is expired" do
      member = stub(pending?: false, current?: false)
      helper.member_actions(member).should match /renew.*Renew Membership/
    end
  end
end
