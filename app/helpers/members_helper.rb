module MembersHelper

  def membership_status(member)
    MembershipStatus.new(self, member).render
  end

  def member_actions(member)
    MemberActions.new(self, member).render
  end
end
