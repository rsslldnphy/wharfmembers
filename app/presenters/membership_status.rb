class MembershipStatus

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
    template.content_tag :span, class: "label label-warning" do
      "Pending"
    end
  end

  def current
    template.content_tag :span, class: 'label label-success' do
      'Current'
    end
  end

  def expired
    template.content_tag :span, class: 'label label-important' do
      'Expired'
    end
  end

  attr_reader :template, :member

end
