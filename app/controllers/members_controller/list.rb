class MembersController < ApplicationController

  class List < Fendhal::Action

    def action
      respond_to :html, :csv, :text
    end

    def html
      render locals: { members: page }
    end

    def csv
      send_data members.to_csv
    end

    def text
      render text: members.to_txt
    end

    def page
      members.search(params[:search]).page(params[:page]).per(10)
    end

  end
end
