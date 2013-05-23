class MembersController < ApplicationController

  class MailingList < List

    def members
      Member.mailing_list
    end

  end
end
