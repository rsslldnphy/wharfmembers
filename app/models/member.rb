class Member
  include Mongoid::Document
  include Mongoid::Timestamps
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
  field :email_allowed, type: Boolean, default: true
  embeds_many :memberships

  validates_presence_of :first_name, :last_name
  validates_uniqueness_of :membership_number

  before_create do
    self.membership_number = Sequence.next("membership_number")
  end

  search_in *[
    :first_name,
    :last_name,
    :address_one,
    :address_two,
    :address_three,
    :post_code
  ]

  def self.search(text, allow_empty_search=true)
    full_text_search(text, allow_empty_search: allow_empty_search)
  end

  def complete
    memberships.create(year: current_year)
  end

  def renew
    if current? then memberships.create(year: current_year + 1)
    else memberships.create(year: current_year) end
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def address
    [address_one, address_two, address_three, postcode].compact
  end

  def pending?
    memberships.empty?
  end

  def current?
    has_membership_for? current_year
  end

  def has_membership_for?(year)
    memberships.any? { |m| m.year == year }
  end

  private

  def current_year
    Date.today.year
  end

  def self.pending
    self.or({ :memberships.exists => false}, {:memberships.with_size => 0})
  end

end
