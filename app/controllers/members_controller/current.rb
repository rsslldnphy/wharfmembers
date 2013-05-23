class MembersController < ApplicationController

  class Current < List

    def members
      Member.current
    end

  end
end
