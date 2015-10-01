class MembersController < ApplicationController

  class Lifetime < List

    def members
      Member.lifetime
    end

  end
end
