class Member
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Search

  field :no, type: Integer
  field :first_name, type: String
  field :last_name, type: String
  field :email, type: String
  field :address_one, type: String
  field :address_two, type: String
  field :address_three, type: String
  field :postcode, type: String
  field :notes, type: String
  field :email_allowed, type: Boolean, default: true

  embeds_many :memberships, cascade_callbacks: true

  index({ no: 1 }, unique: true)

  validates_presence_of :first_name, :last_name
  validates_uniqueness_of :no

  before_create do
    self.no = Sequence.next("membership_number")
  end

  default_scope order_by(last_name: :asc, first_name: :asc)

  scope :current, -> {
    elem_match(memberships: { year: this_year, start: { "$lte" => Time.now } })
  }

  scope :pending, -> {
    elem_match(memberships: { year: this_year, start: { "$gt" => Time.now } })
  }

  scope :expired, -> {
    where("memberships.year" => { "$ne" => this_year })
  }

  scope :mailing_list, -> {
    current.where(:email_allowed => true, :email.ne => '')
  }

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

  def register
    memberships << Membership.registration
  end

  def renew
    memberships << Membership.renewal
  end

  def current?
    membership.map(&:current?).value_or false
  end

  def pending?
    membership.map(&:pending?).value_or false
  end

  def expired?
    membership.map(&:expired?).value_or false
  end

  def membership
    memberships.last.nil? ? None : Some[memberships.last]
  end

  def to_param
    no
  end

  def self.search(text, allow_empty_search=true)
    full_text_search(text, allow_empty_search: allow_empty_search)
  end

  def self.to_csv
    Member::Adapter::CSV.adapt all
  end

  def self.to_txt
    Member::Adapter::TXT.adapt all
  end

  private

  def this_year
    self.class.this_year
  end

  def self.this_year
    Date.today.year
  end

end
