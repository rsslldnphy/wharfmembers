class Member
  include Mongoid::Document
  include Mongoid::Timestamps

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
  field :manually_updated, type: Boolean, default: false
  field :lifetime_membership, type: Boolean, default: false

  embeds_many :memberships, cascade_callbacks: true

  index({ no: 1 }, unique: true)
  index({ "memberships.year" => 1, last_name: 1, first_name: 1 })

  validates_presence_of :first_name, :last_name
  validates_uniqueness_of :no

  before_create do
    self.no = Sequence.next("membership_number")
  end

  default_scope order_by(last_name: :asc, first_name: :asc)

  scope :search, ->(params) {
    first, second = (params || "").split(" ")
    if first && second
      where(:first_name => /#{first}/i, :last_name => /#{second}/i)
    elsif first
      self.or({:first_name => /#{first}/i}, {:last_name => /#{first}/i})
    else
      all
    end
  }

  scope :current, -> {
    where("$or" => [ { "lifetime_membership" => true }, { "memberships.year" => { "$gte" =>  this_year } } ])
  }

  scope :pending, -> {
    where("memberships.year" => { "$exists" => false }).order_by(created_at: :asc)
  }

  scope :expired, -> {
    where("lifetime_membership" => false, "memberships.year" => { "$exists" => true, "$not" => { "$gte" => this_year } } )
  }

  scope :mailing_list, -> {
    current.where(:email_allowed => true, :email.ne => '')
  }

  scope :mailing_list_expired, -> {
    expired.where(:email_allowed => true, :email.ne => '')
  }

  def full_name
   "#{first_name} #{last_name}"
  end

  def address
    [address_one, address_two, address_three, postcode].compact
  end

  def complete
    memberships << Membership.register
  end

  def renew
    memberships << Membership.register
  end

  def current?
    lifetime_membership || memberships.any?(&:current?)
  end

  def pending?
    membership.none?
  end

  def expired?
    !lifetime_membership && memberships.none?(&:current?) && memberships.any?(&:expired?)
  end

  def membership
    Option[memberships.last]
  end

  def to_param
    no
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
    Date.today.month < 5 ? Date.today.year - 1 : Date.today.year
  end

end
