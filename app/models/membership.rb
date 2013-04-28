class Membership
  include Mongoid::Document
  include Mongoid::Timestamps

  field :year
  embedded_in :member

  def to_s
    "Year: #{year}\tRegistered on: #{created_at.strftime('%d-%m-%Y')}"
  end

end
