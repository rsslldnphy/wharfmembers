class Membership
  include Mongoid::Document

  field :year
  embedded_in :member

end
