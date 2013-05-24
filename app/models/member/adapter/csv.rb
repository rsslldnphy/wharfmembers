class Member

  module Adapter
    module CSV
      extend self

      def adapt(members)
        ::CSV.generate do |csv|
          csv << [:name, :email]
          members.each { |member| csv << [member.full_name, member.email] }
        end
      end

    end
  end
end
