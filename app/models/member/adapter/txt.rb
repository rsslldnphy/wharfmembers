class Member

  module Adapter
    module TXT
      extend self

      def adapt(members)
        headers + "\n" + data(members) + "\n"
      end

      def headers
        "no\tname"
      end

      def data(members)
        members.map do |member|
          columns.map { |c| member.send(c).to_s }.join("\t")
        end.join("\n")
      end

      def columns
        [
          :no,
          :full_name
        ]
      end
    end
  end
end
