class MembersController < ApplicationController

  class Pending < List

    def members
      Member.pending
    end

  end
end
