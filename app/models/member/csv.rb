class Member

  module CSV
    extend self

    def generate(members)
      ::CSV.generate do |csv|
        csv << columns.map(&:to_s)
        all.each { |member| csv << member.attributes.values_at(*csv_columns) }
      end
    end

    def columns
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
      ]
    end

  end
end
