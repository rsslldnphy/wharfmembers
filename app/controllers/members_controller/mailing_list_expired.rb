class MembersController < ApplicationController

  class MailingListExpired < List

    def members
      Member.mailing_list_expired
    end

  end
end
