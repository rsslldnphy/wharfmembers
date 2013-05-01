require 'spec_helper'

class Member
  module Adapter
    describe TXT do

      it "converts the members to a text file format" do
        a = Member.create(first_name: "Russell", last_name: "Dunphy")
        b = Member.create(first_name: "Grace", last_name: "Jones")
        TXT.adapt([a,b]).should eq <<END
no\tname
1\tRussell Dunphy
2\tGrace Jones
END
      end

    end
  end
end
