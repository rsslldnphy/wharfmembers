class MemberActions

  def initialize(template, member)
    @template = template
    @member = member
  end

  def render
    case member
    when ~:pending? then pending
    when ~:current? then current
    else expired end
  end

  private

  def pending
    template.link_to "Complete Registration", template.complete_member_path(member), class: 'btn'
  end

  def current
    # no need for any actions
  end

  def expired
    template.link_to "Renew Membership", template.renew_member_path(member), class: 'btn'
  end

  attr_reader :template, :member

end
