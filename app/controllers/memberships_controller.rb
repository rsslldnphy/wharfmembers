class MembershipsController < ApplicationController
  def destroy
    @member = Member.find_by(no: params[:member_id])
    @member.memberships.find(params[:id]).destroy
    redirect_to member_path(id: @member.no)
  end
end
