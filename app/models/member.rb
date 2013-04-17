class Member
  include Mongoid::Document
  include Mongoid::Search

  field :membership_number, type: Integer
  field :first_name, type: String
  field :last_name, type: String
  field :email, type: String
  field :phone, type: String
  field :address_one, type: String
  field :address_two, type: String
  field :address_three, type: String
  field :postcode, type: String
  field :email_allowed, type: Boolean

  validates_presence_of :first_name, :last_name

  search_in *[
    :first_name,
    :last_name,
    :address_one,
    :address_two,
    :address_three,
    :post_code
  ]

  def full_name
    "#{first_name} #{last_name}"
  end

  def address
    [address_one, address_two, address_three, postcode].compact
  end

end
