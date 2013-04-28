module MembersHelper

  def membership_status(member)
    MembershipStatus.new(self, member).render
  end

end
