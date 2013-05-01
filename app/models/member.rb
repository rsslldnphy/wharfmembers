class Member
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Search

  field :membership_number, type: Integer
  field :first_name, type: String
  field :last_name, type: String
  field :email, type: String
  field :address_one, type: String
  field :address_two, type: String
  field :address_three, type: String
  field :postcode, type: String
  field :notes, type: String
  field :email_allowed, type: Boolean, default: true

  embeds_many :memberships

  index({ membership_number: 1 }, unique: true)

  default_scope order_by(last_name: :asc, first_name: :asc)

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

  def to_param
    membership_number
  end

  private

  def current_year
    Date.today.year
  end

  def self.current
    elem_match(memberships: { year: Date.today.year })
  end

  def self.pending
    self.or({:memberships.exists => false}, {:memberships.with_size => 0})
  end

  def self.expired
    where(:"memberships.year".exists => true).
      not.elem_match(memberships: { year: Date.today.year })
  end

  def self.mailing_list
    where(:email_allowed => true).and({:email.exists => true}, {:email.ne => ''})
  end

  def self.to_csv
    CSV.generate do |csv|
      csv << csv_columns
      all.each do |member|
        csv << member.attributes.values_at(*csv_columns)
      end
    end
  end

  def self.csv_columns
    [
      :membership_number,
      :first_name,
      :last_name,
      :email,
      :phone,
      :address_one,
      :address_two,
      :address_three,
      :postcode
    ].map(&:to_s)
  end

end
