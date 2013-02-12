class Member
  include Mongoid::Document
  field :membership_number, type: Integer
  field :first_name, type: String
  field :last_name, type: String
  field :email, type: String
end
