class MembershipsController < ApplicationController
  def destroy
    @member = Member.find(params[:member_id])
    @member.memberships.find(params[:id]).destroy
    redirect_to @member
  end
end
