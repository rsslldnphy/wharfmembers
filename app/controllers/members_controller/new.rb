class MembersController < ApplicationController
  class New < Fendhal::Action

    def action
      render locals: { member: member }
    end

    def member
      Member.new
    end
  end
end

