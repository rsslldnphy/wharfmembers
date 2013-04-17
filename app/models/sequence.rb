class Sequence
  include Mongoid::Document

  field :value

  def self.next(name)
    where(name: name).find_and_modify({ "$inc" => { value: 1 }}, new: true, upsert: true).value
  end

end
