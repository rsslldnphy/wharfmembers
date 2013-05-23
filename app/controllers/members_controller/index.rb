class MembersController < ApplicationController

  class Index < List

    def members
      Member.all
    end

  end
end
