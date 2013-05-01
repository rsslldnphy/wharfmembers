class Member

  module Adapter
    module CSV
      extend self

      def adapt(members)
        ::CSV.generate do |csv|
          csv << columns
          members.each { |member| csv << member.attributes.values_at(*columns) }
        end
      end

      def columns
        [
          :no,
          :first_name,
          :last_name,
          :email,
          :address_one,
          :address_two,
          :address_three,
          :postcode
        ].map(&:to_s)
      end

    end
  end
end
