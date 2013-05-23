class MembersController < ApplicationController

  class Expired < List

    def members
      Member.expired
    end

  end
end
