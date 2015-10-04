require 'rails_helper'

describe MembersHelper do
  describe "#membership_status" do

    it "displays if a member is pending" do
      member = double(pending?: true)
      expect(helper.membership_status(member)).to match /Pending/
    end

    it "displays if a member is current" do
      member = double(pending?: false, current?: true)
      expect(helper.membership_status(member)).to match /Current/
    end

    it "displays if a member is expired" do
      member = double(pending?: false, current?: false)
      expect(helper.membership_status(member)).to match /Expired/
    end
  end

  describe "#member_actions" do

    it "has no actions if the member is pending" do
      member = double(pending?: true)
      expect(helper.member_actions(member)).to be_nil
    end

    it "has no actions if the member is current" do
      member = double(pending?: false, current?: true)
      expect(helper.member_actions(member)).to be_nil
    end

    it "allows renewal if the member is expired" do
      member = double(pending?: false, current?: false)
      expect(helper.member_actions(member)).to match /renew.*Renew Membership/
    end
  end
end
