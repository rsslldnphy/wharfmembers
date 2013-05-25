class MembersController < ApplicationController
  class Item < Fendhal::Action

    def action
      render locals: { member: member }
    end

    def member
      Member.find_by(no: params[:id])
    end

  end
end
