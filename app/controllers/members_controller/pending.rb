class MembersController < ApplicationController

  class Pending < List

    def members
      Member.unscoped.pending
    end

  end
end
