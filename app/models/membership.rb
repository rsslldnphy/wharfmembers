class Membership
  include Mongoid::Document
  include Mongoid::Timestamps

  field :year, type: Integer
  field :start, type: Time

  embedded_in :member

  def to_s
    "Year: #{year}\tRegistered on: #{created_at.strftime('%d-%m-%Y')}"
  end

  def current?
    year >= this_year
  end

  def expired?
    year < this_year
  end

  def this_year
    self.class.this_year
  end

  def self.this_year
    Date.today.month < 5 ? Date.today.year - 1 : Date.today.year
  end

  def self.register
    new year: Date.today.year, start: Time.now
  end

end
