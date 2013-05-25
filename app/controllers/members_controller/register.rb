class MembersController < ApplicationController
  class Register < Fendhal::Action

    def action
      render layout: false, locals: { member: member }
    end

    def member
      Member.new
    end
  end
end
