class MembersController < ApplicationController

  def index
    @members = Member.search(params[:search]).page(params[:page]).per(10)
  end

  def show
    @member = Member.find(params[:id])
  end

  def pending
    @members = Member.pending.page(params[:page]).per(10)
  end

  def expired
    @members = Member.expired.page(params[:page]).per(10)
  end

  def new
    @member = Member.new
  end

  def edit
    @member = Member.find(params[:id])
  end

  def complete
    @member = Member.find(params[:id])
    @member.complete
    redirect_to @member
  end

  def renew
    @member = Member.find(params[:id])
    @member.renew
    redirect_to @member
  end

  def bulk_action
    @members = Member.find(params[:ids])
    if params['complete-registration'].present?
      @members.each(&:complete)
    elsif params['delete-selected'].present?
      @members.each(&:destroy)
    elsif params['renew-selected'].present?
      @members.each(&:renew)
    end
    redirect_to :back
  end

  def create
    @member = Member.new(params[:member])
    if @member.save
      redirect_to @member, notice: 'Member was successfully created.'
    else
      render action: "new"
    end
  end

  def update
    @member = Member.find(params[:id])
    if @member.update_attributes(params[:member])
      redirect_to @member, notice: 'Member was successfully updated.'
    else
      render action: "edit"
    end
  end

  def destroy
    @member = Member.find(params[:id])
    @member.destroy
    redirect_to members_url
  end
end
